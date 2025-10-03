# Guia de Padrões de Desenvolvimento - Dart & Flutter

## 🏷️ Convenções de Nomenclatura

### Arquivos e Diretórios

- **Arquivos**: Use `snake_case` (minúsculas com underscore)

  ✅ Correto: user_profile.dart, auth_service.dart
  ❌ Incorreto: UserProfile.dart, authService.dart

- **Diretórios**: Use `snake_case`

  ✅ Correto: lib/screens/, lib/models/, lib/services/
  ❌ Incorreto: lib/Screens/, lib/Models/

### Classes e Tipos

- **Classes**: Use `PascalCase`

  ```dart
  class UserProfile {}
  class AuthenticationService {}
  ```

- **Interfaces/Abstract Classes**: Use `PascalCase`

  ```dart
  abstract class DatabaseRepository {}
  abstract class ApiClient {}
  ```

### Variáveis e Funções

- **Variáveis**: Use `camelCase`

  ```dart
  String userName = 'João';
  int totalUsers = 100;
  bool isAuthenticated = false;
  ```

- **Funções**: Use `camelCase`

  ```dart
  void saveUserData() {}
  String getUserName() {}
  Future<void> loadUserProfile() async {}
  ```

- **Constantes**: Use `lowerCamelCase`

  ```dart
  const String apiBaseUrl = 'https://api.example.com';
  const int maxRetries = 3;
  ```

- **Variáveis Privadas**: Prefixo com underscore `_`

  ```dart
  String _privateVariable = 'private';
  void _privateMethod() {}
  ```

---

## 📁 Estrutura de Arquivos e Diretórios

### Organização Recomendada

```bash
lib/
├── main.dart                 # Ponto de entrada da aplicação
├── data/                     # Camada de dados
│   ├── models/              # Modelos de dados
│   ├── repositories/        # Repositórios de dados
│   └── services/            # Serviços externos (API, etc.)
├── screens/                 # Telas da aplicação
│   ├── auth/               # Telas de autenticação
│   ├── home/               # Tela inicial
│   └── profile/            # Telas de perfil
├── widgets/                # Widgets reutilizáveis
│   ├── common/             # Widgets comuns
│   └── custom/             # Widgets customizados
├── utils/                  # Utilitários e helpers
│   ├── constants.dart      # Constantes globais
│   ├── helpers.dart        # Funções auxiliares
│   ├── routes.dart         # Rotas da aplicação
│   └── theme.dart          # Tema da aplicação
└── core/                   # Funcionalidades core
    ├── errors/             # Tratamento de erros
    ├── network/            # Configurações de rede
    └── storage/            # Armazenamento local
```

### Nomenclatura de Arquivos por Categoria

#### Telas (Screens)

```dart
// Arquivo: lib/screens/auth/login_screen.dart
class LoginScreen extends StatefulWidget {}

// Arquivo: lib/screens/profile/user_profile_screen.dart
class UserProfileScreen extends StatelessWidget {}
```

#### Widgets

```dart
// Arquivo: lib/widgets/common/custom_button.dart
class CustomButton extends StatelessWidget {}

// Arquivo: lib/widgets/custom/user_avatar.dart
class UserAvatar extends StatefulWidget {}
```

#### Modelos

```dart
// Arquivo: lib/data/models/user_model.dart
class UserModel {}

// Arquivo: lib/data/models/case_model.dart
class CaseModel {}
```

---

## 🏗️ Padrões de Classes

### 1. Estrutura Básica de uma Classe

```dart
/// Documentação da classe
class UserProfile {
  // 1. Constantes da classe
  static const String defaultAvatar = 'assets/default_avatar.png';

  // 2. Propriedades privadas
  final String _id;
  final String _email;

  // 3. Propriedades públicas
  final String name;
  final int age;

  // 4. Construtor principal
  const UserProfile({
    required String id,
    required this.name,
    required this.age,
    required String email,
  }) : _id = id,
       _email = email;

  // 5. Construtores nomeados
  UserProfile.empty()
      : _id = '',
        name = '',
        age = 0,
        _email = '';

  // 6. Getters
  String get id => _id;
  String get email => _email;
  bool get isAdult => age >= 18;

  // 7. Métodos públicos
  Map<String, dynamic> toJson() {
    return {
      'id': _id,
      'name': name,
      'age': age,
      'email': _email,
    };
  }

  // 8. Métodos estáticos
  static UserProfile fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'] as String,
      name: json['name'] as String,
      age: json['age'] as int,
      email: json['email'] as String,
    );
  }

  // 9. Overrides
  @override
  String toString() => 'UserProfile(id: $_id, name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserProfile && other._id == _id;
  }

  @override
  int get hashCode => _id.hashCode;
}
```

### 2. Widget StatelessWidget

```dart
/// Widget para exibir informações do usuário
class UserInfoWidget extends StatelessWidget {
  // Propriedades finais
  final UserProfile user;
  final VoidCallback? onTap;

  // Construtor com key
  const UserInfoWidget({
    super.key,
    required this.user,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(user.name),
        subtitle: Text(user.email),
        onTap: onTap,
      ),
    );
  }
}
```

### 3. Widget StatefulWidget

```dart
/// Widget para formulário de usuário
class UserFormWidget extends StatefulWidget {
  final UserProfile? initialUser;
  final Function(UserProfile) onSubmit;

  const UserFormWidget({
    super.key,
    this.initialUser,
    required this.onSubmit,
  });

  @override
  State<UserFormWidget> createState() => _UserFormWidgetState();
}

class _UserFormWidgetState extends State<UserFormWidget> {
  // Controllers
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;

  // Form key
  final _formKey = GlobalKey<FormState>();

  // Estado interno
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(
      text: widget.initialUser?.name ?? '',
    );
    _emailController = TextEditingController(
      text: widget.initialUser?.email ?? '',
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: 'Nome'),
            validator: _validateName,
          ),
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(labelText: 'Email'),
            validator: _validateEmail,
          ),
          ElevatedButton(
            onPressed: _isLoading ? null : _submitForm,
            child: _isLoading
                ? const CircularProgressIndicator()
                : const Text('Salvar'),
          ),
        ],
      ),
    );
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Nome é obrigatório';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email é obrigatório';
    }
    if (!value.contains('@')) {
      return 'Email inválido';
    }
    return null;
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final user = UserProfile(
        id: widget.initialUser?.id ?? DateTime.now().toString(),
        name: _nameController.text,
        age: 25, // Exemplo
        email: _emailController.text,
      );

      widget.onSubmit(user);
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}
```

---

## 📝 Declaração de Variáveis

### 1. Tipos de Variáveis

```dart
// Variáveis mutáveis
String name = 'João';
int age = 30;
double height = 1.75;
bool isActive = true;
List<String> items = ['item1', 'item2'];
Map<String, int> scores = {'joão': 100, 'maria': 95};

// Variáveis imutáveis
final String finalName = 'João'; // Valor definido em runtime
const String constName = 'João'; // Valor definido em compile time

// Variáveis com tipo inferido
var userName = 'João'; // String inferido
var userAge = 30; // int inferido

// Variáveis nullable
String? nullableName;
int? nullableAge;

// Late variables (inicialização tardia)
late String lateInitialized;
```

### 2. Inicialização de Variáveis

```dart
class UserService {
  // Propriedades com valores padrão
  String status = 'inactive';
  int retryCount = 0;

  // Propriedades nullable
  String? token;
  UserProfile? currentUser;

  // Propriedades late
  late DatabaseHelper _database;

  // Propriedades finais inicializadas no construtor
  final String apiUrl;
  final Duration timeout;

  UserService({
    required this.apiUrl,
    this.timeout = const Duration(seconds: 30),
  });

  // Inicialização de late variables
  void initialize() {
    _database = DatabaseHelper();
  }
}
```

### 3. Coleções

```dart
// Listas
List<String> mutableList = ['item1', 'item2'];
final List<String> finalList = ['item1', 'item2'];
const List<String> constList = ['item1', 'item2'];

// Lista vazia tipada
List<UserProfile> users = <UserProfile>[];
// ou
List<UserProfile> users = [];

// Maps
Map<String, dynamic> userData = {
  'name': 'João',
  'age': 30,
  'isActive': true,
};

// Sets
Set<String> uniqueIds = {'id1', 'id2', 'id3'};
```

---

## 📦 Importações e Dependências

### 1. Ordem das Importações

```dart
// 1. Importações do Dart core
import 'dart:async';
import 'dart:convert';

// 2. Importações de pacotes externos
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

// 3. Importações do projeto (relativas)
import '../models/user_model.dart';
import '../services/auth_service.dart';
import '../utils/constants.dart';
import '../widgets/custom_button.dart';
```

### 2. Aliases para Importações

```dart
// Para evitar conflitos de nomes
import 'dart:io' as io;
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show SystemNavigator;

// Uso com alias
final file = io.File('path/to/file');
final response = await http.get(Uri.parse(url));
```

### 3. Importações Condicionais

```dart
// Para diferentes plataformas
import 'package:flutter/foundation.dart';

void debugPrint(String message) {
  if (kDebugMode) {
    print(message);
  }
}
```

---

## 📖 Comentários e Documentação

### 1. Documentação de Classes

```dart
/// Representa um usuário do sistema.
///
/// Esta classe encapsula todas as informações necessárias
/// para representar um usuário, incluindo dados pessoais
/// e configurações de conta.
///
/// Exemplo de uso:
/// ```dart
/// final user = UserProfile(
///   id: '123',
///   name: 'João Silva',
///   age: 30,
///   email: 'joao@example.com',
/// );
/// ```
class UserProfile {
  /// Identificador único do usuário.
  final String id;

  /// Nome completo do usuário.
  final String name;

  /// Idade do usuário em anos.
  final int age;

  /// Endereço de email do usuário.
  final String email;
}
```

### 2. Documentação de Métodos

```dart
/// Salva o perfil do usuário no banco de dados.
///
/// Parâmetros:
/// * [user]: O perfil do usuário a ser salvo
/// * [validateEmail]: Se deve validar o email antes de salvar
///
/// Retorna `true` se o usuário foi salvo com sucesso,
/// `false` caso contrário.
///
/// Throws [ValidationException] se os dados forem inválidos.
/// Throws [DatabaseException] se houver erro na operação.
Future<bool> saveUserProfile(
  UserProfile user, {
  bool validateEmail = true,
}) async {
  // Implementação aqui
}
```

### 3. Comentários de Código

```dart
class AuthService {
  Future<String?> login(String email, String password) async {
    // TODO: Implementar cache de tokens
    // FIXME: Validar formato do email antes de enviar

    try {
      // Envia requisição para API
      final response = await _apiClient.post('/login', {
        'email': email,
        'password': password,
      });

      if (response.statusCode == 200) {
        // Extrai token da resposta
        final data = json.decode(response.body);
        return data['token'] as String;
      }

      return null;
    } catch (e) {
      // Log do erro para debugging
      debugPrint('Erro no login: $e');
      rethrow;
    }
  }
}
```

---

## 🎨 Formatação e Estilo

### 1. Indentação e Espaçamento

- Use **2 espaços** para indentação
- Linha máxima de **80 caracteres**
- Quebra de linha antes de chaves de abertura em classes e métodos

```dart
// ✅ Correto
class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Text('Hello'),
          const Text('World'),
        ],
      ),
    );
  }
}
```

### 2. Vírgulas Finais (Trailing Commas)

```dart
// ✅ Use vírgulas finais em listas de parâmetros e widgets
Widget build(BuildContext context) {
  return Column(
    children: [
      Text('Item 1'),
      Text('Item 2'),
      Text('Item 3'), // <- vírgula final
    ], // <- vírgula final
  );
}
```

### 3. Strings e Interpolação

```dart
// ✅ Use aspas simples para strings
const String message = 'Hello World';

// ✅ Use interpolação para concatenar
String greeting = 'Hello, $userName!';
String fullMessage = 'User $userName has ${user.age} years old';

// ✅ Para strings multilinha
const String longText = '''
This is a long text
that spans multiple lines
and maintains formatting.
''';
```

---

## ✨ Boas Práticas

### 1. Null Safety

```dart
// ✅ Use null safety adequadamente
String? getName() => _name;

void setName(String? name) {
  _name = name ?? 'Unknown';
}

// ✅ Use operadores null-aware
final length = userName?.length ?? 0;
userProfile?.save();
```

### 2. Async/Await

```dart
// ✅ Sempre use async/await para código assíncrono
Future<List<User>> loadUsers() async {
  try {
    final response = await apiClient.getUsers();
    return response.data.map((json) => User.fromJson(json)).toList();
  } catch (e) {
    debugPrint('Error loading users: $e');
    return [];
  }
}
```

### 3. Error Handling

```dart
// ✅ Trate erros adequadamente
Future<UserProfile?> getUserProfile(String id) async {
  try {
    final response = await _apiClient.get('/users/$id');

    if (response.statusCode == 200) {
      return UserProfile.fromJson(response.data);
    } else if (response.statusCode == 404) {
      return null; // Usuário não encontrado
    } else {
      throw ApiException('Failed to load user: ${response.statusCode}');
    }
  } on SocketException {
    throw NetworkException('No internet connection');
  } on FormatException {
    throw DataException('Invalid response format');
  } catch (e) {
    throw UnknownException('Unexpected error: $e');
  }
}
```

### 4. Performance

```dart
// ✅ Use const constructors quando possível
const Text('Static text');
const SizedBox(height: 16);

// ✅ Evite criar objetos desnecessários no build
class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  // ✅ Defina styles como static const
  static const TextStyle _titleStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    return Text(
      'Title',
      style: _titleStyle, // Reutiliza o mesmo objeto
    );
  }
}
```

### 5. Organização de Código

```dart
// ✅ Agrupe imports relacionados
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';
import 'package:http/http.dart';

import '../models/user_model.dart';
import '../services/user_service.dart';

// ✅ Use extensões para funcionalidades específicas
extension StringExtensions on String {
  bool get isValidEmail => contains('@') && contains('.');

  String get capitalized =>
      isEmpty ? this : this[0].toUpperCase() + substring(1);
}

// ✅ Separe lógica de negócio da UI
class UserRepository {
  Future<List<User>> getUsers() async {
    // Lógica de busca de dados
  }
}

class UserListWidget extends StatelessWidget {
  final UserRepository repository;

  const UserListWidget({
    super.key,
    required this.repository,
  });

  // UI apenas
}
```

---

## 🔧 Configuração do Projeto

### 1. Analysis Options

Certifique-se de que o arquivo `analysis_options.yaml` está configurado:

```yaml
include: package:flutter_lints/flutter.yaml

linter:
  rules:
    prefer_single_quotes: true
    prefer_const_constructors: true
    prefer_const_literals_to_create_immutables: true
    avoid_unnecessary_containers: true
```

### 2. Comandos Úteis

```bash
# Formatar código
flutter format .

# Analisar código
flutter analyze

# Executar testes
flutter test

# Verificar dependências desatualizadas
flutter pub outdated
```

---

## 📚 Recursos Adicionais

- [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style)
- [Flutter Style Guide](https://github.com/flutter/flutter/wiki/Style-guide-for-Flutter-repo)
- [Effective Dart](https://dart.dev/guides/language/effective-dart)

---

**Mantenha este documento atualizado conforme o projeto evolui!**

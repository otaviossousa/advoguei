import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../data/constants.dart';
import '../models/document_model.dart';
import '../providers/auth_provider.dart';
import '../providers/document_provider.dart';
import '../providers/process_provider.dart';
import '../services/error_handler_service.dart';
import '../widgets/form_widgets.dart';

class DocumentFormScreen extends ConsumerStatefulWidget {
  const DocumentFormScreen({super.key});

  @override
  ConsumerState<DocumentFormScreen> createState() => _DocumentFormScreenState();
}

class _DocumentFormScreenState extends ConsumerState<DocumentFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nomeController;
  late final TextEditingController _observacaoController;

  String _selectedTipo = 'Identificação';
  String? _selectedCliente;
  String? _selectedProcesso;
  DateTime _selectedDate = DateTime.now();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nomeController = TextEditingController();
    _observacaoController = TextEditingController();
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _observacaoController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _handleSaveDocument() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final newDocument = Document(
        id: const Uuid().v4(),
        nome: _nomeController.text.trim(),
        tipo: _selectedTipo,
        data: _selectedDate,
        clienteVinculado:
            _selectedCliente != null && _selectedCliente != 'Nenhum'
            ? [_selectedCliente!]
            : null,
        processoVinculado:
            _selectedProcesso != null && _selectedProcesso != 'Nenhum'
            ? [_selectedProcesso!]
            : null,
        observacao: _observacaoController.text.trim().isEmpty
            ? null
            : _observacaoController.text.trim(),
        ownerId: ref.read(authProvider)?.id,
        isGlobal: false,
      );

      await ref.read(documentProvider.notifier).addDocument(newDocument);

      if (mounted) {
        ErrorHandlerService.showSuccessSnackBar(
          context,
          message: 'Documento adicionado com sucesso!',
        );
        Navigator.pop(context, newDocument);
      }
    } catch (e, stackTrace) {
      ErrorHandlerService.logError('DocumentFormScreen', e, stackTrace);
      if (mounted) {
        ErrorHandlerService.showErrorSnackBar(
          context,
          message: 'Erro ao salvar documento: $e',
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final processos = ref.watch(processProvider);

    // Extrair nomes de clientes únicos dos processos
    final clientesSet = <String>{};
    for (final processo in processos) {
      clientesSet.add(processo.cliente);
    }
    final clientes = ['Nenhum', ...clientesSet];

    // Extrair números de processos
    final processosNumbers = [
      'Nenhum',
      ...processos.map((p) => p.numero),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Adicionar Documento')),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Informações do Documento
              const SectionTitle(title: 'Informações do Documento'),
              const SizedBox(height: 16),
              CustomTextFormField(
                label: 'Nome do Documento *',
                hint: 'Ex: RG João Silva',
                controller: _nomeController,
                validator: (value) =>
                    ErrorHandlerService.validateRequired(value, 'Nome'),
              ),
              const SizedBox(height: 16),
              CustomDropdownField(
                label: 'Tipo de Documento *',
                value: _selectedTipo,
                items: DocumentTypes.tiposDocumento,
                onChanged: (value) {
                  setState(() {
                    _selectedTipo = value ?? 'Identificação';
                  });
                },
              ),
              const SizedBox(height: 16),
              CustomDateField(
                label: 'Data do Documento *',
                selectedDate: _selectedDate,
                onTap: () => _selectDate(context),
              ),
              const SizedBox(height: 24),

              // Vinculações
              const SectionTitle(title: 'Vinculações (Opcional)'),
              const SizedBox(height: 16),
              CustomDropdownField(
                label: 'Vincular Cliente',
                value: _selectedCliente ?? 'Nenhum',
                items: clientes,
                onChanged: (value) {
                  setState(() {
                    _selectedCliente = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              CustomDropdownField(
                label: 'Vincular Processo',
                value: _selectedProcesso ?? 'Nenhum',
                items: processosNumbers,
                onChanged: (value) {
                  setState(() {
                    _selectedProcesso = value;
                  });
                },
              ),
              const SizedBox(height: 24),

              // Observações
              const SectionTitle(title: 'Observações'),
              const SizedBox(height: 16),
              CustomTextFormField(
                label: 'Observações',
                hint: 'Ex: Documento digitalizado em alta qualidade',
                controller: _observacaoController,
                maxLines: 3,
              ),
              const SizedBox(height: 32),

              // Botão Adicionar
              CustomButton(
                text: 'Adicionar Documento',
                isLoading: _isLoading,
                onPressed: _isLoading ? null : _handleSaveDocument,
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

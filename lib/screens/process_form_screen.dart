import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../data/constants.dart';
import '../models/process_model.dart';
import '../providers/process_provider.dart';
import '../services/error_handler_service.dart';
import '../widgets/form_widgets.dart';

class ProcessFormScreen extends ConsumerStatefulWidget {
  const ProcessFormScreen({super.key});

  @override
  ConsumerState<ProcessFormScreen> createState() => _ProcessFormScreenState();
}

class _ProcessFormScreenState extends ConsumerState<ProcessFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _numeroController;
  late final TextEditingController _clienteController;
  late final TextEditingController _cpfCnpjController;
  late final TextEditingController _contatoController;
  late final TextEditingController _descricaoController;
  late final TextEditingController _valorController;
  late final TextEditingController _comarcaController;
  late final TextEditingController _varaController;
  late final TextEditingController _juizController;
  late final TextEditingController _observacoesController;

  String _selectedTipo = 'Ação Cível';
  String _selectedStatus = 'Em Andamento';
  DateTime _selectedDate = DateTime.now();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _numeroController = TextEditingController();
    _clienteController = TextEditingController();
    _cpfCnpjController = TextEditingController();
    _contatoController = TextEditingController();
    _descricaoController = TextEditingController();
    _valorController = TextEditingController();
    _comarcaController = TextEditingController();
    _varaController = TextEditingController();
    _juizController = TextEditingController();
    _observacoesController = TextEditingController();
  }

  @override
  void dispose() {
    _numeroController.dispose();
    _clienteController.dispose();
    _cpfCnpjController.dispose();
    _contatoController.dispose();
    _descricaoController.dispose();
    _valorController.dispose();
    _comarcaController.dispose();
    _varaController.dispose();
    _juizController.dispose();
    _observacoesController.dispose();
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

  Future<void> _handleSaveProcess() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final newProcess = Process(
        id: const Uuid().v4(),
        numero: _numeroController.text.trim(),
        cliente: _clienteController.text.trim(),
        tipo: _selectedTipo,
        status: _selectedStatus,
        dataAbertura: _selectedDate,
        cpfCnpjCliente: _cpfCnpjController.text.trim().isEmpty
            ? null
            : _cpfCnpjController.text.trim(),
        contatoCliente: _contatoController.text.trim().isEmpty
            ? null
            : _contatoController.text.trim(),
        descricao: _descricaoController.text.trim(),
        valorCausa: _valorController.text.trim().isEmpty
            ? null
            : _valorController.text.trim(),
        comarca: _comarcaController.text.trim().isEmpty
            ? null
            : _comarcaController.text.trim(),
        vara: _varaController.text.trim().isEmpty
            ? null
            : _varaController.text.trim(),
        nomeJuiz: _juizController.text.trim().isEmpty
            ? null
            : _juizController.text.trim(),
        observacoes: _observacoesController.text.trim().isEmpty
            ? null
            : _observacoesController.text.trim(),
      );

      await ref.read(processProvider.notifier).addProcess(newProcess);

      if (mounted) {
        ErrorHandlerService.showSuccessSnackBar(
          context,
          message: 'Processo adicionado com sucesso!',
        );
        Navigator.pop(context, newProcess);
      }
    } catch (e, stackTrace) {
      ErrorHandlerService.logError('ProcessFormScreen', e, stackTrace);
      if (mounted) {
        ErrorHandlerService.showErrorSnackBar(
          context,
          message: 'Erro ao salvar processo: $e',
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo Processo'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Informações Básicas
              const SectionTitle(title: 'Informações Básicas'),
              const SizedBox(height: 16),
              CustomTextFormField(
                label: 'Número do Processo *',
                hint: 'Número com 20 dígitos',
                controller: _numeroController,
                keyboardType: TextInputType.number,
                validator: (value) =>
                    ErrorHandlerService.validateProcessNumber(value),
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                label: 'Nome do Cliente *',
                hint: 'Ex: João Silva Santos',
                controller: _clienteController,
                validator: (value) => ErrorHandlerService.validateRequired(
                  value,
                  'Nome do Cliente',
                ),
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                label: 'CPF/CNPJ do Cliente *',
                hint: 'Ex: 123.456.789-00',
                controller: _cpfCnpjController,
                keyboardType: TextInputType.number,
                validator: (value) =>
                    ErrorHandlerService.validateNumber(value, 'CPF/CNPJ'),
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                label: 'Contato do Cliente',
                hint: 'Ex: (86) 99999-9999',
                controller: _contatoController,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16),
              CustomDropdownField(
                label: 'Tipo de Processo *',
                value: _selectedTipo,
                items: ProcessTypes.tiposProcesso,
                onChanged: (value) {
                  setState(() {
                    _selectedTipo = value ?? 'Ação Cível';
                  });
                },
              ),
              const SizedBox(height: 16),
              CustomDropdownField(
                label: 'Status *',
                value: _selectedStatus,
                items: ProcessTypes.statusOptions,
                onChanged: (value) {
                  setState(() {
                    _selectedStatus = value ?? 'Em Andamento';
                  });
                },
              ),
              const SizedBox(height: 16),
              CustomDateField(
                label: 'Data de Abertura *',
                selectedDate: _selectedDate,
                onTap: () => _selectDate(context),
              ),
              const SizedBox(height: 32),

              // Detalhes do Processo
              const SectionTitle(title: 'Detalhes do Processo'),
              const SizedBox(height: 16),
              CustomTextFormField(
                label: 'Descrição do Processo *',
                hint: 'Descreva brevemente o objeto da ação...',
                controller: _descricaoController,
                maxLines: 3,
                validator: (value) =>
                    ErrorHandlerService.validateRequired(value, 'Descrição'),
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                label: 'Valor da Causa',
                hint: 'Ex: 1500.50',
                controller: _valorController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) =>
                    ErrorHandlerService.validateCurrency(value, 'Valor'),
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                label: 'Comarca/Foro',
                hint: 'Ex: Foro Central - Parnaíba',
                controller: _comarcaController,
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                label: 'Vara/Juízo',
                hint: 'Ex: 1ª Vara Cível',
                controller: _varaController,
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                label: 'Nome do Juiz',
                hint: 'Ex: Dr. Marcel Moura',
                controller: _juizController,
              ),

              const SizedBox(height: 32),

              // Observações
              const SectionTitle(title: 'Observações'),
              const SizedBox(height: 16),
              CustomTextFormField(
                label: 'Observações Gerais',
                hint: 'Observações adicionais sobre o processo...',
                controller: _observacoesController,
                maxLines: 4,
              ),

              const SizedBox(height: 32),

              // Botão de Salvar
              CustomButton(
                text: 'Cadastrar Processo',
                isLoading: _isLoading,
                onPressed: _isLoading ? null : _handleSaveProcess,
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

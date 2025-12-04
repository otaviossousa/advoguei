import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/auth_provider.dart';
import '../providers/process_provider.dart';
import '../providers/filter_provider.dart';
import '../utils/routes.dart';
import '../widgets/process_card.dart';

class ProcessListScreen extends ConsumerStatefulWidget {
  const ProcessListScreen({super.key});

  @override
  ConsumerState<ProcessListScreen> createState() => _ProcessListScreenState();
}

class _ProcessListScreenState extends ConsumerState<ProcessListScreen> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    final initial = ref.read(filterProvider).processQuery;
    _controller = TextEditingController(text: initial);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final processos = ref.watch(filteredProcessProvider);
    final isLoading = ref.watch(processLoadingProvider);
    final currentUser = ref.watch(authProvider);
    final isReadOnly = currentUser?.id == 'caua';

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _controller,
                  onChanged: (value) {
                    ref.read(filterProvider.notifier).setProcessQuery(value);
                  },
                  decoration: const InputDecoration(
                    hintText: 'Buscar ou filtrar processos...',
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: Icon(Icons.filter_list),
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            // Lista de processos
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : processos.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.gavel, size: 64, color: Colors.grey),
                        SizedBox(height: 16),
                        Text(
                          'Nenhum processo cadastrado',
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Clique no botão + para adicionar um processo',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: processos.length,
                    itemBuilder: (context, index) {
                      final processo = processos[index];
                      return ProcessCard(
                        processo: processo,
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.processDetailScreen,
                            arguments: processo,
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: isReadOnly
          ? null
          : FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.processFormScreen);
              },
              backgroundColor: Theme.of(context).primaryColor,
              child: const Icon(Icons.add, color: Colors.white),
            ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/process_provider.dart';
import '../utils/routes.dart';
import '../widgets/process_card.dart';

class ProcessListScreen extends ConsumerWidget {
  const ProcessListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final processos = ref.watch(processProvider);
    final isLoading = ref.watch(processLoadingProvider);

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.processFormScreen);
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

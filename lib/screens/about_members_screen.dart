// Tela com infos sobre os membros do grupo de desenvolvimento

import 'package:flutter/material.dart';


class AboutMembersScreen extends StatelessWidget {
  const AboutMembersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final members = const [
      {'name': 'Otávio Sousa', 'role': 'Tech Lead'},
      {'name': 'Fernanda Farias', 'role': 'Design & Desenvolvimento'},
      {'name': 'Cauã Wesly', 'role': 'Desenvolvimento'},
      {'name': 'Elinne Pacheco', 'role': 'Desenvolvimento'},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Time de Desenvolvimento')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const SizedBox(height: 16),
            const Text('Membros do Grupo', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ...members.map((m) => ListTile(
                  leading: const Icon(Icons.person),
                  title: Text(m['name']!),
                  subtitle: Text(m['role']!),
                )),
          ],
        ),
      ),
    );
  }
}
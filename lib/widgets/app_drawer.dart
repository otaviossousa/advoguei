import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            margin: EdgeInsets.zero,
            padding: EdgeInsetsGeometry.all(16),
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.gavel,
                    size: 35,
                    color: Color(0xFF1565C0),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Advoguei',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'Gestão Jurídica',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildDrawerItem(
                  context,
                  icon: Icons.dashboard,
                  title: 'Dashboard',
                  onTap: () {
                    Navigator.pop(context);
                    // Navegar para dashboard
                  },
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.gavel,
                  title: 'Processos',
                  onTap: () {
                    Navigator.pop(context);
                    // Já está na tela de processos
                  },
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.people,
                  title: 'Clientes',
                  onTap: () {
                    Navigator.pop(context);
                    // Navegar para clientes
                  },
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.folder,
                  title: 'Documentos',
                  onTap: () {
                    Navigator.pop(context);
                    // Navegar para documentos
                  },
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.calendar_today,
                  title: 'Agenda',
                  onTap: () {
                    Navigator.pop(context);
                    // Navegar para agenda
                  },
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.analytics,
                  title: 'Relatórios',
                  onTap: () {
                    Navigator.pop(context);
                    // Navegar para relatórios
                  },
                ),
                const Divider(),
                _buildDrawerItem(
                  context,
                  icon: Icons.account_balance,
                  title: 'Financeiro',
                  onTap: () {
                    Navigator.pop(context);
                    // Navegar para financeiro
                  },
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.calculate,
                  title: 'Calculadora Jurídica',
                  onTap: () {
                    Navigator.pop(context);
                    // Navegar para calculadora
                  },
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.book,
                  title: 'Jurisprudência',
                  onTap: () {
                    Navigator.pop(context);
                    // Navegar para jurisprudência
                  },
                ),
                const Divider(),
                _buildDrawerItem(
                  context,
                  icon: Icons.settings,
                  title: 'Configurações',
                  onTap: () {
                    Navigator.pop(context);
                    _showConfiguracoes(context);
                  },
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.help,
                  title: 'Ajuda',
                  onTap: () {
                    Navigator.pop(context);
                    _showAjuda(context);
                  },
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.info,
                  title: 'Sobre',
                  onTap: () {
                    Navigator.pop(context);
                    _showSobre(context);
                  },
                ),
              ],
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(Icons.person, color: Colors.grey[600]),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dr. Advogueido',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                    Text(
                      'OAB/PI 123.456',
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).primaryColor),
      title: Text(title),
      onTap: onTap,
    );
  }

  void _showConfiguracoes(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Configurações'),
          content: const Text(
            'Funcionalidade em desenvolvimento.\n\n'
            '• Dados pessoais\n'
            '• Preferências do sistema\n'
            '• Backup e sincronização',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Fechar'),
            ),
          ],
        );
      },
    );
  }

  void _showAjuda(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Ajuda'),
          content: const Text(
            'Como usar o Advoguei:\n\n'
            '1. Use a aba "Processos" para gerenciar seus processos\n'
            '2. Clique em "Novo Processo" para cadastrar\n'
            '3. Use as outras abas para acessar clientes, documentos e relatórios\n'
            '4. O menu lateral oferece funcionalidades avançadas\n\n'
            'Para suporte técnico, entre em contato conosco.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Entendi'),
            ),
          ],
        );
      },
    );
  }

  void _showSobre(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Sobre o Advoguei'),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.gavel, size: 64, color: Color(0xFF1565C0)),
              SizedBox(height: 16),
              Text(
                'Advoguei',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text('Versão 1.0.0'),
              SizedBox(height: 16),
              Text(
                'Sistema de gestão jurídica desenvolvido para facilitar o gerenciamento de processos, clientes e documentos para advogados e escritórios de advocacia.',
                textAlign: TextAlign.justify,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Fechar'),
            ),
          ],
        );
      },
    );
  }
}

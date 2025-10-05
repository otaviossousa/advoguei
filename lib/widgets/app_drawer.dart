import 'package:flutter/material.dart';

import '../utils/theme.dart';

import '../utils/routes.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            margin: EdgeInsets.zero,
            padding: EdgeInsets.all(16),
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
                    color: AppTheme.primaryBlue,
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
                  icon: Icons.people,
                  title: 'Clientes',
                  onTap: () {
                    Navigator.pop(context);
                    // Navegar para clientes
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
                  onTap: () {},
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.help,
                  title: 'Ajuda',
                  onTap: () {},
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
                _buildDrawerItem(
                  context,
                  icon: Icons.info,
                  title: 'Desenvolvedores',
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushNamed(AppRoutes.aboutScreen);
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

  void _showSobre(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Sobre o Advoguei'),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.gavel, size: 64, color: AppTheme.primaryBlue),
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

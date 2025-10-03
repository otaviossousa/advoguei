import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';
import 'process_list_screen.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage;
    String activePageTitle;

    switch (_selectedPageIndex) {
      case 0:
        activePage = const Center(
          child: Text('Dashboard', style: TextStyle(fontSize: 24)),
        );
        activePageTitle = 'Dashboard';
        break;
      case 1:
        activePage = const ProcessListScreen();
        activePageTitle = 'Processos';
        break;
      case 2:
        activePage = const Center(
          child: Text('Documentos', style: TextStyle(fontSize: 24)),
        );
        activePageTitle = 'Documentos';
        break;
      case 3:
        activePage = const Center(
          child: Text('Relatórios', style: TextStyle(fontSize: 24)),
        );
        activePageTitle = 'Relatórios';
        break;
      default:
        activePage = const ProcessListScreen();
        activePageTitle = 'Processos';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Ação de notificações
            },
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.gavel),
            label: 'Processos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.folder),
            label: 'Documentos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: 'Relatórios',
          ),
        ],
      ),
    );
  }
}

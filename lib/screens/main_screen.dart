import 'package:flutter/material.dart';

import '../widgets/app_drawer.dart';
import 'document_list_screen.dart';
import 'process_list_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
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
        activePage = const ProcessListScreen();
        activePageTitle = 'Processos';
        break;
      case 1:
        activePage = const DocumentListScreen();
        activePageTitle = 'Documentos';
        break;
      case 2:
        activePage = const Center(
          child: Text('Agenda', style: TextStyle(fontSize: 24)),
        );
        activePageTitle = 'Agenda';
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
            icon: Icon(Icons.gavel),
            label: 'Processos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.folder),
            label: 'Documentos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Agenda',
          ),
        ],
      ),
    );
  }
}

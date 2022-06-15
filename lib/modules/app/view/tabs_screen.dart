import 'package:precomedio/components/main_drawer.dart';
import 'package:precomedio/modules/app/view/app_screen.dart';
import 'package:precomedio/modules/compra/view/compra_screen.dart';
import 'package:flutter/material.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({Key? key}) : super(key: key);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _indexSelectedScreen = 0;
  final List<String> _titles = ['Ações em custódia', 'Compras'];

  // ignore: prefer_const_constructors
  final List<Widget> _screens = [ListaScreen(), CompraScreen()];

  _selectScreen(int index) {
    setState(() {
      _indexSelectedScreen = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_titles[_indexSelectedScreen])),
      body: _screens[_indexSelectedScreen],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectScreen,
        selectedItemColor: Theme.of(context).colorScheme.tertiary,
        unselectedItemColor: Theme.of(context).colorScheme.inversePrimary,
        currentIndex: _indexSelectedScreen,
        backgroundColor: Theme.of(context).colorScheme.primary,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Início'),
          BottomNavigationBarItem(
              icon: Icon(Icons.local_grocery_store), label: 'Compras'),
        ],
      ),
      drawer: const MainDrawer(),
    );
  }
}

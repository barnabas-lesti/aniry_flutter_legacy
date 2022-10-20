import 'package:aniry/ingredient/home_screen.dart';
import 'package:aniry/shopping/home_screen.dart';
import 'package:aniry/shopping/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(const _App());

class _App extends StatelessWidget {
  const _App();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aniry',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: ChangeNotifierProvider(
        create: (context) => ShoppingProvider(),
        child: const _ScreenContainer(),
      ),
    );
  }
}

class _ScreenContainer extends StatefulWidget {
  const _ScreenContainer();

  @override
  createState() => _ScreenContainerState();
}

class _ScreenContainerState extends State<_ScreenContainer> {
  int _selectedIndex = 0;

  final List<_RootScreenOption> _rootScreenOptions = [
    _RootScreenOption(
      icon: Icons.local_dining,
      label: 'Ingredients',
      widget: const IngredientHomeScreen(),
    ),
    _RootScreenOption(
      icon: Icons.playlist_add_check,
      label: 'Shopping',
      widget: const ShoppingHomeScreen(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _rootScreenOptions.elementAt(_selectedIndex).widget,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          for (int i = 0; i < _rootScreenOptions.length; i++)
            BottomNavigationBarItem(
              icon: Icon(_rootScreenOptions[i].icon),
              label: _rootScreenOptions[i].label,
            ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        iconSize: 30,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        elevation: 10,
        onTap: (index) => setState(() => _selectedIndex = index),
      ),
    );
  }
}

class _RootScreenOption {
  final IconData icon;
  final String label;
  final Widget widget;

  _RootScreenOption({
    required this.icon,
    required this.label,
    required this.widget,
  });
}

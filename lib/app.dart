import 'package:aniry_shopping_list/shopping_list/shopping_list_page.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aniry Shopping List',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: const ShoppingListPage(),
    );
  }
}

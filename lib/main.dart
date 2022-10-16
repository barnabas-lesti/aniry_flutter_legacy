import 'package:aniry_shopping_list/shopping/screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(
      MaterialApp(
        title: 'Aniry Shopping List',
        theme: ThemeData(primarySwatch: Colors.indigo),
        home: const ShoppingScreen(),
      ),
    );

import 'package:aniry/shopping/screens/home.dart';
import 'package:flutter/material.dart';

void main() => runApp(
      MaterialApp(
        title: 'Aniry',
        theme: ThemeData(primarySwatch: Colors.indigo),
        home: const ShoppingHomeScreen(),
      ),
    );

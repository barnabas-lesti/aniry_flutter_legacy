import 'package:aniry/shopping/screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(
      MaterialApp(
        title: 'Aniry',
        theme: ThemeData(primarySwatch: Colors.indigo),
        home: const ShoppingScreen(),
      ),
    );

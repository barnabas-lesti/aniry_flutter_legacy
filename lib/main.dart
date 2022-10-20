import 'package:aniry/shopping/home_screen.dart';
import 'package:aniry/shopping/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(
      MaterialApp(
        title: 'Aniry',
        theme: ThemeData(primarySwatch: Colors.indigo),
        home: ChangeNotifierProvider(
          create: (context) => ShoppingProvider(),
          child: const ShoppingHomeScreen(),
        ),
      ),
    );

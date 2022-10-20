import 'package:aniry/app/page.dart';
import 'package:flutter/material.dart';

class IngredientEditPage extends StatelessWidget {
  // final String id;

  const IngredientEditPage({
    // required this.id,
    super.key,
  });

  @override
  Widget build(context) {
    return const AppPage(
      title: 'Edit ingredient',
      children: [
        Text('Hello IngredientsEdit!'),
      ],
    );
  }
}

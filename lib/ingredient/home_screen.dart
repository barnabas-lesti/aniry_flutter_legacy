import 'package:aniry/app/screen.dart';
import 'package:flutter/material.dart';

class IngredientHomeScreen extends StatelessWidget {
  const IngredientHomeScreen({super.key});

  final String title = 'Ingredients';

  @override
  Widget build(context) {
    return AppScreen(
      title: title,
      actions: [
        buildAppScreenAction(
          Icons.add,
          'Create ingredient',
          onPressed: () => {},
        ),
      ],
      children: [
        Container(
          padding: const EdgeInsets.only(bottom: AppScreen.gutter),
          child: const Text('Hello Ingredients!'),
        ),
      ],
    );
  }
}

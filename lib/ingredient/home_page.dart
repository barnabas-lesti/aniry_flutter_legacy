import 'package:aniry/app/page.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

class IngredientHomePage extends StatelessWidget {
  const IngredientHomePage({super.key});

  @override
  Widget build(context) {
    return AppPage(
      title: 'Ingredients',
      actions: [
        buildAppPageAction(
          Icons.add,
          'Create ingredient',
          onPressed: () => Beamer.of(context).beamToNamed('/ingredient/edit'),
        ),
      ],
      children: const [
        Text('Hello Ingredients!'),
      ],
    );
  }
}

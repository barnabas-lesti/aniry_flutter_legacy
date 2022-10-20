import 'package:aniry/common/page.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

class IngredientHomePage extends StatelessWidget {
  const IngredientHomePage({super.key});

  @override
  Widget build(context) {
    return CommonPage(
      title: 'Ingredients',
      actions: [
        CommonPageAction(
          icon: Icons.add,
          tooltip: 'Create ingredient',
          onPressed: () => Beamer.of(context).beamToNamed('/ingredient/edit'),
        ),
      ],
      children: const [
        Text('Hello Ingredients!'),
      ],
    );
  }
}

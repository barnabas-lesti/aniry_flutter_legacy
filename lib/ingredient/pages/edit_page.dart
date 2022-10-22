import 'package:aniry/app/widgets/page.dart';
import 'package:flutter/material.dart';

class IngredientEditPage extends StatelessWidget {
  final String title;
  final String? id;

  const IngredientEditPage({
    required this.title,
    this.id,
    super.key,
  });

  @override
  Widget build(context) {
    return AppPageScaffold(
      title: title,
      children: const [
        Text('Hello IngredientsEdit!'),
      ],
    );
  }
}

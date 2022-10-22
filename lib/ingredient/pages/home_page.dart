import 'package:aniry/app/i10n.dart';
import 'package:aniry/app/widgets/page.dart';
import 'package:aniry/ingredient/provider.dart';
import 'package:aniry/ingredient/widgets/list.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IngredientHomePage extends StatelessWidget {
  final String title;

  const IngredientHomePage({
    required this.title,
    super.key,
  });

  @override
  Widget build(context) {
    return AppPageScaffold(
      title: title,
      actions: [
        AppPageAction(
          icon: Icons.add,
          tooltip: appI10N(context).ingredientHomePageCreateTooltip,
          onPressed: () => Beamer.of(context).beamToNamed('/ingredient/create'),
        ),
      ],
      children: [
        Consumer<IngredientProvider>(
          builder: (context, ingredientProvider, widget) => IngredientList(
            items: ingredientProvider.items,
            onTap: (id) => Beamer.of(context).beamToNamed('/ingredient/edit/:id'),
          ),
        ),
      ],
    );
  }
}

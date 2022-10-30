import 'package:aniry/app/app_i10n.dart';
import 'package:aniry/app/models/app_feature_router.dart';
import 'package:aniry/ingredient/models/ingredient.dart';
import 'package:aniry/ingredient/widgets/ingredient_edit_page.dart';
import 'package:aniry/ingredient/widgets/Ingredient_home_page.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

final ingredientRouter = AppFeatureRouter(
  icon: const Icon(Ingredient.icon),
  label: (context) => AppI10N.of(context).ingredientTab,
  routerDelegate: BeamerDelegate(
    initialPath: '/ingredient',
    locationBuilder: RoutesLocationBuilder(routes: {
      '/ingredient': (context, state, data) {
        return BeamPage(
          type: BeamPageType.noTransition,
          child: IngredientHomePage(title: AppI10N.of(context).ingredientHomeTitle),
        );
      },
      '/ingredient/create': (context, state, data) {
        return BeamPage(
          child: IngredientEditPage(
            title: AppI10N.of(context).ingredientCreateTitle,
          ),
        );
      },
      '/ingredient/edit/:id': (context, state, data) {
        return BeamPage(
          popToNamed: '/ingredient',
          child: IngredientEditPage(
            title: AppI10N.of(context).ingredientEditTitle,
            id: state.pathParameters['id']!,
          ),
        );
      },
    }),
  ),
);

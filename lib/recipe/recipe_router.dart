import 'package:aniry/app/app_i10n.dart';
import 'package:aniry/app/models/app_feature_router.dart';
import 'package:aniry/recipe/models/recipe.dart';
import 'package:aniry/recipe/pages/recipe_edit.dart';
import 'package:aniry/recipe/pages/recipe_home.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

final recipeRouter = AppFeatureRouter(
  icon: const Icon(Recipe.icon),
  label: (context) => AppI10N.of(context).recipeTab,
  routerDelegate: BeamerDelegate(
    initialPath: '/recipe',
    locationBuilder: RoutesLocationBuilder(routes: {
      '/recipe': (context, state, data) {
        return BeamPage(
          type: BeamPageType.noTransition,
          child: RecipeHome(title: AppI10N.of(context).recipeHomeTitle),
        );
      },
      '/recipe/create': (context, state, data) {
        return BeamPage(
          child: RecipeEdit(
            title: AppI10N.of(context).recipeCreateTitle,
          ),
        );
      },
      '/recipe/edit/:id': (context, state, data) {
        return BeamPage(
          popToNamed: '/recipe',
          child: RecipeEdit(
            title: AppI10N.of(context).recipeEditTitle,
            id: state.pathParameters['id']!,
          ),
        );
      },
    }),
  ),
);

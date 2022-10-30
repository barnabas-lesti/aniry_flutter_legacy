import 'package:aniry/app/app_i10n.dart';
import 'package:aniry/app/models/app_feature_router.dart';
import 'package:aniry/recipe/models/recipe.dart';
import 'package:aniry/recipe/widgets/recipe_edit_page.dart';
import 'package:aniry/recipe/widgets/recipe_home_page.dart';
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
          child: RecipeHomePage(title: AppI10N.of(context).recipeHomeTitle),
        );
      },
      '/recipe/create': (context, state, data) {
        return BeamPage(
          child: RecipeEditPage(
            title: AppI10N.of(context).recipeCreateTitle,
          ),
        );
      },
      '/recipe/edit/:id': (context, state, data) {
        return BeamPage(
          popToNamed: '/recipe',
          child: RecipeEditPage(
            title: AppI10N.of(context).recipeEditTitle,
            id: state.pathParameters['id']!,
          ),
        );
      },
    }),
  ),
);

import 'package:aniry/app/i10n.dart';
import 'package:aniry/app/models/feature_router.dart';
import 'package:aniry/ingredient/models/item.dart';
import 'package:aniry/ingredient/pages/edit.dart';
import 'package:aniry/ingredient/pages/home.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

final ingredientRouter = AppFeatureRouter(
  icon: const Icon(IngredientItem.icon),
  label: (context) => AppI10N.of(context).ingredientTab,
  routerDelegate: BeamerDelegate(
    initialPath: '/ingredient',
    locationBuilder: RoutesLocationBuilder(routes: {
      '/ingredient': (context, state, data) {
        return BeamPage(
          type: BeamPageType.noTransition,
          child: IngredientHome(title: AppI10N.of(context).ingredientHomeTitle),
        );
      },
      '/ingredient/create': (context, state, data) {
        return BeamPage(
          child: IngredientEdit(
            title: AppI10N.of(context).ingredientCreateTitle,
          ),
        );
      },
      '/ingredient/edit/:id': (context, state, data) {
        return BeamPage(
          popToNamed: '/ingredient',
          child: IngredientEdit(
            title: AppI10N.of(context).ingredientEditTitle,
            id: state.pathParameters['id']!,
          ),
        );
      },
    }),
  ),
);

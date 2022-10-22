import 'package:aniry/app/i10n.dart';
import 'package:aniry/ingredient/pages/edit_page.dart';
import 'package:aniry/ingredient/pages/home_page.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

final ingredientRouterDelegate = BeamerDelegate(
  initialPath: '/ingredient',
  locationBuilder: (routeInformation, beamParameters) {
    if (routeInformation.location!.contains('/ingredient')) return _IngredientRoutes(routeInformation);
    return NotFound(path: routeInformation.location!);
  },
);

class _IngredientRoutes extends BeamLocation<BeamState> {
  _IngredientRoutes(super.routeInformation);

  @override
  List<String> get pathPatterns => ['/*'];

  @override
  List<BeamPage> buildPages(context, state) => [
        BeamPage(
          key: const ValueKey('ingredient'),
          title: appI10N(context).ingredientHomePageTitle,
          type: BeamPageType.noTransition,
          child: IngredientHomePage(
            title: appI10N(context).ingredientHomePageTitle,
          ),
        ),
        if (state.uri.toString() == '/ingredient/create')
          BeamPage(
            key: const ValueKey('ingredient/create'),
            title: appI10N(context).ingredientCreatePageTitle,
            child: IngredientEditPage(
              title: appI10N(context).ingredientCreatePageTitle,
            ),
          ),
        if (state.uri.toString() == '/ingredient/edit')
          BeamPage(
            key: const ValueKey('ingredient/edit'),
            title: appI10N(context).ingredientEditPageTitle,
            child: IngredientEditPage(
              title: appI10N(context).ingredientEditPageTitle,
            ),
          ),
      ];
}

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
        const BeamPage(
          key: ValueKey('ingredient'),
          title: 'Ingredients',
          type: BeamPageType.noTransition,
          child: IngredientHomePage(),
        ),
        if (state.uri.pathSegments.length == 2)
          const BeamPage(
            key: ValueKey('ingredient/edit'),
            title: 'Edit ingredient',
            child: IngredientEditPage(),
          ),
      ];
}

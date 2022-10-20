import 'package:aniry/shopping/home_page.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

final shoppingRouterDelegate = BeamerDelegate(
  initialPath: '/shopping',
  locationBuilder: (routeInformation, beamParameters) {
    if (routeInformation.location!.contains('/shopping')) return _ShoppingRoutes(routeInformation);
    return NotFound(path: routeInformation.location!);
  },
);

class _ShoppingRoutes extends BeamLocation<BeamState> {
  _ShoppingRoutes(super.routeInformation);

  @override
  List<String> get pathPatterns => ['/*'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) => [
        const BeamPage(
          key: ValueKey('shopping'),
          title: 'Shopping',
          type: BeamPageType.noTransition,
          child: ShoppingHomePage(),
        ),
      ];
}

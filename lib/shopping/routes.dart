import 'package:aniry/app/i10n.dart';
import 'package:aniry/shopping/pages/home_page.dart';
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
        BeamPage(
          key: const ValueKey('shopping'),
          title: appI10N(context)!.shoppingHomePageTitle,
          type: BeamPageType.noTransition,
          child: const ShoppingHomePage(),
        ),
      ];
}

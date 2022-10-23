import 'package:aniry/app/i10n.dart';
import 'package:aniry/shopping/pages/home.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:aniry/app/models/feature_router.dart';

final shoppingRouter = AppFeatureRouter(
  icon: Icons.playlist_add_check,
  label: (context) => AppI10N.of(context).shoppingHomePageTabLabel,
  routerDelegate: BeamerDelegate(
    initialPath: '/shopping',
    locationBuilder: RoutesLocationBuilder(routes: {
      '/shopping': (context, state, data) {
        return BeamPage(
          type: BeamPageType.noTransition,
          child: ShoppingHome(
            title: AppI10N.of(context).shoppingHomePageTitle,
          ),
        );
      },
    }),
  ),
);

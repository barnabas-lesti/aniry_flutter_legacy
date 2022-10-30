import 'package:aniry/app/app_i10n.dart';
import 'package:aniry/shopping/widgets/shopping_home_page.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:aniry/app/models/app_feature_router.dart';

final shoppingRouter = AppFeatureRouter(
  icon: const Icon(Icons.playlist_add_check),
  label: (context) => AppI10N.of(context).shoppingTab,
  routerDelegate: BeamerDelegate(
    initialPath: '/shopping',
    locationBuilder: RoutesLocationBuilder(routes: {
      '/shopping': (context, state, data) {
        return BeamPage(
          type: BeamPageType.noTransition,
          child: ShoppingHomePage(
            title: AppI10N.of(context).shoppingHomeTitle,
          ),
        );
      },
    }),
  ),
);

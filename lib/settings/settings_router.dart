import 'package:aniry/app/app_i10n.dart';
import 'package:aniry/settings/widgets/settings_home_page.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:aniry/app/models/app_feature_router.dart';

final settingsRouter = AppFeatureRouter(
  icon: const Icon(Icons.settings),
  label: (context) => AppI10N.of(context).settingsTab,
  routerDelegate: BeamerDelegate(
    initialPath: '/settings',
    locationBuilder: RoutesLocationBuilder(routes: {
      '/settings': (context, state, data) {
        return BeamPage(
          type: BeamPageType.noTransition,
          child: SettingsHomePage(
            title: AppI10N.of(context).settingsHomeTitle,
          ),
        );
      },
    }),
  ),
);

import 'package:aniry/app/i10n.dart';
import 'package:aniry/settings/pages/home.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:aniry/app/models/feature_router.dart';

final settingsRouter = AppFeatureRouter(
  icon: const Icon(Icons.settings),
  label: (context) => AppI10N.of(context).settingsTab,
  routerDelegate: BeamerDelegate(
    initialPath: '/settings',
    locationBuilder: RoutesLocationBuilder(routes: {
      '/settings': (context, state, data) {
        return BeamPage(
          type: BeamPageType.noTransition,
          child: SettingsHome(
            title: AppI10N.of(context).settingsHomeTitle,
          ),
        );
      },
    }),
  ),
);

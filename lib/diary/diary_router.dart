import 'package:aniry/app/app_i10n.dart';
import 'package:aniry/diary/widgets/diary_home_page.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:aniry/app/models/app_feature_router.dart';

final diaryRouter = AppFeatureRouter(
  icon: const Icon(Icons.calculate),
  label: (context) => AppI10N.of(context).diaryTab,
  routerDelegate: BeamerDelegate(
    initialPath: '/diary',
    locationBuilder: RoutesLocationBuilder(routes: {
      '/diary': (context, state, data) {
        return BeamPage(
          type: BeamPageType.noTransition,
          child: DiaryHomePage(
            title: AppI10N.of(context).diaryHomePageTitle,
          ),
        );
      },
    }),
  ),
);

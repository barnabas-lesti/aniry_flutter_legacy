import 'package:aniry/app/models/feature_router.dart';
import 'package:aniry/ingredient/router.dart';
import 'package:aniry/shopping/router.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

final featureRouters = <AppFeatureRouter>[
  ingredientRouter,
  shoppingRouter,
];

final appRouterDelegate = BeamerDelegate(
  initialPath: featureRouters[0].routerDelegate.initialPath,
  locationBuilder: RoutesLocationBuilder(
    routes: {
      '*': (context, state, data) => const _AppRootScaffold(),
    },
  ),
);

final appRouteInformationParser = BeamerParser();

final appBackButtonDispatcher = BeamerBackButtonDispatcher(
  delegate: appRouterDelegate,
);

class _AppRootScaffold extends StatefulWidget {
  const _AppRootScaffold();

  @override
  State<_AppRootScaffold> createState() => _AppRootScaffoldState();
}

class _AppRootScaffoldState extends State<_AppRootScaffold> {
  late int _currentIndex;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final uriString = Beamer.of(context).configuration.location!;
    _currentIndex = uriString.contains(featureRouters[0].routerDelegate.initialPath) ? 0 : 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          for (int i = 0; i < featureRouters.length; i++)
            Beamer(
              routerDelegate: featureRouters[i].routerDelegate,
            )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        iconSize: 30,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        elevation: 10,
        items: [
          for (int i = 0; i < featureRouters.length; i++)
            BottomNavigationBarItem(
              label: featureRouters[i].label(context),
              icon: Icon(featureRouters[i].icon),
            ),
        ],
        onTap: (index) {
          if (index != _currentIndex) {
            setState(() => _currentIndex = index);
            featureRouters[_currentIndex].routerDelegate.update(rebuild: false);
          }
        },
      ),
    );
  }
}

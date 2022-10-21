import 'package:aniry/app/i10n.dart';
import 'package:aniry/ingredient/routes.dart';
import 'package:aniry/shopping/routes.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

final appRouteGroups = <_AppRouteGroup>[
  _AppRouteGroup(
    icon: Icons.local_dining,
    routerDelegate: ingredientRouterDelegate,
    label: (context) => appI10N(context)!.ingredientHomePageTabLabel,
  ),
  _AppRouteGroup(
    icon: Icons.playlist_add_check,
    routerDelegate: shoppingRouterDelegate,
    label: (context) => appI10N(context)!.shoppingHomePageTabLabel,
  )
];

final appRouterDelegate = BeamerDelegate(
  initialPath: appRouteGroups[0].routerDelegate.initialPath,
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
    _currentIndex = uriString.contains(appRouteGroups[0].routerDelegate.initialPath) ? 0 : 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          for (int i = 0; i < appRouteGroups.length; i++)
            Beamer(
              routerDelegate: appRouteGroups[i].routerDelegate,
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
          for (int i = 0; i < appRouteGroups.length; i++)
            BottomNavigationBarItem(
              label: appRouteGroups[i].label(context),
              icon: Icon(appRouteGroups[i].icon),
            ),
        ],
        onTap: (index) {
          if (index != _currentIndex) {
            setState(() => _currentIndex = index);
            appRouteGroups[_currentIndex].routerDelegate.update(rebuild: false);
          }
        },
      ),
    );
  }
}

class _AppRouteGroup {
  final IconData icon;
  final BeamerDelegate routerDelegate;
  final String Function(BuildContext) label;

  const _AppRouteGroup({
    required this.icon,
    required this.routerDelegate,
    required this.label,
  });
}

import 'package:aniry/router.dart';
import 'package:aniry/shopping/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(const _App());

class _App extends StatelessWidget {
  const _App();

  @override
  Widget build(context) {
    return ChangeNotifierProvider(
      create: (context) => ShoppingProvider(),
      child: MaterialApp.router(
        title: 'Aniry',
        theme: ThemeData(primarySwatch: Colors.indigo),
        routerDelegate: appRouterDelegate,
        routeInformationParser: appRouteInformationParser,
        backButtonDispatcher: appBackButtonDispatcher,
      ),
    );
  }
}

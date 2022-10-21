import 'package:aniry/app/router.dart';
import 'package:aniry/shopping/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

void main() => runApp(const _App());

class _App extends StatelessWidget {
  const _App();

  @override
  Widget build(context) {
    return ChangeNotifierProvider(
      create: (context) => ShoppingProvider(),
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: MaterialApp.router(
          title: 'Aniry',
          theme: ThemeData(primarySwatch: Colors.indigo),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''),
          ],
          routerDelegate: appRouterDelegate,
          routeInformationParser: appRouteInformationParser,
          backButtonDispatcher: appBackButtonDispatcher,
        ),
      ),
    );
  }
}

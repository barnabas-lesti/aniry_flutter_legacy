import 'package:aniry/app/app_router.dart';
import 'package:aniry/ingredient/Ingredient_provider.dart';
import 'package:aniry/recipe/recipe_provider.dart';
import 'package:aniry/shopping/shopping_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

void main() => runApp(const _App());

class _App extends StatelessWidget {
  const _App();

  @override
  Widget build(context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ShoppingProvider>(create: (c) => ShoppingProvider()),
        ChangeNotifierProvider<IngredientProvider>(create: (c) => IngredientProvider()),
        ChangeNotifierProxyProvider<IngredientProvider, RecipeProvider>(
          create: (c) => RecipeProvider(),
          update: (context, ingredientProvider, recipeProvider) {
            recipeProvider!.ingredients = ingredientProvider.ingredients;
            return recipeProvider;
          },
        ),
      ],
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

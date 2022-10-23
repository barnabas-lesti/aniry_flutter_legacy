import 'package:aniry/app/i10n.dart';
import 'package:aniry/ingredient/pages/edit_page.dart';
import 'package:aniry/ingredient/pages/home_page.dart';
import 'package:beamer/beamer.dart';

final ingredientRouterDelegate = BeamerDelegate(
  initialPath: '/ingredient',
  locationBuilder: RoutesLocationBuilder(routes: {
    // Return either Widgets or BeamPages if more customization is needed
    '/ingredient': (context, state, data) => BeamPage(
          type: BeamPageType.noTransition,
          child: IngredientHomePage(title: appI10N(context).ingredientHomePageTitle),
        ),
    '/ingredient/create': (context, state, data) => BeamPage(
          child: IngredientEditPage(
            title: appI10N(context).ingredientCreatePageTitle,
          ),
        ),
    '/ingredient/edit/:id': (context, state, data) {
      final id = state.pathParameters['id']!;
      return BeamPage(
        popToNamed: '/ingredient',
        child: IngredientEditPage(
          title: appI10N(context).ingredientEditPageTitle,
          id: id,
        ),
      );
    },
  }),
);

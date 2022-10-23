import 'package:aniry/app/i10n.dart';
import 'package:aniry/app/models/feature_router.dart';
import 'package:aniry/ingredient/models/item.dart';
import 'package:aniry/ingredient/pages/edit_page.dart';
import 'package:aniry/ingredient/pages/home_page.dart';
import 'package:beamer/beamer.dart';

final ingredientRouter = AppFeatureRouter(
  icon: IngredientItem.icon,
  label: (context) => AppI10N.of(context).ingredientTabLabel,
  routerDelegate: BeamerDelegate(
    initialPath: '/ingredient',
    locationBuilder: RoutesLocationBuilder(routes: {
      '/ingredient': (context, state, data) {
        return BeamPage(
          type: BeamPageType.noTransition,
          child: IngredientHomePage(title: AppI10N.of(context).ingredientHomePageTitle),
        );
      },
      '/ingredient/create': (context, state, data) {
        return BeamPage(
          child: IngredientEditPage(
            title: AppI10N.of(context).ingredientCreatePageTitle,
          ),
        );
      },
      '/ingredient/edit/:id': (context, state, data) {
        return BeamPage(
          popToNamed: '/ingredient',
          child: IngredientEditPage(
            title: AppI10N.of(context).ingredientEditPageTitle,
            id: state.pathParameters['id']!,
          ),
        );
      },
    }),
  ),
);

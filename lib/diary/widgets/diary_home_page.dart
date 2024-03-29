import 'package:aniry/app/app_i10n.dart';
import 'package:aniry/app/models/app_list_item.dart';
import 'package:aniry/app/models/app_unit.dart';
import 'package:aniry/app/widgets/app_header_action.dart';
import 'package:aniry/app/widgets/app_item_selector_dialog.dart';
import 'package:aniry/app/widgets/app_list.dart';
import 'package:aniry/app/widgets/app_nutrients_chart.dart';
import 'package:aniry/app/widgets/app_page_scaffold.dart';
import 'package:aniry/app/widgets/app_section_header.dart';
import 'package:aniry/app/widgets/app_serving_editor_dialog.dart';
import 'package:aniry/app/widgets/app_total_calories.dart';
import 'package:aniry/diary/models/diary_item.dart';
import 'package:aniry/ingredient/Ingredient_provider.dart';
import 'package:aniry/ingredient/models/ingredient.dart';
import 'package:aniry/ingredient/models/ingredient_proxy.dart';
import 'package:aniry/recipe/models/recipe_proxy.dart';
import 'package:aniry/recipe/recipe_provider.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class DiaryHomePage extends StatelessWidget {
  final String title;

  const DiaryHomePage({
    required this.title,
    super.key,
  });

  @override
  Widget build(context) {
    return AppPageScaffold(
      title: title,
      child: SingleChildScrollView(
        child: _DiaryHomePageEditor(),
      ),
    );
  }
}

class _DiaryHomePageEditor extends StatefulWidget {
  @override
  State<_DiaryHomePageEditor> createState() => _DiaryHomePageEditorState();
}

class _DiaryHomePageEditorState extends State<_DiaryHomePageEditor> {
  late DiaryItem _diaryItem;

  _DiaryHomePageEditorState() {
    _diaryItem = DiaryItem();
  }

  void Function() _buildOnEditIngredientsPress(BuildContext context) {
    final ingredientProvider = IngredientProvider.of(context);
    final recipeProvider = RecipeProvider.of(context);
    return () {
      showAppItemSelectorDialog(
        context: context,
        items: [
          ...ingredientProvider.ingredients.map((ingredient) => ingredient.toListItem()).toList(),
          ...recipeProvider.recipes.map((recipe) => recipe.toListItem()).toList(),
        ],
        selectedItems: _diaryItem.listItems,
        onSave: (items) {
          setState(() {
            List<IngredientProxy> ingredientProxies = [];
            List<RecipeProxy> recipeProxies = [];
            for (int index = 0; index < items.length; index++) {
              final item = items[index];
              if (item.source == Ingredient || item.source == IngredientProxy) {
                final ingredient = IngredientProvider.of(context).getIngredient(item.id);
                final existingProxy =
                    _diaryItem.ingredientProxies.where((proxy) => proxy.id == ingredient.id).firstOrNull;
                final serving = existingProxy != null ? existingProxy.serving : ingredient.serving.clone();
                ingredientProxies.add(IngredientProxy(ingredient: ingredient, serving: serving));
              } else {
                final recipe = RecipeProvider.of(context).getRecipe(item.id);
                final existingProxy = _diaryItem.recipeProxies.where((proxy) => proxy.id == recipe.id).firstOrNull;
                final serving = existingProxy != null ? existingProxy.serving : recipe.serving.clone();
                recipeProxies.add(RecipeProxy(recipe: recipe, serving: serving));
              }
            }
            _diaryItem.ingredientProxies = ingredientProxies;
            _diaryItem.recipeProxies = recipeProxies;

            final ids = items.map((item) => item.id).toList();
            final filteredOrderedIDs = _diaryItem.orderedIDs.where((orderedID) => ids.contains(orderedID)).toList();
            filteredOrderedIDs.addAll(ids.where((id) => !filteredOrderedIDs.contains(id)));
            _diaryItem.orderedIDs = filteredOrderedIDs;
          });
        },
      );
    };
  }

  void Function(AppListItem) _buildOnListTileTap(BuildContext context) {
    return (item) {
      showAppServingEditorDialog(
        context: context,
        initialServing: (item.source == Ingredient || item.source == IngredientProxy)
            ? _diaryItem.ingredientProxies.firstWhere((proxy) => proxy.id == item.id).serving
            : _diaryItem.recipeProxies.firstWhere((proxy) => proxy.id == item.id).serving,
        onSave: (serving) {
          setState(() {
            if (item.source == Ingredient || item.source == IngredientProxy) {
              _diaryItem.ingredientProxies.firstWhere((proxy) => proxy.id == item.id).serving.value = serving.value;
            } else {
              _diaryItem.recipeProxies.firstWhere((proxy) => proxy.id == item.id).serving.value = serving.value;
            }
          });
        },
      );
    };
  }

  void _onListReorder(List<AppListItem> items) {
    setState(() {
      _diaryItem.orderedIDs = items.map((item) => item.id).toList();
    });
  }

  void _onDelete(AppListItem item) {
    setState(() {
      _diaryItem.orderedIDs.remove(item.id);
      if (item.source == Ingredient || item.source == IngredientProxy) {
        _diaryItem.ingredientProxies = _diaryItem.ingredientProxies.where((proxy) => proxy.id != item.id).toList();
      } else {
        _diaryItem.recipeProxies = _diaryItem.recipeProxies.where((proxy) => proxy.id != item.id).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final appI10N = AppI10N.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSectionHeader(
          title: appI10N.diaryHomePageItemsTitle,
          paddingBottom: 8,
          actions: [
            AppHeaderAction(
              icon: Icons.add,
              tooltip: appI10N.diaryHomePageItemsAddLabel,
              onPressed: _buildOnEditIngredientsPress(context),
            )
          ],
        ),
        AppList(
          items: _diaryItem.listItems,
          noItemsText: appI10N.diaryHomePageNoItems,
          showIcon: true,
          showTextRightPrimary: true,
          showTextRightSecondary: true,
          numberOfVisibleItems: 5,
          onTap: _buildOnListTileTap(context),
          onReorder: _onListReorder,
          onDelete: _onDelete,
          paddingBottom: 16,
        ),
        AppTotalCalories(
          calories: _diaryItem.calories,
          paddingBottom: 16,
        ),
        AppNutrientsChart(nutrients: _diaryItem.nutrients),
      ],
    );
  }
}

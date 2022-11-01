import 'package:aniry/app/models/app_list_item.dart';
import 'package:aniry/app/models/app_serving.dart';
import 'package:aniry/app/models/app_unit.dart';
import 'package:aniry/app/widgets/app_header_action.dart';
import 'package:aniry/app/widgets/app_item_selector_dialog.dart';
import 'package:aniry/app/widgets/app_list.dart';
import 'package:aniry/app/widgets/app_page_scaffold.dart';
import 'package:aniry/app/widgets/app_section_header.dart';
import 'package:aniry/diary/models/diary_item.dart';
import 'package:aniry/ingredient/Ingredient_provider.dart';
import 'package:aniry/ingredient/models/ingredient.dart';
import 'package:aniry/ingredient/models/ingredient_proxy.dart';
import 'package:aniry/ingredient/widgets/ingredient_serving_editor_dialog.dart';
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
          });
        },
      );
    };
  }

  void Function(AppListItem) _buildOnListTileTap(BuildContext context) {
    return (item) {
      showIngredientServingEditorDialog(
        context: context,
        initialServing: AppServing(),
        // initialServing: _recipe.ingredientProxies.firstWhere((proxy) => proxy.id == id).serving,
        onSave: (serving) {
          setState(() {
            // _recipe.ingredientProxies.firstWhere((proxy) => proxy.id == id).serving.value = serving.value;
          });
        },
      );
    };
  }

  // void _onListReorder(List<AppListItem> items) {
  //   setState(() {
  //     _recipe.ingredientProxies =
  //         ids.map((id) => _recipe.ingredientProxies.where((proxy) => proxy.id == id).first).toList();
  //   });
  // }

  void _onDelete(AppListItem item) {
    setState(() {
      if (item.source == Ingredient) {
        _diaryItem.ingredientProxies = _diaryItem.ingredientProxies.where((proxy) => proxy.id != item.id).toList();
      } else {
        _diaryItem.recipeProxies = _diaryItem.recipeProxies.where((proxy) => proxy.id != item.id).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSectionHeader(
          title: 'Items',
          paddingBottom: 8,
          actions: [
            AppHeaderAction(
              icon: Icons.add,
              tooltip: 'Add items',
              onPressed: _buildOnEditIngredientsPress(context),
            )
          ],
        ),
        AppList(
          items: _diaryItem.listItems,
          noItemsText: 'No items',
          showIcon: true,
          showTextRightPrimary: true,
          showTextRightSecondary: true,
          numberOfVisibleItems: 5,
          onTap: _buildOnListTileTap(context),
          // onReorder: _onListReorder,
          onDelete: _onDelete,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total calories',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                '${_diaryItem.calories.toStringAsFixed(0)}${AppUnit.kcal}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        )
      ],
    );
  }
}

import 'package:aniry/app/app_i10n.dart';
import 'package:aniry/app/models/app_serving.dart';
import 'package:aniry/app/widgets/app_header_action.dart';
import 'package:aniry/app/widgets/app_list.dart';
import 'package:aniry/app/widgets/app_page_scaffold.dart';
import 'package:aniry/app/widgets/app_section_header.dart';
import 'package:aniry/ingredient/widgets/ingredient_serving_editor_dialog.dart';
import 'package:flutter/material.dart';

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
      child: const SingleChildScrollView(
        child: _DiaryHomePageEditor(),
      ),
    );
  }
}

class _DiaryHomePageEditor extends StatefulWidget {
  const _DiaryHomePageEditor({
    Key? key,
  }) : super(key: key);

  @override
  State<_DiaryHomePageEditor> createState() => _DiaryHomePageEditorState();
}

class _DiaryHomePageEditorState extends State<_DiaryHomePageEditor> {
  void Function() _buildOnEditIngredientsPress(BuildContext context) {
    return () {};
    // return () {
    //   showIngredientSelectorDialog(
    //     context: context,
    //     initialSelectedIDs: [],
    //     // initialSelectedIDs: _recipe.ingredientProxies.map((proxy) => proxy.id).toList(),
    //     onSave: (ids) {
    //       setState(() {
    //         // _recipe.ingredientProxies = ids.map((id) {
    //         //   final ingredient = IngredientProvider.of(context).getIngredient(id);
    //         //   final existingProxy = _recipe.ingredientProxies.where((proxy) => proxy.id == id).firstOrNull;
    //         //   final serving = existingProxy != null ? existingProxy.serving : ingredient.serving.clone();
    //         //   return IngredientProxy(ingredient: ingredient, serving: serving);
    //         // }).toList();
    //       });
    //     },
    //   );
    // };
  }

  void Function(String) _buildOnListTileTap(BuildContext context) {
    return (id) {
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

  void _onListReorder(List<String> ids) {
    setState(() {
      // _recipe.ingredientProxies =
      //     ids.map((id) => _recipe.ingredientProxies.where((proxy) => proxy.id == id).first).toList();
    });
  }

  void _onDelete(String id) {
    setState(() {
      // _recipe.ingredientProxies = _recipe.ingredientProxies.where((proxy) => proxy.id != id).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final appI10N = AppI10N.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSectionHeader(
          title: appI10N.recipeFormIngredients,
          paddingBottom: 8,
          actions: [
            AppHeaderAction(
              icon: Icons.add,
              tooltip: appI10N.recipeFormIngredientsAddTooltip,
              onPressed: _buildOnEditIngredientsPress(context),
            )
          ],
        ),
        AppList(
          items: const [],
          // items: _recipe.ingredientProxies.map((proxy) => proxy.toListItem()).toList(),
          noItemsText: appI10N.recipeFormIngredientsNoItems,
          showIcon: true,
          showTextRightPrimary: true,
          showTextRightSecondary: true,
          numberOfVisibleItems: 5,
          onTap: (item) => _buildOnListTileTap(context)(item.id),
          onReorder: (items) => _onListReorder(items.map((item) => item.id).toList()),
          onDelete: (item) => _onDelete(item.id),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                appI10N.recipeFormTotalCalories,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              // Text(
              //   '${_recipe.calories.toStringAsFixed(0)}${AppUnit.kcal}',
              //   style: const TextStyle(fontWeight: FontWeight.bold),
              // ),
            ],
          ),
        )
      ],
    );
  }
}

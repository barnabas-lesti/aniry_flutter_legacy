import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class AppListItem {
  final String id;
  final String textLeftPrimary;
  final String? textLeftSecondary;
  final String? textRightPrimary;
  final String? textRightSecondary;
  final IconData? icon;
  final Color? iconColor;

  const AppListItem({
    required this.id,
    required this.textLeftPrimary,
    this.textLeftSecondary,
    this.textRightPrimary,
    this.textRightSecondary,
    this.icon,
    this.iconColor,
  });
}

class AppList extends StatelessWidget {
  final List<AppListItem> items;
  final List<AppListItem>? selectedItems;
  final String? noItemsText;
  final bool? withCheckbox;
  final void Function(String, bool)? onCheck;
  final void Function(String)? onDelete;
  final void Function(List<String>)? onReorder;
  final void Function(String)? onTap;

  const AppList({
    required this.items,
    this.selectedItems = const [],
    this.noItemsText,
    this.withCheckbox,
    this.onCheck,
    this.onDelete,
    this.onReorder,
    this.onTap,
    Key? key,
  }) : super(key: key);

  void _onReorder(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) newIndex -= 1;
    items.insert(newIndex, items.removeAt(oldIndex));
    onReorder!(items.map((item) => item.id).toList());
  }

  Widget _proxyDecorator(Widget child, int index, Animation<double> animation) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) => Material(elevation: 2, child: child),
      child: child,
    );
  }

  List<AppListTile> _buildTiles() => [
        for (int i = 0; i < items.length; i++)
          AppListTile(
            key: Key(items[i].id),
            onDelete: onDelete != null ? () => onDelete!(items[i].id) : null,
            item: items[i],
            onCheck: onCheck != null ? (checked) => onCheck!(items[i].id, checked) : null,
            onTap: onTap != null ? () => onTap!(items[i].id) : null,
            withCheckbox: withCheckbox,
            selected: selectedItems?.where((item) => items[i].id == item.id).isNotEmpty,
          )
      ];

  @override
  Widget build(context) {
    final tiles = _buildTiles();

    return items.isEmpty
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: noItemsText != null
                ? Text(
                    noItemsText!,
                    textAlign: TextAlign.center,
                  )
                : null,
          )
        : Expanded(
            child: onReorder != null
                ? ReorderableListView(
                    proxyDecorator: _proxyDecorator,
                    onReorder: _onReorder,
                    children: tiles,
                  )
                : ListView(children: tiles),
          );
  }
}

class AppListTile extends StatelessWidget {
  final AppListItem item;
  final bool? selected;
  final bool? withCheckbox;
  final void Function()? onTap;
  final void Function(bool)? onCheck;
  final void Function()? onDelete;

  const AppListTile({
    required this.item,
    this.selected,
    this.withCheckbox,
    this.onTap,
    this.onCheck,
    this.onDelete,
    Key? key,
  }) : super(key: key);

  void _onCheck(bool checked) {
    onCheck?.call(checked);
    onTap?.call();
  }

  Widget _buildTile() => GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            ListTile(
              contentPadding: const EdgeInsets.all(0),
              leading: (withCheckbox ?? false)
                  ? Checkbox(
                      value: selected,
                      onChanged: (checked) => _onCheck(checked ?? false),
                    )
                  : null,
              title: Text(
                item.textLeftPrimary,
                style: TextStyle(decoration: (selected ?? false) ? TextDecoration.lineThrough : TextDecoration.none),
              ),
            ),
            const Divider(height: 0),
          ],
        ),
      );

  List<SlidableAction> _buildActions(BuildContext context) => [
        if (onDelete != null)
          SlidableAction(
            onPressed: (_) => onDelete!(),
            backgroundColor: Colors.transparent,
            foregroundColor: Theme.of(context).colorScheme.errorContainer,
            icon: Icons.delete,
          )
      ];

  @override
  Widget build(context) {
    final tile = _buildTile();
    final actions = _buildActions(context);

    return actions.isNotEmpty
        ? Slidable(
            key: ValueKey(item.id),
            endActionPane: ActionPane(
              motion: const ScrollMotion(),
              extentRatio: 0.2 * actions.length,
              children: actions,
            ),
            child: tile,
          )
        : tile;
  }
}

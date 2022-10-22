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
      builder: (context, child) => Material(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: child,
          )),
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

  List<AppListTile> _sortTiles(List<AppListTile> tiles) =>
      tiles..sort((a, b) => a.item.textLeftPrimary.compareTo(b.item.textLeftPrimary));

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
                : ListView(children: _sortTiles(tiles)),
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

  Widget _buildColumn({
    required String textPrimary,
    required CrossAxisAlignment crossAxisAlignment,
    String? textSecondary,
    bool? truncate,
    bool? lineThrough,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(
          textPrimary,
          overflow: truncate != null ? TextOverflow.ellipsis : null,
          style: TextStyle(
            fontSize: 16,
            decoration: (lineThrough ?? false) ? TextDecoration.lineThrough : null,
          ),
        ),
        if (textSecondary != null)
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Text(
              textSecondary,
              style: TextStyle(
                fontSize: 14,
                overflow: truncate != null ? TextOverflow.ellipsis : null,
                color: Colors.grey[500],
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildTile() => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              if (withCheckbox ?? false)
                Checkbox(
                  value: selected,
                  onChanged: (checked) => _onCheck(checked ?? false),
                ),
              if (item.icon != null)
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Icon(
                    item.icon,
                    color: item.iconColor,
                    size: 22,
                  ),
                ),
              Expanded(
                child: _buildColumn(
                  textPrimary: item.textLeftPrimary,
                  textSecondary: item.textLeftSecondary,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  truncate: true,
                  lineThrough: selected,
                ),
              ),
              if (item.textRightPrimary != null)
                _buildColumn(
                  textPrimary: item.textRightPrimary!,
                  textSecondary: item.textRightSecondary,
                  crossAxisAlignment: CrossAxisAlignment.end,
                ),
            ],
          ),
        ),
      );

  List<SlidableAction> _buildActions(BuildContext context) => [
        if (onDelete != null)
          SlidableAction(
            onPressed: (_) => onDelete!(),
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.red[300],
            icon: Icons.delete,
          )
      ];

  @override
  Widget build(context) {
    final tile = _buildTile();
    final actions = _buildActions(context);

    return Column(
      children: [
        actions.isNotEmpty
            ? Slidable(
                key: ValueKey(item.id),
                endActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  extentRatio: 0.2 * actions.length,
                  children: actions,
                ),
                child: tile,
              )
            : tile,
        const Divider(height: 0),
      ],
    );
  }
}

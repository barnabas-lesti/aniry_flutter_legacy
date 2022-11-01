import 'package:aniry/app/models/app_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

enum AppListSelectedDecoration {
  none,
  strikethrough,
  checkbox,
  checkboxAndStrikethrough,
}

class AppList extends StatelessWidget {
  final List<AppListItem> items;
  final List<AppListItem>? selectedItems;
  final String noItemsText;
  final double? paddingBottom;
  final int? numberOfVisibleItems;
  final bool? dense;
  final bool? showIcon;
  final bool? showTextLeftSecondary;
  final bool? showTextRightPrimary;
  final bool? showTextRightSecondary;
  final bool? showCheckbox;
  final bool? shrinkWrap;
  final bool? expanded;
  final AppListSelectedDecoration? selectedDecoration;
  final void Function(AppListItem, bool)? onSelect;
  final void Function(AppListItem)? onDelete;
  final void Function(List<AppListItem>)? onReorder;
  final void Function(AppListItem)? onTap;

  const AppList({
    required this.items,
    required this.noItemsText,
    this.selectedItems,
    this.paddingBottom,
    this.numberOfVisibleItems,
    this.dense,
    this.showIcon,
    this.showTextLeftSecondary,
    this.showTextRightPrimary,
    this.showTextRightSecondary,
    this.showCheckbox,
    this.selectedDecoration,
    this.shrinkWrap,
    this.expanded,
    this.onSelect,
    this.onDelete,
    this.onReorder,
    this.onTap,
    Key? key,
  }) : super(key: key);

  void _onReorder(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) newIndex -= 1;
    final reorderedItems = [...items];
    reorderedItems.insert(newIndex, reorderedItems.removeAt(oldIndex));
    onReorder!(reorderedItems);
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

  List<_AppListTile> _buildTiles() => [
        for (int i = 0; i < items.length; i++)
          _AppListTile(
            key: Key(items[i].id),
            item: items[i],
            dense: (dense ?? false),
            selected: (selectedItems ?? []).where((selectedItem) => items[i].id == selectedItem.id).isNotEmpty,
            showCheckbox: (showCheckbox ?? false),
            showIcon: (showIcon ?? false),
            showTextLeftSecondary: (showTextLeftSecondary ?? false),
            showTextRightPrimary: (showTextRightPrimary ?? false),
            showTextRightSecondary: (showTextRightSecondary ?? false),
            selectDecoration: selectedDecoration ?? AppListSelectedDecoration.none,
            onTap: onTap != null ? () => onTap!(items[i]) : null,
            onSelect: onSelect != null ? (selected) => onSelect!(items[i], selected) : null,
            onDelete: onDelete != null ? () => onDelete!(items[i]) : null,
          )
      ];

  List<_AppListTile> _sortTiles(List<_AppListTile> tiles) =>
      tiles..sort((a, b) => a.item.textLeftPrimary.toLowerCase().compareTo(b.item.textLeftPrimary.toLowerCase()));

  @override
  Widget build(context) {
    final tiles = _buildTiles();
    final list = onReorder != null
        ? ReorderableListView(
            proxyDecorator: _proxyDecorator,
            onReorder: _onReorder,
            shrinkWrap: (shrinkWrap ?? false),
            children: tiles,
          )
        : ListView(
            shrinkWrap: (shrinkWrap ?? false),
            children: _sortTiles(tiles),
          );
    final expandedList = (expanded ?? false) ? Expanded(child: list) : list;
    final content = items.isEmpty
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    noItemsText,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 14, overflow: TextOverflow.clip),
                  ),
                ),
              )
            ],
          )
        : expandedList;
    final sizedContent = numberOfVisibleItems != null && numberOfVisibleItems! > 0
        ? SizedBox(
            width: MediaQuery.of(context).size.width,
            height: ((items.length < numberOfVisibleItems! ? items.length : numberOfVisibleItems!) * 64).toDouble(),
            child: content,
          )
        : content;
    final paddedContent = (paddingBottom ?? 0) > 0
        ? Padding(
            padding: EdgeInsets.only(bottom: paddingBottom!),
            child: sizedContent,
          )
        : sizedContent;

    return paddedContent;
  }
}

class _AppListTile extends StatelessWidget {
  final AppListItem item;
  final bool dense;
  final bool selected;
  final bool showIcon;
  final bool showTextLeftSecondary;
  final bool showTextRightPrimary;
  final bool showTextRightSecondary;
  final bool showCheckbox;
  final AppListSelectedDecoration selectDecoration;
  final void Function()? onTap;
  final void Function(bool)? onSelect;
  final void Function()? onDelete;

  const _AppListTile({
    required this.item,
    required this.selectDecoration,
    this.dense = false,
    this.selected = false,
    this.showIcon = false,
    this.showTextLeftSecondary = false,
    this.showTextRightPrimary = false,
    this.showTextRightSecondary = false,
    this.showCheckbox = false,
    this.onTap,
    this.onSelect,
    this.onDelete,
    Key? key,
  }) : super(key: key);

  void _onSelect(bool selected) {
    onSelect?.call(selected);
    onTap?.call();
  }

  bool get _shouldStrikethrough {
    return selected &&
        (selectDecoration == AppListSelectedDecoration.strikethrough ||
            selectDecoration == AppListSelectedDecoration.checkboxAndStrikethrough);
  }

  bool get _shouldShowCheckbox {
    return showCheckbox ||
        (selected &&
            (selectDecoration == AppListSelectedDecoration.checkbox ||
                selectDecoration == AppListSelectedDecoration.checkboxAndStrikethrough));
  }

  Widget _buildTextColumn({
    required CrossAxisAlignment crossAxisAlignment,
    required String textPrimary,
    String? textSecondary,
    bool? truncate,
  }) =>
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: crossAxisAlignment,
        children: [
          Text(
            textPrimary,
            overflow: truncate != null ? TextOverflow.ellipsis : null,
            style: TextStyle(
              fontSize: 14,
              decoration: _shouldStrikethrough ? TextDecoration.lineThrough : null,
            ),
          ),
          if (textSecondary != null)
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Text(
                textSecondary,
                style: TextStyle(
                  fontSize: 12,
                  overflow: truncate != null ? TextOverflow.ellipsis : null,
                  color: Colors.grey[500],
                ),
              ),
            ),
        ],
      );

  Widget _buildTile() => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: SizedBox(
          height: dense ? null : 64,
          child: Row(
            children: [
              if (item.icon != null && showIcon)
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Icon(
                    item.icon,
                    color: item.color,
                    size: 22,
                  ),
                ),
              Expanded(
                child: _buildTextColumn(
                  textPrimary: item.textLeftPrimary,
                  textSecondary: showTextLeftSecondary ? item.textLeftSecondary : null,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  truncate: true,
                ),
              ),
              if (showTextRightPrimary)
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: _buildTextColumn(
                    textPrimary: item.textRightPrimary,
                    textSecondary: showTextRightSecondary ? item.textRightSecondary : null,
                    crossAxisAlignment: CrossAxisAlignment.end,
                  ),
                ),
              if (_shouldShowCheckbox)
                Checkbox(
                  value: selected,
                  onChanged: (selected) => _onSelect(selected ?? false),
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

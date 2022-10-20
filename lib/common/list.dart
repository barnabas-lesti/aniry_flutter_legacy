import 'package:aniry/common/item.dart';
import 'package:flutter/material.dart';

class CommonList<T extends CommonItem> extends StatelessWidget {
  const CommonList({
    required this.items,
    required this.onDelete,
    required this.onCheck,
    required this.onReorder,
    this.onTileTap,
    this.noItemsText = '',
    Key? key,
  }) : super(key: key);

  final List<T> items;
  final String noItemsText;
  final void Function(T, bool) onCheck;
  final void Function(T) onDelete;
  final void Function(List<T>) onReorder;
  final void Function()? onTileTap;

  void _onReorder(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) newIndex -= 1;
    items.insert(newIndex, items.removeAt(oldIndex));
    onReorder(items);
  }

  Widget _proxyDecorator(Widget child, int index, Animation<double> animation) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) => Material(elevation: 2, child: child),
      child: child,
    );
  }

  @override
  Widget build(context) {
    if (items.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Text(
          noItemsText,
          textAlign: TextAlign.center,
        ),
      );
    }

    return Expanded(
      child: ReorderableListView(
        proxyDecorator: _proxyDecorator,
        onReorder: _onReorder,
        children: [
          for (int i = 0; i < items.length; i++)
            _CommonListTile(
              key: Key(items[i].id),
              onDelete: () => onDelete(items[i]),
              item: items[i],
              onCheck: (checked) => onCheck(items[i], checked),
              onTap: onTileTap,
            )
        ],
      ),
    );
  }
}

class _CommonListTile<T extends CommonItem> extends StatelessWidget {
  const _CommonListTile({
    required this.item,
    required this.onDelete,
    required this.onCheck,
    this.onTap,
    Key? key,
  }) : super(key: key);

  final T item;
  final void Function(bool) onCheck;
  final void Function() onDelete;
  final void Function()? onTap;

  void _onCheck(bool? checked) {
    onCheck(checked ?? false);
    onTap!();
  }

  void _onTap() {
    onCheck(!item.checked);
    onTap!();
  }

  @override
  Widget build(context) {
    return Container(
      color: Colors.transparent,
      child: Dismissible(
        key: super.key ?? Key(item.id),
        onDismissed: (_) => onDelete(),
        child: GestureDetector(
          onTap: _onTap,
          child: Column(
            children: [
              ListTile(
                contentPadding: const EdgeInsets.all(0),
                leading: Checkbox(
                  value: item.checked,
                  onChanged: _onCheck,
                ),
                title: Text(
                  item.text,
                  style: TextStyle(decoration: item.checked ? TextDecoration.lineThrough : TextDecoration.none),
                ),
              ),
              const Divider(height: 0),
            ],
          ),
        ),
      ),
    );
  }
}

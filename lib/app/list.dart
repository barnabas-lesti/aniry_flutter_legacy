import 'package:aniry/app/item.dart';
import 'package:flutter/material.dart';

class AppList<T extends AppItem> extends StatelessWidget {
  const AppList({
    required this.items,
    required this.onDelete,
    required this.onCheck,
    required this.onReorder,
    Key? key,
  }) : super(key: key);

  final List<T> items;
  final void Function(T, bool) onCheck;
  final void Function(T) onDelete;
  final void Function(List<T>) onReorder;

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
    return Expanded(
      child: ReorderableListView(
        proxyDecorator: _proxyDecorator,
        onReorder: _onReorder,
        children: [
          for (int i = 0; i < items.length; i++)
            _AppListTile(
              key: Key(items[i].id),
              onDelete: () => onDelete(items[i]),
              item: items[i],
              onCheck: (checked) => onCheck(items[i], checked),
            )
        ],
      ),
    );
  }
}

class _AppListTile<T extends AppItem> extends StatelessWidget {
  const _AppListTile({
    required this.item,
    required this.onDelete,
    required this.onCheck,
    Key? key,
  }) : super(key: key);

  final T item;
  final void Function(bool) onCheck;
  final void Function() onDelete;

  @override
  Widget build(context) {
    return Container(
      color: Colors.transparent,
      child: Dismissible(
        key: super.key ?? Key(item.id),
        onDismissed: (_) => onDelete(),
        child: GestureDetector(
          onTap: () => onCheck(!item.checked),
          child: Column(
            children: [
              ListTile(
                contentPadding: const EdgeInsets.all(0),
                leading: Checkbox(
                  value: item.checked,
                  onChanged: (value) => onCheck(value ?? false),
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

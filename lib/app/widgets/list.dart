import 'package:flutter/material.dart';

class AppListWidget extends StatelessWidget {
  const AppListWidget({
    required this.items,
    required this.onDelete,
    required this.onCheck,
    required this.onReorder,
    Key? key,
  }) : super(key: key);

  final List<AppListItem> items;
  final void Function(AppListItem, bool) onCheck;
  final void Function(AppListItem) onDelete;
  final void Function(List<AppListItem>) onReorder;

  void _onReorder(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final AppListItem item = items.removeAt(oldIndex);
    items.insert(newIndex, item);
    onReorder([...items]);
  }

  Widget _proxyDecorator(Widget child, int index, Animation<double> animation) {
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget? child) => Material(
        elevation: 2,
        child: child,
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ReorderableListView(
        proxyDecorator: _proxyDecorator,
        onReorder: _onReorder,
        children: [
          for (int i = 0; i < items.length; i++)
            _AppListTileWidget(
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

class AppListItem {
  final String id;
  final String text;
  final bool checked;

  AppListItem({
    required this.id,
    required this.text,
    this.checked = false,
  });
}

class _AppListTileWidget extends StatelessWidget {
  const _AppListTileWidget({
    required this.item,
    required this.onDelete,
    required this.onCheck,
    Key? key,
  }) : super(key: key);

  final AppListItem item;
  final void Function(bool) onCheck;
  final void Function() onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Dismissible(
        key: super.key ?? UniqueKey(),
        onDismissed: (_) => onDelete(),
        child: GestureDetector(
          onTap: () => onCheck(!item.checked),
          child: Column(
            children: [
              ListTile(
                contentPadding: const EdgeInsets.all(0),
                leading: Checkbox(
                  value: item.checked,
                  onChanged: (bool? value) => onCheck(value ?? false),
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

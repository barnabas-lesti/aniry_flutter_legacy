import 'package:flutter/material.dart';

class ShoppingListInput extends StatelessWidget {
  ShoppingListInput({
    required this.onSubmit,
    Key? key,
  }) : super(key: key);

  final void Function(String) onSubmit;
  final _controller = TextEditingController();

  void _onSubmitHandler(String newItem) {
    if (newItem.isNotEmpty) {
      _controller.clear();
      onSubmit(newItem);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autocorrect: false,
      controller: _controller,
      onFieldSubmitted: _onSubmitHandler,
      decoration: const InputDecoration(
        labelText: 'Add new list item',
        border: OutlineInputBorder(),
      ),
    );
  }
}

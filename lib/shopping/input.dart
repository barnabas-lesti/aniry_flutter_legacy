import 'package:flutter/material.dart';

class ShoppingInput extends StatelessWidget {
  ShoppingInput({
    required this.onSubmit,
    Key? key,
  }) : super(key: key);

  final void Function(String) onSubmit;
  final _controller = TextEditingController();

  void _onSubmit(String text) {
    if (text.isNotEmpty) {
      _controller.clear();
      onSubmit(text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autocorrect: false,
      controller: _controller,
      onFieldSubmitted: _onSubmit,
      decoration: const InputDecoration(
        labelText: 'Add new item',
        border: OutlineInputBorder(),
      ),
    );
  }
}
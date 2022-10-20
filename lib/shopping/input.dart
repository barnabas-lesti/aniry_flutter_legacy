import 'package:aniry/shopping/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShoppingInput extends StatelessWidget {
  ShoppingInput({Key? key}) : super(key: key);

  final _controller = TextEditingController();

  void Function(String) _buildOnSubmit(BuildContext context) => (String text) {
        if (text.isNotEmpty) {
          Provider.of<ShoppingProvider>(context, listen: false).addItem(text);
          _controller.clear();
        }
      };

  @override
  Widget build(context) {
    return TextFormField(
      autocorrect: false,
      controller: _controller,
      onFieldSubmitted: _buildOnSubmit(context),
      decoration: const InputDecoration(
        labelText: 'Add new item',
        border: OutlineInputBorder(),
      ),
    );
  }
}

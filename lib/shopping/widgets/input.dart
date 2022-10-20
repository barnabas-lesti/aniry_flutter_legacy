import 'package:aniry/app/i10n.dart';
import 'package:flutter/material.dart';

class ShoppingInput extends StatefulWidget {
  final void Function(String) onCreate;
  final FocusNode? focusNode;
  final void Function()? onTap;

  const ShoppingInput({
    required this.onCreate,
    this.focusNode,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  State<ShoppingInput> createState() => _ShoppingInputState();
}

class _ShoppingInputState extends State<ShoppingInput> {
  final _controller = TextEditingController();

  void _onCreate() {
    if (_controller.text.isNotEmpty) {
      widget.onCreate(_controller.text);
      _controller.clear();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(context) {
    return TextFormField(
      focusNode: widget.focusNode,
      onEditingComplete: _onCreate,
      textInputAction: TextInputAction.next,
      autocorrect: false,
      textCapitalization: TextCapitalization.sentences,
      controller: _controller,
      onTap: widget.onTap,
      decoration: InputDecoration(
        labelText: appI10N(context)!.shoppingInputLabel,
        border: const OutlineInputBorder(),
      ),
    );
  }
}

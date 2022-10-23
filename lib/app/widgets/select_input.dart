import 'package:aniry/app/widgets/input.dart';
import 'package:flutter/material.dart';

class AppSelectInput<T> extends StatefulWidget {
  final String initialValue;
  final List<AppSelectInputOption> options;
  final void Function(String) onChanged;

  const AppSelectInput({
    required this.initialValue,
    required this.options,
    required this.onChanged,
    super.key,
  });

  @override
  State<AppSelectInput> createState() => _AppSelectInputState();
}

class _AppSelectInputState extends State<AppSelectInput> {
  final TextEditingController _controller = TextEditingController();

  _buildOnTap(BuildContext context) => () {
        final offset = (context.findRenderObject() as RenderBox).localToGlobal(Offset.zero);
        final position = RelativeRect.fromLTRB(offset.dx, offset.dy, 0, 0);
        showMenu(
          context: context,
          position: position,
          items: widget.options
              .map(
                (option) => PopupMenuItem<String>(
                  value: option.value,
                  child: Text(option.label),
                  onTap: () {
                    _controller.text = option.value;
                    widget.onChanged(_controller.text);
                  },
                ),
              )
              .toList(),
        );
      };

  @override
  Widget build(BuildContext context) {
    _controller.text = widget.initialValue;
    return AppInput(
      controller: _controller,
      textAlign: TextAlign.center,
      onTap: _buildOnTap(context),
      readonly: true,
    );
  }
}

class AppSelectInputOption {
  final String label;
  final String value;

  const AppSelectInputOption({
    required this.label,
    required this.value,
  });
}

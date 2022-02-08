import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTitleTextFormField extends StatefulWidget {
  const CustomTitleTextFormField({
    required TextEditingController controller,
    required this.title,
    this.keyboardType,
    this.textInputAction,
    this.onChanged,
    this.validator,
    this.initialValue,
    this.color,
    this.contentPadding,
    this.minLines = 1,
    this.maxLines = 1,
    this.maxLength,
    this.readOnly = false,
    this.autoFocus = false,
    Key? key,
  })  : _controller = controller,
        super(key: key);
  final TextEditingController _controller;
  final String title;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final void Function(String)? onChanged;
  final String? Function(String? value)? validator;
  final EdgeInsetsGeometry? contentPadding;
  final int? minLines;
  final int? maxLines;
  final Color? color;
  final int? maxLength;
  final String? initialValue;
  final bool readOnly;
  final bool autoFocus;
  @override
  CustomTitleTextFormFieldState createState() =>
      CustomTitleTextFormFieldState();
}

class CustomTitleTextFormFieldState extends State<CustomTitleTextFormField> {
  void _onListen() => setState(() {});
  @override
  void initState() {
    widget._controller.addListener(_onListen);
    super.initState();
  }

  @override
  void dispose() {
    widget._controller.removeListener(_onListen);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoFormRow(
      prefix: Text(
        widget.title,
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      child: CupertinoTextFormFieldRow(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        initialValue: widget.initialValue,
        controller: widget._controller,
        readOnly: widget.readOnly,
        keyboardType: widget.maxLines! > 1
            ? TextInputType.multiline
            : widget.keyboardType ?? TextInputType.text,
        textInputAction: widget.maxLines! > 1
            ? TextInputAction.newline
            : widget.textInputAction ?? TextInputAction.next,
        autofocus: widget.autoFocus,
        onChanged: widget.onChanged,
        maxLength: widget.maxLength,
        minLines: widget.minLines,
        maxLines: (widget._controller.text.isEmpty) ? 1 : widget.maxLines,
        validator: (String? value) => widget.validator!(value),
        cursorColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}

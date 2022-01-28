import 'package:flutter/material.dart';
import '../../utilities/utilities.dart';

class ChatTestFormField extends StatefulWidget {
  const ChatTestFormField({
    required TextEditingController controller,
    required this.onSendPressed,
    Key? key,
  })  : _text = controller,
        super(key: key);
  final TextEditingController _text;
  final VoidCallback onSendPressed;
  @override
  _ChatTestFormFieldState createState() => _ChatTestFormFieldState();
}

class _ChatTestFormFieldState extends State<ChatTestFormField> {
  void _onListener() => setState(() {});
  @override
  void initState() {
    widget._text.addListener(_onListener);
    super.initState();
  }

  @override
  void dispose() {
    widget._text.removeListener(_onListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget._text,
      minLines: 1,
      maxLines: 3,
      textInputAction: TextInputAction.newline,
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(14),
        hintText: 'Text Message',
        suffixIcon: (widget._text.text.isNotEmpty)
            ? IconButton(
                splashRadius: 20,
                onPressed: widget.onSendPressed,
                icon: Icon(
                  Icons.send,
                  color: Theme.of(context).primaryColor,
                ),
              )
            : IconButton(
                splashRadius: 20,
                onPressed: () {},
                icon: Icon(
                  Icons.photo,
                  color: Theme.of(context).primaryColor,
                ),
              ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Utilities.borderRadius / 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Utilities.borderRadius / 2),
        ),
      ),
    );
  }
}

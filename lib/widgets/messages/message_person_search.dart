import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessagesPersonSearch extends StatefulWidget {
  const MessagesPersonSearch({
    required this.onChanged,
    this.hint = 'Search',
    Key? key,
  }) : super(key: key);
  final void Function(String)? onChanged;
  final String hint;

  @override
  _MessagesPersonSearchState createState() => _MessagesPersonSearchState();
}

class _MessagesPersonSearchState extends State<MessagesPersonSearch> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: TextFormField(
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(0),
          hintText: widget.hint,
          prefixIcon: const Icon(CupertinoIcons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}

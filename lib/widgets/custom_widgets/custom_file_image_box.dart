import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class CustomFileImageBox extends StatelessWidget {
  const CustomFileImageBox({
    required this.onTap,
    this.size = 80,
    this.file,
    Key? key,
  }) : super(key: key);
  final PlatformFile? file;
  final VoidCallback onTap;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              height: size,
              width: size,
              color: Theme.of(context).primaryColor,
              child: file == null
                  ? const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: FittedBox(
                        child: Text(
                          'No\nImage',
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  : SizedBox(
                      height: double.infinity,
                      width: double.infinity,
                      child: Image.file(
                        File(file!.path!),
                        fit: BoxFit.cover,
                      ),
                    ),
            ),
          ),
          TextButton(
            onPressed: onTap,
            child: const Text(
              'Upload Image',
              style: TextStyle(height: 1),
            ),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.all(0),
            ),
          ),
        ],
      ),
    );
  }
}

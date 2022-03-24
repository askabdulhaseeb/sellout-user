import 'package:file_picker/file_picker.dart';

class PickerFunctions {
  Future<dynamic> pick(
      {required FileType type, bool allowMultiple = false}) async {
    final FilePickerResult? _result = await FilePicker.platform.pickFiles(
      allowMultiple: allowMultiple,
      type: type,
    );
    if (_result == null) return null;
    return (allowMultiple) ? _result.files : _result.files[0];
  }
}

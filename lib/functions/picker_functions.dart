import 'package:file_picker/file_picker.dart';

class PickerFunctions {
  Future<dynamic> pick(
      {required FileType type, bool allowMultiple = false}) async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: allowMultiple,
      type: type,
    );
    if (result == null) return null;
    return (allowMultiple) ? result.files : result.files[0];
  }
}

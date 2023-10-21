import 'dart:async';

import 'package:image_picker/image_picker.dart';

class ImageController {
  String _imageUrl = '';
  StreamController<String> valueController = StreamController<String>();

  ImageController() {
    // Initialize the stream controller with an empty string as the default value
    valueController = StreamController<String>.broadcast(
      onListen: () {
        // Emit the initial empty string when a listener is added
        _imageUrl = '';
        valueController.sink.add(_imageUrl);
      },
    );
  }

  void setImageState(String filePath) {
    _imageUrl = filePath;
    valueController.sink.add(_imageUrl);
  }

  String get getImageUrl => _imageUrl;

  Stream<String> getImageState() {
    return valueController.stream;
  }

  void dispose() {
    valueController.close();
  }

  void pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final selectedImagePath = pickedFile.path;
      setImageState(selectedImagePath ?? '');
    }
  }

  void removePic() {
    setImageState('');
  }
}

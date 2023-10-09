import 'dart:async';

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
}

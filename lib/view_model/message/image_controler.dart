import 'dart:async';

class ImageController {
  StreamController<String> valueController = StreamController<String>();

  ImageController() {
    // Initialize the stream controller with an empty string as the default value
    valueController = StreamController<String>.broadcast(
      onListen: () {
        // Emit the initial empty string when a listener is added
        valueController.sink.add('');
      },
    );
  }

  void setImageState(String filePath) {
    valueController.sink.add(filePath);
  }

  Stream<String> getImageState() {
    return valueController.stream;
  }

  void dispose() {
    valueController.close();
  }
}

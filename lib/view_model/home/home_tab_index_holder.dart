import 'dart:async';

class HomeTabIndexHolder {
  int _tabIndex = 0;
  StreamController<int> valueController = StreamController<int>();

  void setTabbarState(int index) {
    if (_tabIndex != index) valueController.sink.add(index);
    _tabIndex = index;
  }

  Stream<int> getTabbarState() {
    return valueController.stream;
  }

  void dispose() {
    valueController.close();
  }
}

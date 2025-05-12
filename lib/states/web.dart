import 'package:flutter/material.dart';

class WebProvider extends ChangeNotifier {
  int _progress = 0;

  int get progress => _progress;
  set progress(int value) {
    if (value != _progress) {
      _progress = value;
      notifyListeners();
    }
  }

  String _title = '';
  String get title => _title;
  set title(String? value) {
    if (value?.isNotEmpty == true) {
      _title = value!;
      notifyListeners();
    }
  }
}

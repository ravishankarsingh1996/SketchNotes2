import 'dart:async';
import 'dart:ui';
import 'package:rxdart/rxdart.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sketchnotes_flutter/models/pen.dart';

class UserPreferencesBloc {
  SharedPreferences prefs;

  Pen _currentPen = Pen();
  final _penController = BehaviorSubject<Pen>();

  UserPreferencesBloc() {
    _penController.add(Pen());
  }

  void setPenColor(Color color) {
    _penController.sink.add(Pen(color: color, size: _currentPen.size));
  }

  Stream<Pen> get currentPen => _penController.stream;
}

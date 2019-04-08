import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sketchnotes_flutter/customUI/ColorPicker.dart';
import 'package:sketchnotes_flutter/models/pen.dart';
import 'package:sketchnotes_flutter/widgets/user_preferences_provider.dart';

const List _colors = [
  NamedColor("Blue", Colors.blue),
  NamedColor("Yellow", Colors.yellow),
  NamedColor("Black", Colors.black)
];

class NamedColor {
  final String name;
  final Color color;

  const NamedColor(this.name, this.color);
}

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'New', icon: Icons.clear),
  const Choice(title: 'Undo', icon: Icons.undo),
  const Choice(title: 'Color Picker', icon: Icons.color_lens),
];

class MainPage extends StatelessWidget {
  const MainPage({Key key, @required this.title, @required this.paper})
      : super(key: key);

  final String title;
  final paper;

  Widget _backgroundBuilder({Color color = Colors.black}) {
    return GridPaper(
      color: color,
      divisions: 1,
      subdivisions: 1,
      interval: 25,
      child: paper,
    );
  }

  void undo() {
    paper.undo();
  }

  void _select(BuildContext context, Choice choice) {
    paper.clear();
  }

  void _setColor(Color c) {
    paper.penColor(c);
  }

  List<DropdownMenuItem<Color>> _buildColorList() {
    return _colors
        .map(
            (c) => DropdownMenuItem<Color>(value: c.color, child: Text(c.name)))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final prefs = UserPreferencesProvider.of(context);

    return StreamBuilder(
        stream: prefs.currentPen,
        builder: (context, snapshot) {
          return Scaffold(
            appBar: AppBar(
              title: Text(title),
              actions: <Widget>[
                IconButton(
                  icon: Icon(choices[0].icon),
                  onPressed: () {
                    _select(context, choices[0]);
                  },
                ),
                IconButton(
                  icon: Icon(choices[1].icon),
                  onPressed: () {
                    undo();
                  },
                ),
                IconButton(
                  icon: Icon(choices[2].icon),
                  onPressed: () {
                    showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (context) {
                          return Container(
                            child: Center(
                              child: Container(
                                  decoration:
                                      BoxDecoration(color: Colors.white),
                                  height: double.maxFinite,
                                  child: Column(
                                    children: <Widget>[
                                      ColorPicker(
                                        currentColor: Colors.red,
                                        onSelected: (color) {
                                          prefs.setPenColor(color);
                                        },
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      RaisedButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('Done'),
                                      ),
                                    ],
                                  )),
                            ),
                          );
                        });
                  },
                ),
              ],
            ),
            body: Column(
              children: <Widget>[
                Expanded(
                  child: paper,
                ),
              ],
            ),
          );
        });
  }
}

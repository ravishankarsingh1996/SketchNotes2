import 'dart:ui';

import 'package:flutter/material.dart';
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
            DropdownButton<Color>(
              value:
                  (snapshot.data as Pen)?.color,
              items: _buildColorList(),
              onChanged: (selected) {
                print("onchange $selected");
                //_setColor(selected);
                prefs.setPenColor(selected);
              },
            ),
          ],
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: _backgroundBuilder(color: Colors.blue),
            ),
          ],
        ),
      );
    });
  }
}

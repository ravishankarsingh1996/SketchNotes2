import 'package:flutter/material.dart';
import 'package:sketchnotes_flutter/models/pen.dart';
import 'package:sketchnotes_flutter/widgets/paper_painter.dart';
import 'package:sketchnotes_flutter/widgets/user_preferences_provider.dart';

class PaperWidget extends StatefulWidget {
  final _state = PaperWidgetState();

  PaperWidgetState createState() => _state;

  // TODO: this needs to come from Bloc emitting new-page event stream
  void clear() {
    _state.clear();
  }
}

class PaperWidgetState extends State<PaperWidget> {
  List<Offset> _points = <Offset>[];

  Widget build(BuildContext context) {
    final prefs = UserPreferencesProvider.of(context).currentPen;

    return GestureDetector(
      onPanUpdate: (DragUpdateDetails details) {
        RenderBox referenceBox = context.findRenderObject();
        Offset localPosition =
            referenceBox.globalToLocal(details.globalPosition);
        setState(() {
          _points = List.from(_points)..add(localPosition);
        });
      },
      onPanEnd: (DragEndDetails details) => _points.add(null),
      child: StreamBuilder(
        stream: prefs,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return CustomPaint(
              painter: new PaperPainter(_points, (snapshot.data as Pen)?.color),
              size: Size.infinite);
        },
      ),
    );
  }

  void clear() {
    setState(() {
      _points = List();
    });
  }
}

import 'package:flutter/material.dart';
import 'package:sketchnotes_flutter/models/PointsData.dart';
import 'package:sketchnotes_flutter/models/UndoPoints.dart';
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

  void undo() {
    _state.undo();
  }
}

class PaperWidgetState extends State<PaperWidget> {
  List<PointsData> _points = <PointsData>[];
  List<UndoPoints> _undoPoints = <UndoPoints>[];
  UndoPoints undoPoint ;
  Pen pen;

  Widget build(BuildContext context) {
    final prefs = UserPreferencesProvider.of(context).currentPen;
    return GestureDetector(
      onPanUpdate: (DragUpdateDetails details) {

        RenderBox referenceBox = context.findRenderObject();
        Offset localPosition =
            referenceBox.globalToLocal(details.globalPosition);
        setState(() {
          _points = List.from(_points)..add(PointsData(localPosition, pen));
          if(undoPoint == null){
            undoPoint = UndoPoints();
            undoPoint.start = _points.length-1;
          }
        });
      },
      onPanEnd: (DragEndDetails details){
        if(undoPoint!=null){
          undoPoint.end = _points.length-1;
          _undoPoints.add(undoPoint);
          undoPoint = null;
        }
        _points.add(null);
      } ,
      child: StreamBuilder(
        stream: prefs,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          pen = (snapshot.data as Pen);
          return CustomPaint(
              painter: new PaperPainter(_points, pen?.color),
              size: Size.infinite);
        },
      ),
    );
  }

  void undo() {
    setState(() {
      if(_undoPoints!=null && _undoPoints.length>0){
        _points.removeRange(_undoPoints[_undoPoints.length-1].start, _undoPoints[_undoPoints.length-1].end);
        _undoPoints.removeLast();
      }
    });
  }

  void clear() {
    setState(() {
      _points = List();
      _undoPoints = List();
    });
  }
}

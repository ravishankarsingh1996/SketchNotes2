import 'package:flutter/material.dart';
import 'package:sketchnotes_flutter/widgets/main_page.dart';
import 'package:sketchnotes_flutter/widgets/paper_widget.dart';
import 'package:sketchnotes_flutter/widgets/user_preferences_provider.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return UserPreferencesProvider(
      child: MaterialApp(
        title: 'Sketch Notes',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(title: 'Sketch Notes'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _paper = PaperWidget();

  @override
  Widget build(BuildContext context) {
    return MainPage(
      title: widget.title,
      paper: _paper,
    );
  }

  void _addPage() {
    //TODO
  }
}

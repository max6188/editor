import 'package:flutter/material.dart';
import 'package:editor/editor.dart';


void main() {
  ThemeData buildTheme() {
    final ThemeData base = ThemeData();
    return base.copyWith(
       inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(
            color: Colors.brown[800],
            fontSize: 16.0
        ),
        hintStyle: TextStyle(
            color: Colors.blue[800],
            fontSize: 14.0
        ),
      ),
    );
  }
  runApp(new MaterialApp(
    theme: buildTheme(),
    title: 'Flutter Tutorial',
    home: new TutorialHome(),

  ));
}

class TutorialHome extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // Scaffold is a layout for the major Material Components.

    return new Scaffold(

      appBar: new AppBar(
        elevation:0.0,
        leading: new IconButton( //primer circulo
          icon: new Icon(Icons.menu),
          tooltip: 'Navigation menu',
          onPressed: null,
        ),
        title: new Text('Example title'), //el título
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.search),
            tooltip: 'Search',
            onPressed:  (() {
              Navigator.push(
                  context, MaterialPageRoute(builder: (BuildContext context) => new FrmEditorTDA()));
             }),
          ),
        ],
      ),
      // body is the majority of the screen.
      body: new Center(
        child: new Text('Hello, world!'), //el texto centrado
      ),
      floatingActionButton: new FloatingActionButton( //el botón flotante
        tooltip: 'Add', // used by assistive technologies
        child: new Icon(Icons.add),
        onPressed: null,
      ),
    );
  }
}


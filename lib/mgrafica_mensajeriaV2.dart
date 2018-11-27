import 'package:flutter/material.dart';

class MgraficaMensajeria{

  Widget simple(BuildContext context,String glosa){
    return new Text(
      glosa,
      style:DefaultTextStyle.of(context).style.apply(
        fontSizeFactor: 0.5,
        color: Colors.blue,
        decoration: TextDecoration.none,
        decorationColor: Colors.red,
        decorationStyle: TextDecorationStyle.wavy,
      ),
    );
  }

  Widget simpleCentrado(BuildContext context,String glosa){
    return new Center( child:Text(
      glosa,
      style:DefaultTextStyle.of(context).style.apply(
        fontSizeFactor: 0.5,
        color: Colors.blue,
        decoration: TextDecoration.none,
        decorationColor: Colors.red,
        decorationStyle: TextDecorationStyle.wavy,
      ),
    ));
  }

  void muestraMensaje(  GlobalKey<ScaffoldState> scf,String message, [MaterialColor color = Colors.red]) {
    //Pone título en la barra de abajo
    scf.currentState
        .showSnackBar(
        new SnackBar(backgroundColor: color, content: new Text(message)));
  }


  Future<bool> willPop(BuildContext context,FormState form ) async {
    if (form == null || form.validate())
      return true;
    return await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return new AlertDialog(
          title: const Text('Hay errores'),
          content: const Text('Realmente te vas?'),
          actions: <Widget>[
            new FlatButton(
              child: const Text('SI'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
            new FlatButton(
              child: const Text('NO'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
          ],
        );
      },
    ) ?? false;
  }
}



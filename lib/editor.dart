import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import "package:editor/mgrafica_mensajeriaV2.dart";
import "package:editor/tdataform.dart";

class FrmEditorTDA extends StatefulWidget {
  @override
  _FrmEditorTDA createState() => new _FrmEditorTDA();
}

class _FrmEditorTDA extends State<FrmEditorTDA> {
  bool lecturacompleta = true;
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  MgraficaMensajeria mje = new MgraficaMensajeria();
  bool cambiaFormulario = false;
  Data d = new Data();

  @override
  initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    //d.dRutCtrl.dispose();
    //d.dRutCtrl.dispose();
    super.dispose();
  }

  Future<bool> willPop(BuildContext context, FormState form) async {
    if (form == null || form.validate()) return true;
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
        ) ??
        false;
  }

  Widget elFormulario(BuildContext context) {
    return new Form(
        key: formKey,
        autovalidate: true,
        //onWillPop: willPop(),
        child: new ListView(
          physics: new ClampingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          children: [
            /*
            new RutTD(
                rutCtrl: d.rutCtrl,
                dvCtrl: d.dRutCtrl,
                cambiaFormulario: cambiaFormulario,
                esObligatorio:true,
                onFieldSubmitted: (String rut) {
                   print(d.rutCtrl.text+"-"+d.dRutCtrl.text);
                }),
*/
            new CorreoTD(
                valorInicial: d.correo,
                esObligatorio: true,
                puedeSerNulo:true,
                onFieldSubmitted: (String correo) {
                  d.correo = correo;}),
/*
            new FonoTD(
                hintText:"Fono",
                labelTex:"Fono",
                valorInicial: d.fono,
                esObligatorio:true,
                puedeSerNulo:true,
                onFieldSubmitted: (String fono) {
                  print("Foono final $fono");
                  d.fono = fono.replaceAll("-", "");;
                }),


              new EnteroTD(
                 hintText: "HintText",
                 labelText: "labelText",
                 valorInicial:d.entero,
                 esObligatorio:true,
                 puedeSerNulo:false,
                 desde:0.0,
                 estrictoDesde:true,
                 hasta:10000000.0,
                 estrictoHasta:false,
                 onFieldSubmitted: (String entero) {
                    d.entero = int.tryParse(alternoComa(entero));
                  }),

            new CantidadTD(
                hintText: "Cantidad",
                labelText: "Cantidad",
                icono: Icons.confirmation_number,
                valorInicial: d.cantidad,
                esObligatorio: true,
                puedeSerNulo: false,
                desde: 0.0,
                estrictoDesde: true,
                hasta: 100.0,
                estrictoHasta: false,
                onFieldSubmitted: (String cantidad) {
                  d.cantidad = double.tryParse(alternoComa(cantidad));
                  print(d.cantidad);
            }),
*/

            const SizedBox(height: 24.0),
            new Container(
                padding: const EdgeInsets.only(top: 25.0),
                child: new RaisedButton(
                    child: const Text("Grabar"),
                    onPressed: () {
                      _submit(context);
                    })),
          ],
        ));
  }
  //Generacion de variables

  void _submit(BuildContext context) {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      grabar();
    } else {
      print("no entra");
    }
  }

  void grabar() {
    print(d.entero);
    Navigator.of(context).pop(true);
  }

  //principal
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        key: scaffoldKey,
        appBar: new AppBar(title: new Center(child: Text('Editor'))),
        body: !lecturacompleta
            ? mje.simpleCentrado(context, 'Esperando servidor...')
            : new SafeArea(
                top: false,
                bottom: false,
                minimum: const EdgeInsets.only(
                    top: 10.0, left: 10.0, right: 10.0, bottom: 10.0),
                child: new Container(
                  decoration: new BoxDecoration(
                    // Add Gradient
                    gradient: new LinearGradient(
                        colors: [Colors.green[100], Colors.green[800]],
                        begin: const FractionalOffset(0.0, 0.0),
                        end: const FractionalOffset(0.6, 1.0),
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp),
                  ),
                  child: elFormulario(context),
                )));
  }
}

class Data {
  TextEditingController rutCtrl;
  TextEditingController dRutCtrl;
  String correo;
  String fono;
  int entero;
  double cantidad;

  Data() {
    rutCtrl = new TextEditingController();
    dRutCtrl = new TextEditingController();
    rutCtrl.text = "";
    dRutCtrl.text = "";

    correo = "";
    fono = "982574971";
    entero = 0;
    cantidad = 0.0;
  }
}

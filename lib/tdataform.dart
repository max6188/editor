/*
* autor :Máximo Meza
 */
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class RutTD extends StatelessWidget {
  //Falta rut nueva forma
  String nuevaCosa="";
  TextEditingController rutCtrl;
  TextEditingController dvCtrl;
  FormFieldSetter<String> onSaved;
  final ValueChanged<String> onFieldSubmitted;

  bool cambiaFormulario;
  final bool esObligatorio;

  RutTD(
      {this.rutCtrl,
      this.dvCtrl,
      this.cambiaFormulario = false,
      this.esObligatorio = true,
      this.onFieldSubmitted});

  String obtieneDV(String pRut) {
    //https://www.lawebdelprogramador.com/codigo/JavaScript/1471-Validar-rut-Chileno.html
    int largo = pRut.length; //
    if (largo > 0) {
      String cRut = pRut;
      int largo = cRut.length;
      //if (largo < 7) return "";

      String rut = cRut;

      largo = cRut.length;

      String dvr = '0';
      int suma = 0;
      int mul = 2;

      for (int i = rut.length - 1; i >= 0; i--) {
        suma = suma + int.parse(rut[i]) * mul;

        if (mul == 7)
          mul = 2;
        else
          mul++;
      }

      int res = suma % 11;
      if (res == 1)
        dvr = 'k';
      else if (res == 0)
        dvr = '0';
      else {
        int dvi = 11 - res;
        dvr = dvi.toString();
      }

      return dvr;
    } else {
      return "";
    }
  }

  final _MascaraFormateo dvFormateo = new _MascaraFormateo("0123456789");
  final _MascaraFormateo rFormateo = new _MascaraFormateo("0123456789kK");
  @override
  Widget build(BuildContext context) {
    return new Row(children: <Widget>[
      Expanded(
        flex: 8,
        child: new TextFormField(
          controller: rutCtrl,
          textAlign: TextAlign.right,
          //initialValue: valorInicial,
          maxLength: 8,
          decoration: InputDecoration(
              border: UnderlineInputBorder(),
              filled: true,
              icon: Icon(Icons.vpn_key),
              hintText: esObligatorio ? "ingrese rut *" : "Ingrese Rut",
              labelText: "Identificación"),
          keyboardType: TextInputType.numberWithOptions(
            signed: false,
            decimal: false,
          ),
          inputFormatters: <TextInputFormatter>[
            rFormateo,
            // Fit the validating format.
          ],
          validator: (value) {
            cambiaFormulario = true;
            dvCtrl.text = obtieneDV(value);
            return;
          },
          onSaved: onFieldSubmitted,
        ),
      ),
      Expanded(
          flex: 1,
          child: new Text(" - ",
              style: TextStyle(color: Colors.green[800], fontSize: 56.0))),
      Expanded(
        flex: 1,
        child: new TextFormField(
          controller: dvCtrl,
          enabled: false,
          textAlign: TextAlign.center,
          maxLength: 1,
          decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            filled: true,
            hintText: 'D',
            labelText: '',
          ),
          keyboardType: TextInputType.text,
          onSaved: onFieldSubmitted,
          inputFormatters: <TextInputFormatter>[
            dvFormateo,
            // Fit the validating format.
          ],
        ),
      ),
    ]);
  }
}

class CorreoTD extends StatelessWidget {
  final String valorInicial;
  final bool esObligatorio;
  final bool puedeSerNulo;
  final ValueChanged<String> onFieldSubmitted;

  CorreoTD(
      {this.valorInicial,
      this.esObligatorio,
      this.puedeSerNulo,
      this.onFieldSubmitted});

  bool esCorreoValido(String value) {
    if (puedeSerNulo && value.isEmpty) return true;
    final RegExp regex = new RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
    return regex.hasMatch(value);
  }

  @override
  Widget build(BuildContext context) {
    return new TextFormField(
      textAlign: TextAlign.left,
      maxLength: 50,
      initialValue: valorInicial,
      decoration: InputDecoration(
        border: UnderlineInputBorder(),
        filled: true,
        icon: Icon(Icons.email),
        //hintText: esObligatorio ? "ingrese correo *" : "Ingrese correo",
        labelText: 'Ingrese correo',
      ),
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
          if (esCorreoValido(value))
          return null;
        else
          return "Correo inválido!";
      },
      onSaved: onFieldSubmitted,
    );
  }
}

class FonoTD extends StatelessWidget {
  /*
56 XXX-XXX-XXX.
https://es.wikipedia.org/wiki/Anexo:Prefijos_telef%C3%B3nicos_de_Chile
*/
  final String hintText;
  final String labelTex;
  final String valorInicial;
  final bool esObligatorio;
  final bool puedeSerNulo;
  final ValueChanged<String> onFieldSubmitted;

  FonoTD({
      this.hintText,
      this.labelTex,
      this.valorInicial,
      this.esObligatorio,
      this.puedeSerNulo,
      this.onFieldSubmitted});


  String _validatePhoneNumber(String value) {
    //
    String nR=value.replaceAll("-", "");
    if(nR.length!=9) return "Entre formato chileno XXX-XXX-XXX";
    return null;
  }

  @override
  Widget build(BuildContext context) {
    _FormateoFono fm = _FormateoFono();
    String miFono=fm.getFto(valorInicial);
    return TextFormField(
      decoration: InputDecoration(
        border: UnderlineInputBorder(),
        filled: true,
        icon: Icon(Icons.phone),
        hintText: hintText + (esObligatorio ? " *" : ""),
        labelText: "Fono",
        prefixText: '+56 ',
      ),
      maxLength: 11,
      initialValue: miFono,
      keyboardType: TextInputType.phone,
      onSaved: onFieldSubmitted,
      validator: _validatePhoneNumber,
      inputFormatters: <TextInputFormatter>[
       fm,
        // Fit the validating format.
      ],
    );
  }
}

class EnteroTD extends StatelessWidget {

  final String hintText;
  final String labelText;
  final int valorInicial;
  final bool esObligatorio;
  final bool puedeSerNulo;
  final double desde;
  final bool estrictoDesde;
  final double hasta;
  final bool estrictoHasta;

  final ValueChanged<String> onFieldSubmitted;

  EnteroTD(
      { this.hintText,
        this.labelText,
        this.valorInicial,
      this.esObligatorio,
      this.puedeSerNulo,
      this.desde,
      this.estrictoDesde,
      this.hasta,
      this.estrictoHasta,
      this.onFieldSubmitted});


  String _validateEntero(String value) {
    if (puedeSerNulo && value.isEmpty) return null;
    var miEntero = int.tryParse(value.replaceAll(".", ""));
    if (miEntero == null) return "Número mal formado";

    if (estrictoDesde && miEntero.toDouble() < desde)
      return "Número muy pequeño";
    else if (miEntero.toDouble() <= desde) return "Número muy pequeño";

    if (estrictoHasta && miEntero.toDouble() > hasta)
      return "Número muy Grande";
    else if (miEntero.toDouble() >= hasta) return "Número muy grande";

    return null;
  }

  String getMascara() {
    double mayor = desde.abs() >= hasta.abs() ? desde.abs() : hasta.abs();
    print("mayor=$mayor");
    if (mayor < 10.0) return "#";
    if (mayor < 100.0) return "##";
    if (mayor < 1000.0) return "###";
    if (mayor < 10000.0) return "#,###";
    if (mayor < 100000.0) return "##,###";
    if (mayor < 1000000.0) return "###,###";
    if (mayor < 10000000.0) return "#,###,###";
    if (mayor < 100000000.0) return "##,###,###";
    if (mayor < 1000000000.0) return "###,###,###";
    return "#,###,###,###";
  }

  @override
  Widget build(BuildContext context) {
    String mascara=getMascara();
    print(mascara);
    return TextFormField(
      decoration: InputDecoration(
        border: UnderlineInputBorder(),
        filled: true,
        icon: Icon(Icons.confirmation_number),
        hintText:  hintText + (esObligatorio ? " *" : ""),
        labelText: labelText,
      ),
      maxLength: mascara.length,
      initialValue:  valorInicial==0.0?"":alternoComa(valorInicial.toString()),
      keyboardType: TextInputType.number,
      onSaved: onFieldSubmitted,
      validator: _validateEntero,
      inputFormatters: <TextInputFormatter>[
        _FormateoEntero(mascara),
        // Fit the validating format.
      ],
    );
  }
}

class CantidadTD extends StatelessWidget {
  final String hintText;
  final String labelText;
  final IconData icono;
  final double valorInicial;
  final bool esObligatorio;
  final bool puedeSerNulo;
  final double desde;
  final bool estrictoDesde;
  final double hasta;
  final bool estrictoHasta;

  final ValueChanged<String> onFieldSubmitted;

  CantidadTD(
      {this.hintText,
      this.labelText,
      this.icono,
      this.valorInicial,
      this.esObligatorio,
      this.puedeSerNulo,
      this.desde,
      this.estrictoDesde,
      this.hasta,
      this.estrictoHasta,
      this.onFieldSubmitted});

  String _validaDecimal(String value) {
    //

    if (puedeSerNulo && value.isEmpty) return null;
    String nR = alternoComa(value);
    double miDouble = double.tryParse(nR);

    if (miDouble == null) return "Cantidad mal formada";

    if (estrictoDesde && miDouble < desde)
      return "Cantidad muy pequeña";
    else if (miDouble <= desde) return "Cantidad muy pequeña";

    if (estrictoHasta && miDouble > hasta)
      return "Cantidad muy grande";
    else if (miDouble >= hasta) return "Cantidad muy grande";

    return null;
  }

  String getMascara() {
    double mayor = desde.abs() >= hasta.abs() ? desde.abs() : hasta.abs();
    if (mayor < 10.0) return "#.##";
    if (mayor < 100.0) return "##.##";
    if (mayor < 1000.0) return "###.##";
    if (mayor < 10000.0) return "#,###.##";
    if (mayor < 100000.0) return "##,###.##";
    if (mayor < 1000000.0) return "###,###.##";
    if (mayor < 10000000.0) return "#,###,###.##";
    if (mayor < 100000000.0) return "##,###,###.##";
    if (mayor < 1000000000.0) return "###,###,###.##";
    return "#,###,###,###.##";
  }

  @override
  Widget build(BuildContext context) {
    String mascara=getMascara();
    return TextFormField(
      decoration: InputDecoration(
        border: UnderlineInputBorder(),
        filled: true,
        icon: Icon(icono),
        hintText: hintText + (esObligatorio ? " *" : ""),
        labelText: labelText,
      ),
      maxLength: mascara.length,
      initialValue: valorInicial==0?"":alternoComa(valorInicial.toString()),
      keyboardType: TextInputType.number,
      onSaved: onFieldSubmitted,



     // validator: _validaDecimal,
      inputFormatters: <TextInputFormatter>[
        _FormateoDecimal(mascara),
        ],
    );
  }
}

//Formateadores
//////////////////////////////////////////////////////////////

class _MascaraFormateo extends TextInputFormatter {
  final String mascara;

  _MascaraFormateo(this.mascara);

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = "";
    int selectionIndex = 0;

    final c = (newValue.text.length >= 1)
        ? newValue.text[newValue.text.length - 1]
        : "";

    if (mascara.contains(c)) {
      newText = newValue.text;
    } else {
      newText = oldValue.text;
    }
    selectionIndex = newText.length;
    return new TextEditingValue(
      text: newText.toString(),
      selection: new TextSelection.collapsed(offset: selectionIndex),
    );
  } //nc
} //no se usa


class _FormateoFono extends TextInputFormatter {
  //56 XXX XXX XXX.
  String getFto(String f){
    f=f.replaceAll("-", "");

    int ix=0;
    String linea="",b="";
    for(ix=0;ix<f.length;ix++){
      if(ix==2||ix==5) {
        b = "-";
      }
      linea=linea+f[ix]+b;
      b="";

    }
    return linea;
  }

  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.length == 0) {
      return newValue.copyWith(text: '');
    } else if (newValue.text.compareTo(oldValue.text) != 0) {
        String nR= getFto(newValue.text);


      return new TextEditingValue(
          selection: nR.length > oldValue.text.length
              ? new TextSelection.fromPosition(
              new TextPosition(offset: nR.length))
              : newValue.selection,
          text: nR);
    } else {
      return newValue;
    }
  }
}

class _FormateoEntero extends TextInputFormatter {
  String mascara;
  _FormateoEntero(this.mascara);

  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.length == 0) {
      return newValue.copyWith(text: '');
    } else if (newValue.text.compareTo(oldValue.text) != 0) {

      String nR;
      nR=newValue.text.replaceAll(".", "");

      int num = int.parse(nR);
      final f = new NumberFormat(mascara);
      nR = alternoComa(f.format(num));

      return new TextEditingValue(
          selection: nR.length > oldValue.text.length
              ? new TextSelection.fromPosition(
              new TextPosition(offset: nR.length))
              : newValue.selection,
          text: nR);
    } else {
      return newValue;
    }
  }
}

class _FormateoDecimal extends TextInputFormatter {
  String mascara;
  _FormateoDecimal(this.mascara);

  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.length == 0) {
      return newValue.copyWith(text: '');
    } else if (newValue.text.compareTo(oldValue.text) != 0) {

      String nR;
      String c = "";
      if (newValue.text.length > 0) c = newValue.text[newValue.text.length - 1];
      nR = alternoComa(newValue.text);

      double num = double.parse(nR);
      final f = new NumberFormat(mascara);
      nR = alternoComa(f.format(num));
      if (c == ",") nR += c;


      return new TextEditingValue(
          selection: nR.length > oldValue.text.length
              ? new TextSelection.fromPosition(
                  new TextPosition(offset: nR.length))
              : newValue.selection,
          text: nR);
    } else {
      return newValue;
    }
  }
}


///otra cosa mariposa
/////https://gist.github.com/BenSower/66002afb34b70a9911d2acc76dc6eb1b
TextEditingValue _selectionAwareTextManipulation(
  TextEditingValue value,
  String substringManipulation(String substring),
) {
  final int selectionStartIndex = value.selection.start;
  final int selectionEndIndex = value.selection.end;
  String manipulatedText;
  TextSelection manipulatedSelection;
  if (selectionStartIndex < 0 || selectionEndIndex < 0) {
    manipulatedText = substringManipulation(value.text);
  } else {
    final String beforeSelection =
        substringManipulation(value.text.substring(0, selectionStartIndex));
    final String inSelection = substringManipulation(
        value.text.substring(selectionStartIndex, selectionEndIndex));
    final String afterSelection =
        substringManipulation(value.text.substring(selectionEndIndex));
    manipulatedText = beforeSelection + inSelection + afterSelection;
    manipulatedSelection = value.selection.copyWith(
      baseOffset: beforeSelection.length,
      extentOffset: beforeSelection.length + inSelection.length,
    );
  }
  return new TextEditingValue(
    text: manipulatedText,
    selection:
        manipulatedSelection ?? const TextSelection.collapsed(offset: -1),
    composing:
        manipulatedText == value.text ? value.composing : TextRange.empty,
  );
}

class ShiftRemoverInputFormatter extends TextInputFormatter {
  /// Creates a formatter that prevents the insertion of 'shift' (codeUnit 0) chars
  /// This was done because the Samsung Keyboard sends 'shift' as codeUnit 0
  /// to flutter, ruining any input string like passwords or emails
  ///
  /// The [ShiftRemoverInputFormatter] must not be null.
  ShiftRemoverInputFormatter();

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue, // unused.
    TextEditingValue newValue,
  ) {
    return _selectionAwareTextManipulation(
      newValue,
      (String substring) {
        List<int> charCodes = new List();
        substring.runes.forEach((r) {
          if (r != 0) charCodes.add(r);
        });
        return new String.fromCharCodes(charCodes);
      },
    );
  }
}

class CurrencyInputFormatter extends TextInputFormatter {

  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {

    if(newValue.selection.baseOffset == 0){
      print(true);
      return newValue;
    }

    double value = double.parse(newValue.text);

    final formatter = new NumberFormat("###,###.###", "pt_br");

    String newText = formatter.format(value/100);

    return newValue.copyWith(
        text: newText,
        selection: new TextSelection.collapsed(offset: newText.length));
  }
}

String alternoComa(String value) {
  String nR = value.replaceAll(".", "X");
  nR = nR.replaceAll(",", ".");
  nR = nR.replaceAll("X", ",");
  return nR;
}

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados!";
  String _tabelaImc = "Abaixo do Peso: IMC menor que 18.6\n\n"
      "Peso Ideal: IMC entre 18.6 e 24.9 \n\n"
      "Levemente acima do Peso: IMC entre 24.9 e 29.9\n\n "
      "Obesidade Grau I:IMC entre 29.9 e 34.9\n\n "
      "Obesidade Grau II: IMC entre 34.9 e 40.0\n\n "
      "Obesidade Grau III: IMC Maior que 40 \n\n";

  void _resetFields() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "Informe seus dados!";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);
      if (imc < 18.6) {
        _infoText = "Abaixo do Peso (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 18.6 && imc < 24.9) {
        _infoText = "Peso Ideal (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 24.9 && imc < 29.9) {
        _infoText = "Levemente Acima do Peso (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 29.9 && imc < 34.9) {
        _infoText = "Obesidade Grau I (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 34.9 && imc < 40) {
        _infoText = "Obesidade Grau II (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 40.0) {
        _infoText = "Obesidade Grau III (${imc.toStringAsPrecision(3)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculadora de IMC"),
          centerTitle: true,
          backgroundColor: Colors.redAccent,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                _resetFields();
              },
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10.0, 2.0, 10.0, 2.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(Icons.person, size: 120.0, color: Colors.redAccent),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Peso(kg)",
                      labelStyle: TextStyle(color: Colors.redAccent)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.redAccent, fontSize: 25.0),
                  controller: weightController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Insira seu Peso!";
                    }
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Altura(cm)",
                      labelStyle: TextStyle(color: Colors.redAccent)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.redAccent, fontSize: 25.0),
                  controller: heightController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Insira sua Altura!";
                    }
                  },
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 25.0),
                  child: Container(
                    height: 50.0,
                    child: RaisedButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _calculate();
                        }
                      },
                      child: Text(
                        "Calcular",
                        style: TextStyle(color: Colors.black87, fontSize: 25.0),
                      ),
                      color: Colors.redAccent,
                    ),
                  ),
                ),
                Text(
                  _infoText,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.redAccent, fontSize: 25.0),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 25, 10, 25),
                  child: Text(
                    _tabelaImc,
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.redAccent, fontSize: 15.0),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

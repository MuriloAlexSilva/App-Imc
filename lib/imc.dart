import 'package:flutter/material.dart';

class IMC extends StatefulWidget {
  @override
  _IMCState createState() => _IMCState();
}

class _IMCState extends State<IMC> {
  final TextEditingController _alturaController = TextEditingController();
  final TextEditingController _pesoController = TextEditingController();
  final key = GlobalKey<
      ScaffoldState>(); //Para salvar o estado do Scaffold e utilizar em outros lugares
  //ex. no metodo abaixo
  var _resultado = "";
  var _situacao = "";

  _onItemTapped(int index) {
    if (index == 0) {
      _alturaController.clear(); //Para limpar o console altura
      _pesoController.clear(); //Para limpar o console peso
      setState(() {
        _resultado = "";
        _situacao = "";
      });
    } else if (_alturaController.text.isEmpty || _pesoController.text.isEmpty) {
      //se altura ou peso vazio
      key.currentState.showSnackBar(
          SnackBar(content: Text("Altura e peso são obrigatórios")));
      //Snackbar é a msg de interação com o usuario
    } else {
      try {
        var peso = double.parse(_pesoController.text);
        //Para passar de texto para double e fazer as contas como numeros
        var altura = double.parse(_alturaController.text);
        var imc = peso / (altura * altura);
        setState(() {
          _resultado =
              "Seu IMC é ${imc.toStringAsFixed(2)}"; //Para arredondar o decimal em 2 casas
          if (imc < 17) {
            _situacao = "Muito abaixo do peso";
          } else if ((imc >= 17) && (imc < 18.49)) {
            _situacao = "Abaixo do peso";
          } else if ((imc >= 18.50) && (imc < 24.99)) {
            _situacao = "Peso normal";
          } else if ((imc >= 25) && (imc < 29.99)) {
            _situacao = "Acima do peso";
          } else if ((imc >= 30) && (imc < 34.99)) {
            _situacao = "Obesidade I";
          } else if ((imc >= 35) && (imc < 39.99)) {
            _situacao = "Obesidade II (Severa)";
          } else {
            _situacao = "Obesidade III ( Mórbida)";
          }
        });
      } catch (e) {
        key.currentState.showSnackBar(SnackBar(
            content:
                Text("Altura ou peso foram informados em formato inválido. ")));
        //Snackbar

      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key, //Para utilizar o estado do scaffold
      appBar: AppBar(
        title: Text("Cálculo do IMC"),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap:
            _onItemTapped, //Para chamar o metodo onItemTapped, se for 0 limpar e 1 calcular
        backgroundColor: Colors.blue,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.clear, color: Colors.white),
            title: Text("Limpar",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check, color: Colors.white),
            title: Text("Calcular",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/balanca.png"),
            //Vc tem que instanciar ele antes do override,
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: _alturaController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                    hintText: "Altura",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    icon: Icon(Icons.accessibility)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                controller: _pesoController,
                decoration: InputDecoration(
                    hintText: "Peso",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    icon: Icon(Icons.person)),
              ),
            ),
            Text(
              "$_resultado",
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "$_situacao",
              style: TextStyle(fontSize: 20),
            )
          ],
        ),
      ),
    );
  }
}

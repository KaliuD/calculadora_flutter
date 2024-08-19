import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Calculadora'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var simbolos = ['C',1,2,3,'<-',4,5,6,'=',7,8,9,'+','-',0,',','x','/',];
  final _outputController = TextEditingController();
  var tela = '';
  Parser p = Parser();
  ContextModel cm = ContextModel();
  double resultado = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          children: [
            TextField(
              controller: _outputController,
              readOnly: true,
              textAlign: TextAlign.right,
              style: TextStyle(fontSize: 80.0),
            ),
            Expanded(
              // Center is a layout widget. It takes a single child and positions it
              // in the middle of the parent.
              child:
              GridView.builder(gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                  itemCount: simbolos.length,
                  itemBuilder: (context, index) =>
                      ElevatedButton(
                          onPressed: () => _botao_acionado(simbolos[index].toString()),
                          child:
                            Text(simbolos[index].toString(),
                            style: TextStyle(fontSize: 60.0),
                            )
                      )
              ),
            )
          ]
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  _botao_acionado(String string) {
    if(string.contains('C')){
      tela = '';
    }else if(string.contains('<-')){
      tela = tela.substring(0,tela.length - 1);
    }else if(string.contains('=')){
      calcular();
    }else{
      tela += string;
    }

    setState(() {
      _outputController.text = tela;
    });
  }

  calcular() {
    Expression exp = p.parse(tela);
    resultado = exp.evaluate(EvaluationType.REAL, cm);
    tela = resultado.toString();
  }
}

import 'package:calculator_app/components/my_button.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _inputQuestion = '';
  var _outputAnswer = '0';

  final List<String> _buttonList = [
    'C',
    'DEL',
    '%',
    '/',
    '9',
    '8',
    '7',
    'x',
    '6',
    '5',
    '4',
    '-',
    '3',
    '2',
    '1',
    '+',
    '0',
    '.',
    '^',
    '=',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      body: Column(children: [
        Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(
                  height: 50,
                ),
                Container(
                    padding: const EdgeInsets.all(20),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      _inputQuestion,
                      style: const TextStyle(fontSize: 25),
                    )),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Container(
                    decoration: const BoxDecoration(
                        border:
                            Border(bottom: BorderSide(color: Colors.black))),
                  ),
                ),
                Container(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, bottom: 20, top: 5),
                    alignment: Alignment.centerRight,
                    child: Text(
                      _outputAnswer,
                      style: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.w500),
                    )),
              ],
            )),
        Expanded(
            flex: 2,
            child: GridView.builder(
                itemCount: _buttonList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0) {
                    return MyButton(
                        buttonTapped: () {
                          setState(() {
                            _inputQuestion = '';
                            _outputAnswer = '0';
                          });
                        },
                        color: Colors.green,
                        textColor: Colors.white,
                        buttonText: _buttonList[index]);
                  } else if (index == 1) {
                    return MyButton(
                        buttonTapped: () {
                          setState(() {
                            _inputQuestion = _inputQuestion.substring(
                                0, _inputQuestion.length - 1);
                          });
                        },
                        color: Colors.red,
                        textColor: Colors.white,
                        buttonText: _buttonList[index]);
                  } else if (index == _buttonList.length - 1) {
                    return MyButton(
                        buttonTapped: () {
                          setState(() {
                            _calculate();
                          });
                        },
                        color: Colors.deepPurple,
                        textColor: Colors.white,
                        buttonText: _buttonList[index]);
                  } else {
                    return MyButton(
                        buttonTapped: () {
                          setState(() {
                            _inputQuestion += _buttonList[index];
                          });
                        },
                        color: _isOperator(_buttonList[index])
                            ? Colors.deepPurple
                            : Colors.deepPurple[50],
                        textColor: _isOperator(_buttonList[index])
                            ? Colors.white
                            : Colors.deepPurple,
                        buttonText: _buttonList[index]);
                  }
                })),
      ]),
    );
  }

  bool _isOperator(String x) {
    if (x == "%" ||
        x == "+" ||
        x == "-" ||
        x == "x" ||
        x == "/" ||
        x == '=' ||
        x == '^') {
      return true;
    }
    return false;
  }

  void _calculate() {
    String question = _inputQuestion;
    question = question.replaceAll('x', '*');

    Parser p = Parser();
    ContextModel model = ContextModel();

    try {
      Expression exp = p.parse(question);
      double eval = exp.evaluate(EvaluationType.REAL, model);
      _outputAnswer = eval.toString();
    } catch (e) {
      _outputAnswer = 'Invalid input.';
    }
  }
}

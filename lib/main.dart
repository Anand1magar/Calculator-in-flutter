import 'package:claculator/buttons.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override 
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var userQuestion = "";
  var userAnswer = "";
  final myTextStyle = TextStyle(fontSize: 30, color: Colors.indigo);

  final List<String> buttons = [
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
    '/',
    '0',
    '.',
    'ANS',
    '=',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(height: 50.0),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(  
                        userQuestion,
                        style: myTextStyle,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: Text(userAnswer, style: myTextStyle),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: GridView.builder(
                itemCount: buttons.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0) {
                    return MyButton(
                      buttonTapped: () {
                        setState(() {
                          userQuestion = " ";
                        });
                      },
                      buttonText: buttons[index],
                      color: Colors.green,
                      textColor: Colors.white,
                    );
                  } else if (index == 1) {
                    return MyButton(
                      buttonTapped: () {
                        setState(() {
                          userQuestion = userQuestion.substring(
                              0, userQuestion.length - 1);
                        });
                      },
                      buttonText: buttons[index],
                      color: Colors.red,
                      textColor: Colors.white,
                    );

                    //Equal button 
                  } else if (index == buttons.length - 1) {
                    return MyButton(
                      buttonTapped: () {
                        setState(() {
                          equalPress();
                        });
                      },
                      buttonText: buttons[index],
                      color: Colors.indigo[400],
                      textColor: Colors.white,
                    );
                  } else {
                    return MyButton(
                      buttonTapped: () {
                        setState(() {
                          userQuestion = userQuestion + buttons[index];
                        });
                      },
                      buttonText: buttons[index],
                      color: isOperator(buttons[index])
                          ? Colors.indigo[400]
                          : Colors.deepPurple[50],
                      textColor: isOperator(buttons[index])
                          ? Colors.white
                          : Colors.indigo[440],
                    );
                  }
                },
              ),
            ),
          ),
          Text(
            "Made by Anand Magar",
            style: TextStyle(fontSize: 15.0),
          )
        ],
      ),
    );
  }

  bool isOperator(String x) {
    if (x == '%' || x == '/' || x == 'x' || x == '-' || x == '=') {
      return true;
    } else
      return false;
  }

  void equalPress() {
    String finalQuestion = userQuestion;
    finalQuestion = finalQuestion.replaceAll('x', '*');

    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);

    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    userAnswer = eval.toString();
  }
}

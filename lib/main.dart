import 'package:flutter/material.dart';
import 'package:calculator/buttons.dart';
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
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
    '+',
    '0',
    '.',
    'ANS',
    '=',
  ];

  bool isOperator(String x) {
    if (x == '%' || x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
      return true;
    } else {
      return false;
    }
  }

  String userQues = '';
  String userAns = '';
  String ans = '';


  void equalPressed(){

    String finalQuestion = userQues;
    finalQuestion = finalQuestion.replaceAll('x', '*');
    finalQuestion = finalQuestion.replaceAll('ANS', ans.toString());
      Parser p = Parser();
      Expression exp = p.parse(finalQuestion);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);

    setState(() {
      userQues = '';
      userAns = eval.toString();
      ans = eval.toString();
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      body: Container(
        child: Column(
          children: [
            Expanded(flex: 1, child: Container(
              width: double.infinity,
              padding: EdgeInsets.only(top: 70, left: 10, right: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Text(userQues, style: TextStyle(fontSize: 25),),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(userAns, style: TextStyle(fontSize: 25),)
                    ],
                  )
                ],
              ),
            )),
            Expanded(
                flex: 2,
                child: Container(
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4),
                      itemCount: 20,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return MyButton(
                              onTap: () {
                                setState(() {
                                  userQues = '';
                                  userAns = '';
                                });
                              },
                              color: Colors.green,
                              textColor: Colors.white,
                              buttonText: buttons[index]);
                        } else if (index == 1) {
                          return MyButton(
                              onTap: () {
                                setState(() {
                                  userQues =
                                  userQues == "" ? "" : userQues.substring(
                                      0, userQues.length - 1);
                                });
                              },
                              color: Colors.redAccent,
                              textColor: Colors.white,
                              buttonText: buttons[index]);
                        } else if (index == 19) {
                          return MyButton(
                              onTap: () {
                                setState(() {
                                  equalPressed();
                                });
                              },
                              color: isOperator(buttons[index])
                                  ? Colors.deepPurple
                                  : Colors.deepPurple[50],
                              textColor: isOperator(buttons[index])
                                  ? Colors.white
                                  : Colors.deepPurple,
                              buttonText: buttons[index]);
                        } else {
                          return MyButton(
                              onTap: () {
                                setState(() {
                                  userQues += buttons[index];
                                  userAns = '';

                                });
                              },
                              color: isOperator(buttons[index])
                                  ? Colors.deepPurple
                                  : Colors.deepPurple[50],
                              textColor: isOperator(buttons[index])
                                  ? Colors.white
                                  : Colors.deepPurple,
                              buttonText: buttons[index]);
                        }
                      }),
                )),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Calculator',
      theme: ThemeData.light(),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  int result = 0;

  TextEditingController firstNumController = TextEditingController();
  TextEditingController secondNumController = TextEditingController();

  void calculate(String operation) {
    int num1 = int.tryParse(firstNumController.text) ?? 0;
    int num2 = int.tryParse(secondNumController.text) ?? 0;

    setState(() {
      switch (operation) {
        case '+':
          result = num1 + num2;
          break;
        case '-':
          result = num1 - num2;
          break;
        case '*':
          result = num1 * num2;
          break;
        case '/':
          result = num2 != 0 ? num1 ~/ num2 : 0;
          break;
      }
    });
  }

  void clear() {
    firstNumController.clear();
    secondNumController.clear();
    setState(() {
      result = 0;
    });
  }

  Widget operationRow(String operation) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: TextField(
              controller: firstNumController,
              decoration: const InputDecoration(labelText: "First Number"),
              keyboardType: TextInputType.number,
            ),
          ),
          Text(" $operation "),
          Expanded(
            child: TextField(
              controller: secondNumController,
              decoration: const InputDecoration(labelText: "Second Number"),
              keyboardType: TextInputType.number,
            ),
          ),
          Text(' = $result'),
          IconButton(
            icon: const Icon(Icons.calculate),
            onPressed: () => calculate(operation),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Unit 5 Calculator"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              operationRow('+'),
              operationRow('-'),
              operationRow('*'),
              operationRow('/'),
              ElevatedButton(
                onPressed: clear,
                child: const Text("Clear"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

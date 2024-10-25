import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  final TextEditingController addFirstNumController = TextEditingController();
  final TextEditingController addSecondNumController = TextEditingController();

  final TextEditingController subFirstNumController = TextEditingController();
  final TextEditingController subSecondNumController = TextEditingController();

  final TextEditingController mulFirstNumController = TextEditingController();
  final TextEditingController mulSecondNumController = TextEditingController();

  final TextEditingController divFirstNumController = TextEditingController();
  final TextEditingController divSecondNumController = TextEditingController();

  int addResult = 0;
  int subResult = 0;
  int mulResult = 0;
  int divResult = 0;

  @override
  void dispose() {
    addFirstNumController.dispose();
    addSecondNumController.dispose();
    subFirstNumController.dispose();
    subSecondNumController.dispose();
    mulFirstNumController.dispose();
    mulSecondNumController.dispose();
    divFirstNumController.dispose();
    divSecondNumController.dispose();
    super.dispose();
  }

  void add() {
    final num1 = int.tryParse(addFirstNumController.text) ?? 0;
    final num2 = int.tryParse(addSecondNumController.text) ?? 0;
    setState(() {
      addResult = num1 + num2;
    });
  }

  void subtract() {
    final num1 = int.tryParse(subFirstNumController.text) ?? 0;
    final num2 = int.tryParse(subSecondNumController.text) ?? 0;
    setState(() {
      subResult = num1 - num2;
    });
  }

  void multiply() {
    final num1 = int.tryParse(mulFirstNumController.text) ?? 0;
    final num2 = int.tryParse(mulSecondNumController.text) ?? 0;
    setState(() {
      mulResult = num1 * num2;
    });
  }

  void divide() {
    final num1 = int.tryParse(divFirstNumController.text) ?? 0;
    final num2 = int.tryParse(divSecondNumController.text) ?? 0;
    setState(() {
      divResult = (num2 != 0) ? num1 ~/ num2 : 0;
    });
  }

  void clearFields(TextEditingController firstController,
      TextEditingController secondController, Function resetResult) {
    firstController.clear();
    secondController.clear();
    resetResult();
    setState(() {});
  }

  Widget operationRow(
      String operation,
      VoidCallback onPressed,
      TextEditingController firstController,
      TextEditingController secondController,
      int result,
      Function resetResult) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: firstController,
            decoration: const InputDecoration(labelText: "First Number"),
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(operation, style: const TextStyle(fontSize: 20)),
        ),
        Expanded(
          child: TextField(
            controller: secondController,
            decoration: const InputDecoration(labelText: "Second Number"),
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          ),
        ),
        const SizedBox(width: 10),
        Text('= $result', style: const TextStyle(fontSize: 18)),
        const SizedBox(width: 10),
        IconButton(
          onPressed: onPressed,
          icon: Text(
            operation,
            style: const TextStyle(fontSize: 24),
          ),
          padding: const EdgeInsets.all(8),
          color: Colors.blue,
          tooltip: 'Perform $operation',
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: () =>
              clearFields(firstController, secondController, resetResult),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.redAccent,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          ),
          child: const Text(
            "Clear",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
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
        child: Column(
          children: [
            operationRow(
                '+',
                add,
                addFirstNumController,
                addSecondNumController,
                addResult,
                () => setState(() => addResult = 0)),
            const SizedBox(height: 10),
            operationRow(
                '-',
                subtract,
                subFirstNumController,
                subSecondNumController,
                subResult,
                () => setState(() => subResult = 0)),
            const SizedBox(height: 10),
            operationRow(
                '×',
                multiply,
                mulFirstNumController,
                mulSecondNumController,
                mulResult,
                () => setState(() => mulResult = 0)),
            const SizedBox(height: 10),
            operationRow(
                '÷',
                divide,
                divFirstNumController,
                divSecondNumController,
                divResult,
                () => setState(() => divResult = 0)),
          ],
        ),
      ),
    );
  }
}

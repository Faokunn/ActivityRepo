import 'package:application/widget/CustomButton.dart';
import 'package:application/widget/CustomTextField.dart';
import 'package:flutter/material.dart';

class AssignmentOne extends StatefulWidget {
  const AssignmentOne({super.key});

  @override
  State<AssignmentOne> createState() => _AssignmentOneState();
}

class _AssignmentOneState extends State<AssignmentOne> {
  final TextEditingController firstNumberController = TextEditingController();
  final TextEditingController secondNumberController = TextEditingController();
  String result = "";
  

  @override
  void dispose() {
    firstNumberController.dispose();
    secondNumberController.dispose();
    super.dispose();
  }

  void calculator(String calculation) {
    final firstNumber = double.tryParse(firstNumberController.text);
    final secondNumber = double.tryParse(secondNumberController.text);
    double operationResult = 0;

    if (firstNumber == null || secondNumber == null) {
      setState(() {
        result = "Invalid";
      });
      return;
    }

    switch (calculation) {
      case "+":
        operationResult = firstNumber + secondNumber;
        break;
      case "-":
        operationResult = firstNumber - secondNumber;
        break;
      case "/":
        if (firstNumber == 0 || secondNumber == 0) {
          setState(() {
            result = "Invalid";
          });
        }
        operationResult = firstNumber / secondNumber;
        break;
      case "*":
        operationResult = firstNumber * secondNumber;
        break;
      default:
        return;
    }
    setState(() {
      result = operationResult.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
        title: const Text("Assignment One"),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: Container(
            alignment: Alignment.center,
            height: 250,
            width: 400,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 166, 169, 177),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.black, width: 2),
            ),
            child: Wrap(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      const Text(
                        "DIGI-CAL",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(myController: firstNumberController, text: "First Number"),
                      const SizedBox(height: 10),
                      CustomTextField(myController: secondNumberController, text: "Second Number"),
                      const SizedBox(height: 10),
                      Container(
                        width: 200,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          "RESULT: $result",
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.greenAccent,
                            fontFamily: 'monospace',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Custombutton(onPressed: () => calculator("+"), text: "+"),
                      const SizedBox(height: 10),
                      Custombutton(onPressed: () => calculator("-"), text: "-"),
                      const SizedBox(height: 10),
                      Custombutton(onPressed: () => calculator("/"), text: "/"),
                      const SizedBox(height: 10),
                      Custombutton(onPressed: () => calculator("*"), text: "*")
                    ],
                  ),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
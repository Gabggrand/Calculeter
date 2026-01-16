import 'package:flutter/material.dart';
import 'package:flutter_application_1/enums/operation.type.dart';
import 'package:flutter_application_1/widgets/button.widget.dart';

class Calculeter extends StatefulWidget {
  const Calculeter({super.key});

  @override
  State<Calculeter> createState() => CalculeterState();
}

class CalculeterState extends State<Calculeter> {
  late String displayNumber;
  bool isResult = false;
  OperationTypeEnum? operationType;

  @override
  void initState() {
    displayNumber = '0';
    super.initState();
  }

  void setOperationType(OperationTypeEnum newtype) {
    if (operationType != null) return;

    setState(() {
      operationType = newtype;
      displayNumber += newtype.symbol;
    });
  }

  void clear() {
    setState(() {
      displayNumber = '0';
      operationType = null;
      isResult = false;
    });
  }

  void appendNumber(String stringNumber) {
    setState(() {
      if (isResult) {
        displayNumber = stringNumber;
        isResult = false;
        return;
      }

      if (displayNumber == '0') {
        displayNumber = stringNumber;
      } else {
        displayNumber += stringNumber;
      }
    });
  }

  void backspace() {
    setState(() {
      if (isResult) {
        displayNumber = '0';
        isResult = false;
        return;
      }

      if (displayNumber.length <= 1) {
        displayNumber = '0';
      } else {
        displayNumber = displayNumber.substring(0, displayNumber.length - 1);
      }
    });
  }

  void calculate() {
    if (operationType == null) return;

    final symbol = operationType!.symbol;

    if (!displayNumber.contains(symbol)) return;

    final parts = displayNumber.split(symbol);

    if (parts.length != 2) return;

    final num1 = double.tryParse(parts[0].replaceAll(',', '.'));
    final num2 = double.tryParse(parts[1].replaceAll(',', '.'));

    if (num1 == null || num2 == null) return;

    double result;

    switch (operationType!) {
      case OperationTypeEnum.addition:
        result = num1 + num2;
        break;
      case OperationTypeEnum.subtration:
        result = num1 - num2;
        break;
      case OperationTypeEnum.multiplication:
        result = num1 * num2;
        break;
      case OperationTypeEnum.division:
        if (num2 == 0) {
          displayNumber = 'Erro';
          operationType = null;
          setState(() {});
          return;
        }
        result = num1 / num2;
        break;
    }

    setState(() {
      displayNumber = result
          .toString()
          .replaceAll('.', ',')
          .replaceAll(RegExp(r',0+$'), '');
      operationType = null;
      isResult = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculadora')),
      body: Column(
        children: [
          // DISPLAY
          Container(
            height: 208,
            width: double.maxFinite,
            color: Colors.black12,
            child: Align(
              alignment: Alignment.bottomRight,
              child: Text(
                displayNumber,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.right,
                style: const TextStyle(fontSize: 48),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // BOTÕES
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ButtonWidget(
                    text: "C",
                    color: Colors.red,
                    onPressed: () {
                      clear();
                    },
                  ),
                  ButtonWidget(
                    text: "⌫",
                    color: Colors.orange,
                    onPressed: () {
                      backspace();
                    },
                  ),
                  ButtonWidget(
                    text: "÷",
                    color: Colors.blue,
                    textColor: Colors.white,
                    onPressed: () {
                      setOperationType(OperationTypeEnum.division);
                    },
                  ),
                ],
              ),

              Row(
                children: [
                  ButtonWidget(
                    text: "7",
                    onPressed: () {
                      appendNumber("7");
                    },
                  ),
                  ButtonWidget(
                    text: "8",
                    onPressed: () {
                      appendNumber("8");
                    },
                  ),
                  ButtonWidget(
                    text: "9",
                    onPressed: () {
                      appendNumber("9");
                    },
                  ),
                  ButtonWidget(
                    text: "x",
                    color: Colors.blue,
                    textColor: Colors.white,
                    onPressed: () {
                      setOperationType(OperationTypeEnum.multiplication);
                    },
                  ),
                ],
              ),

              Row(
                children: [
                  ButtonWidget(
                    text: "4",
                    onPressed: () {
                      appendNumber("4");
                    },
                  ),
                  ButtonWidget(
                    text: "5",
                    onPressed: () {
                      appendNumber("5");
                    },
                  ),
                  ButtonWidget(
                    text: "6",
                    onPressed: () {
                      appendNumber("6");
                    },
                  ),
                  ButtonWidget(
                    text: "-",
                    color: Colors.blue,
                    textColor: Colors.white,
                    onPressed: () {
                      setOperationType(OperationTypeEnum.subtration);
                    },
                  ),
                ],
              ),

              Row(
                children: [
                  ButtonWidget(
                    text: "1",
                    onPressed: () {
                      appendNumber("1");
                    },
                  ),
                  ButtonWidget(
                    text: "2",
                    onPressed: () {
                      appendNumber("2");
                    },
                  ),
                  ButtonWidget(
                    text: "3",
                    onPressed: () {
                      appendNumber("3");
                    },
                  ),
                  ButtonWidget(
                    text: "+",
                    color: Colors.blue,
                    textColor: Colors.white,
                    onPressed: () {
                      setOperationType(OperationTypeEnum.addition);
                    },
                  ),
                ],
              ),

              Row(
                children: [
                  ButtonWidget(
                    text: "0",
                    onPressed: () {
                      appendNumber("0");
                    },
                  ),
                  ButtonWidget(
                    text: ",",
                    onPressed: () {
                      appendNumber(",");
                    },
                  ),
                  ButtonWidget(
                    text: "=",
                    color: Colors.green,
                    onPressed: () {
                      calculate();
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  static const double buttonSize = 80.0;
  static const double buttonPadding = 5.0;
  static const TextStyle buttonTextStyle = TextStyle(
    fontSize: 30.0,
    color: Colors.pinkAccent,
    fontFamily: 'Love',
  );

  String _displayText = '0';
  double? _firstOperand;
  String? _operation;
  bool _isResultCalculated = false;

  void _onNumberClick(String text) {
    if (_isResultCalculated) {
      setState(() {
        _displayText = text;
        _isResultCalculated = false;
      });
    } else {
      if (_displayText == '0' && text != '.') {
        setState(() {
          _displayText = text;
        });
      } else if (text == '.') {
        if (!_displayText.contains('.')) {
          setState(() {
            _displayText += text;
          });
        }
      } else {
        setState(() {
          _displayText += text;
        });
      }
    }
  }

  void _onOperationClick(String op) {
    if (_firstOperand == null) {
      setState(() {
        _firstOperand = double.parse(_displayText);
        _operation = op;
        _displayText = '0'; // Reset the display text to 0
      });
    } else {
      if (_operation != null) {
        double secondOperand = double.parse(_displayText);
        double result = _performOperation(_firstOperand!, secondOperand, _operation!);
        setState(() {
          _displayText = _formatResult(result);
          _firstOperand = result;
          _operation = op;
        });
      } else {
        _operation = op;
      }
    }
  }

  double _performOperation(double a, double b, String op) {
    switch (op) {
      case '+':
        return a + b;
      case '-':
        return a - b;
      case '×':
        return a * b;
      case '÷':
        if (b != 0) {
          return a / b;
        } else {
          // Handle division by zero
          return double.nan; // Return NaN (Not a Number) instead of infinity
        }
      default:
        throw Exception('Unsupported operation');
    }
  }

  String _formatResult(double result) {
    
    if (result == result.toInt()) {
      return result.toInt().toString();
    } else {
      return result.toStringAsFixed(2).replaceAll(RegExp(r'(\.0*|(?<=\.\d*)0+)$'), '');
    }
  }

  void _onEqualsClick() {
    if (_firstOperand != null && _operation != null) {
      double secondOperand = double.parse(_displayText);
      double result = _performOperation(_firstOperand!, secondOperand, _operation!);

      setState(() {
        _displayText = _formatResult(result);
        _firstOperand = null;
        _operation = null;
        _isResultCalculated = true;
      });
    }
  }

  void _onClearClick() {
    setState(() {
      _displayText = '0';
      _firstOperand = null;
      _operation = null;
    });
  }

  void _onNegateClick() {
    double value = double.parse(_displayText);
    setState(() {
      _displayText = (-value).toString();
    });
  }

  void _onPercentageClick() {
    double value = double.parse(_displayText);
    setState(() {
      _displayText = (value / 100).toString();
    });
  }

  Widget _calcButton(String btntxt, Color btncolor, Color txtcolor, {VoidCallback? onPressed}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        backgroundColor: btncolor,
        minimumSize: Size(buttonSize, buttonSize),
        padding: EdgeInsets.all(buttonPadding),
      ),
      child: Text(
        btntxt,
        style: buttonTextStyle.copyWith(color: txtcolor),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[200],
        title: const Text(
          'Calculator',
          style: TextStyle(color: Colors.white,fontFamily: 'TheSally', fontSize: 30.0),
        ),
      ),
      backgroundColor: Colors.pink[100],
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    _displayText,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 80,
                      fontFamily: 'TheSally'
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _calcButton('AC', Colors.white38, Colors.pinkAccent, onPressed: _onClearClick),
                _calcButton('+/-', Colors.white38, Colors.pinkAccent, onPressed: _onNegateClick),
                _calcButton('%', Colors.white38, Colors.pinkAccent, onPressed: _onPercentageClick),
                _calcButton('÷', Colors.white, Colors.pinkAccent, onPressed: () {
                  _onOperationClick('÷');
                }),
              ],
            ),
            const SizedBox(height: 10.0),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _calcButton('7', Colors.grey[600]!, Colors.pinkAccent, onPressed: () {
                  _onNumberClick('7');
                }),
                _calcButton('8', Colors.grey[600]!, Colors.pinkAccent, onPressed: () {
                  _onNumberClick('8');
                }),
                _calcButton('9', Colors.grey[600]!, Colors.pinkAccent, onPressed: () {
                  _onNumberClick('9');
                }),
                _calcButton('×', Colors.white, Colors.pinkAccent, onPressed: () {
                  _onOperationClick('×');
                }),
              ],
            ),
            const SizedBox(height: 10.0),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _calcButton('4', Colors.grey[600]!, Colors.pinkAccent, onPressed: () {
                  _onNumberClick('4');
                }),
                _calcButton('5', Colors.grey[600]!, Colors.pinkAccent, onPressed: () {
                  _onNumberClick('5');
                }),
                _calcButton('6', Colors.grey[600]!, Colors.pinkAccent, onPressed: () {
                  _onNumberClick('6');
                }),
                _calcButton('-', Colors.white, Colors.pinkAccent, onPressed: () {
                  _onOperationClick('-');
                }),
              ],
            ),
            const SizedBox(height: 10.0),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _calcButton('1', Colors.grey[600]!, Colors.pinkAccent, onPressed: () {
                  _onNumberClick('1');
                }),
                _calcButton('2', Colors.grey[600]!, Colors.pinkAccent, onPressed: () {
                  _onNumberClick('2');
                }),
                _calcButton('3', Colors.grey[600]!, Colors.pinkAccent, onPressed: () {
                  _onNumberClick('3');
                }),
                _calcButton('+', Colors.white, Colors.pinkAccent, onPressed: () {
                  _onOperationClick('+');
                }),
              ],
            ),
            const SizedBox(height: 10.0),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _onNumberClick('0');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[600]!,
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.fromLTRB(34, 10, 128, 20),
                    ),
                    child: Text('0', style: buttonTextStyle.copyWith(color: Colors.pinkAccent)),
                  ),
                  _calcButton('.', Colors.grey[600]!, Colors.pinkAccent, onPressed: () {
                    _onNumberClick('.');
                  }),
                  _calcButton('=', Colors.white, Colors.pinkAccent, onPressed: _onEqualsClick),
                ],
              ),
            ),
            const SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }
}
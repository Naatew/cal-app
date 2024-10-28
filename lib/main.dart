import 'package:flutter/material.dart';

void main() => runApp(CalculatorApp());

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.teal,
      ),
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _displayText = '0';
  String _currentInput = '';
  String _operation = '';
  double _firstOperand = 0;

  // Update display text with current input and operation
  void _updateDisplay(String value) {
    setState(() {
      _displayText = value;
    });
  }

  // Number button handler
  void _onNumberPressed(String number) {
    setState(() {
      _currentInput += number;
      _updateDisplay(_currentInput);
    });
  }

  // Operation handler (+, -, *, /)
  void _onOperatorPressed(String operator) {
    setState(() {
      _firstOperand = double.tryParse(_currentInput) ?? 0;
      _operation = operator;
      _currentInput = '';
      // Update display to show the first operand and operation
      _updateDisplay('$_firstOperand $_operation');
    });
  }

  // Equals button handler
  void _onEqualsPressed() {
    setState(() {
      double secondOperand = double.tryParse(_currentInput) ?? 0;
      double result;
      switch (_operation) {
        case '+':
          result = _firstOperand + secondOperand;
          break;
        case '-':
          result = _firstOperand - secondOperand;
          break;
        case '*':
          result = _firstOperand * secondOperand;
          break;
        case '/':
          result = secondOperand != 0 ? _firstOperand / secondOperand : 0;
          break;
        default:
          result = 0;
          break;
      }
      _updateDisplay(result.toString());
      _currentInput = '';
      _operation = '';
    });
  }

  // Clear button handler
  void _onClearPressed() {
    setState(() {
      _currentInput = '';
      _firstOperand = 0;
      _operation = '';
      _updateDisplay('0');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Calculator'),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              color: Colors.black,
              child: Text(
                _displayText,
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          _buildButtonRow(['C', '()', '%', '÷'], Colors.green, Colors.red),
          _buildButtonRow(['7', '8', '9', '×'], Colors.green),
          _buildButtonRow(['4', '5', '6', '-'], Colors.green),
          _buildButtonRow(['1', '2', '3', '+'], Colors.green),
          _buildButtonRow(['+/-', '0', '.', '='], Colors.green, Colors.green[800]),
        ],
      ),
    );
  } Widget _buildButtonRow(List<String> labels, Color operatorColor, [Color? specialColor]) {
  return Row(
    children: labels.map((label) {
      return _buildButton(
        label,
        label == 'C'
            ? (_) => _onClearPressed()
            : label == '='
                ? (_) => _onEqualsPressed()
                : label == '+' || label == '-' || label == '×' || label == '÷'
                    ? _onOperatorPressed
                    : _onNumberPressed,
        // Use specialColor if it's provided; otherwise, fall back to Colors.black
        label == 'C'
            ? (specialColor ?? Colors.black)
            : (label == '+' || label == '-' || label == '×' || label == '÷' || label == '=')
                ? operatorColor
                : Colors.grey[850]!,
      );
    }).toList(),
  );
}


  // Helper method to create individual buttons with rounded style
  Widget _buildButton(String label, Function(String) onPressed, Color color) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            shape: CircleBorder(),
            padding: EdgeInsets.all(24),
          ),
          onPressed: () => onPressed(label),
          child: Text(
            label,
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

void main() => runApp(CalculatorApp());

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData.dark(),
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

  // Update display text
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
      _currentInput = '';
      _operation = operator;
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
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.all(20),
              child: Text(
                _displayText,
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Row(
            children: <Widget>[
              _buildButton('7', _onNumberPressed),
              _buildButton('8', _onNumberPressed),
              _buildButton('9', _onNumberPressed),
              _buildButton('/', _onOperatorPressed),
            ],
          ),
          Row(
            children: <Widget>[
              _buildButton('4', _onNumberPressed),
              _buildButton('5', _onNumberPressed),
              _buildButton('6', _onNumberPressed),
              _buildButton('*', _onOperatorPressed),
            ],
          ),
          Row(
            children: <Widget>[
              _buildButton('1', _onNumberPressed),
              _buildButton('2', _onNumberPressed),
              _buildButton('3', _onNumberPressed),
              _buildButton('-', _onOperatorPressed),
            ],
          ),
          Row(
            children: <Widget>[
              _buildButton('0', _onNumberPressed),
              _buildButton('C', (String _) => _onClearPressed()),
              _buildButton('=', (String _) => _onEqualsPressed()),
              _buildButton('+', _onOperatorPressed),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String label, Function(String) onPressed) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () => onPressed(label),
          child: Text(
            label,
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}

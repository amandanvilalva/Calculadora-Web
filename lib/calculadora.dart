import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart';

class Calculadora extends StatefulWidget {
  const Calculadora({super.key});

  @override
  State<Calculadora> createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  String _expressao = '';
  String _resultado = '';

  void _pressionarBotao(String valor) {
    setState(() {
      if (valor == 'C') {
        _expressao = '';
        _resultado = '';
      } else if (valor == '=') {
        _calcularResultado();
      } else if (valor == '⌫') {
        if (_expressao.isNotEmpty) {
          _expressao = _expressao.substring(0, _expressao.length - 1);
        }
      } else {
        _expressao += valor;
      }
    });
  }

  void _calcularResultado() {
    try {
      _resultado = _avaliarExpressao(_expressao).toString();
    } catch (e) {
      _resultado = 'Erro';
    }
  }

  double _avaliarExpressao(String expressao) {
    expressao = expressao.replaceAll('x', '*');
    expressao = expressao.replaceAll('÷', '/');
    ExpressionEvaluator avaliador = const ExpressionEvaluator();
    return avaliador.eval(Expression.parse(expressao), {});
  }

  Widget _botao(String texto, {Color cor = Colors.yellow}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: cor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        shadowColor: Colors.grey.shade300,
        elevation: 5,
      ),
      onPressed: () => _pressionarBotao(texto),
      child: Text(
        texto,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.amber.shade50,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(4, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                _expressao,
                style: const TextStyle(fontSize: 28, color: Colors.brown),
                textAlign: TextAlign.right,
              ),
            ),
          ),
          const Divider(color: Colors.brown),
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                _resultado,
                style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown),
                textAlign: TextAlign.right,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            flex: 8,
            child: GridView.count(
              crossAxisCount: 4,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              children: [
                _botao('(', cor: Colors.yellow.shade200),
                _botao(')', cor: Colors.yellow.shade200),
                _botao('⌫', cor: Colors.orange.shade300),
                _botao('C', cor: Colors.red.shade300),
                _botao('7', cor: Colors.yellow.shade100),
                _botao('8', cor: Colors.yellow.shade100),
                _botao('9', cor: Colors.yellow.shade100),
                _botao('÷', cor: Colors.orange.shade400),
                _botao('4', cor: Colors.yellow.shade100),
                _botao('5', cor: Colors.yellow.shade100),
                _botao('6', cor: Colors.yellow.shade100),
                _botao('x', cor: Colors.orange.shade400),
                _botao('1', cor: Colors.yellow.shade100),
                _botao('2', cor: Colors.yellow.shade100),
                _botao('3', cor: Colors.yellow.shade100),
                _botao('-', cor: Colors.orange.shade400),
                _botao('0', cor: Colors.yellow.shade100),
                _botao('.', cor: Colors.yellow.shade100),
                _botao('=', cor: Colors.orange.shade700),
                _botao('+', cor: Colors.orange.shade400),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

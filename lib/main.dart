import 'dart:async';
import 'package:flutter/material.dart';
void main() => runApp(const MaterialApp(home: InicioQuiz()));
class Pregunta {
  final String enunciado;
  final List<String> opciones;
  final int correcta;

  Pregunta({required this.enunciado, required this.opciones, required this.correcta});
}
final preguntas = [
  Pregunta(enunciado: 'Capital de Bolivia', opciones: ['La Paz', 'Sucre', 'Cochabamba'], correcta: 1),
  Pregunta(enunciado: 'Lenguaje de Flutter', opciones: ['Java', 'Dart', 'Kotlin'], correcta: 1),
  Pregunta(enunciado: 'Planeta rojo', opciones: ['Venus', 'Marte', 'Júpiter'], correcta: 1),
  Pregunta(enunciado: 'Animal más grande', opciones: ['Elefante', 'Ballena azul', 'Jirafa'], correcta: 1),
  Pregunta(enunciado: 'Número pi aprox.', opciones: ['3.14', '2.71', '1.41'], correcta: 0),
  Pregunta(enunciado: 'Fundador de Microsoft', opciones: ['Steve Jobs', 'Bill Gates', 'Elon Musk'], correcta: 1),
];

class InicioQuiz extends StatelessWidget {
  const InicioQuiz({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('QuizRelámpago')),
      body: Center(
        child: ElevatedButton(
          child: const Text('Comenzar'),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => QuizPage()),
          ),
        ),
      ),
    );
  }
}
class QuizPage extends StatefulWidget {
  @override
  State<QuizPage> createState() => _QuizPageState();
}
class _QuizPageState extends State<QuizPage> {
  int indice = 0;
  int puntaje = 0;
  int tiempo = 10;
  Timer? _timer;
  int? seleccion;
  @override
  void initState() {
    super.initState();
    _iniciarTimer();
  }
  void _iniciarTimer() {
    _timer?.cancel();
    tiempo = 10;
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      setState(() {
        tiempo--;
        if (tiempo == 0) _siguiente();
      });
    });
  }
  void _siguiente() {
    _timer?.cancel();
    if (seleccion == preguntas[indice].correcta) puntaje++;
    if (indice < preguntas.length - 1) {
      setState(() {
        indice++;
        seleccion = null;
      });
      _iniciarTimer();
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => ResultadoQuiz(puntaje: puntaje)),
      );
    }
  }
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final p = preguntas[indice];
    return Scaffold(
      appBar: AppBar(title: Text('Pregunta ${indice + 1}/${preguntas.length}')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(p.enunciado, style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 12),
            LinearProgressIndicator(value: tiempo / 10),
            const SizedBox(height: 12),
            ...List.generate(p.opciones.length, (i) {
              final color = seleccion == null
                  ? null
                  : (i == p.correcta ? Colors.green[200] : (i == seleccion ? Colors.red[200] : null));
              return Card(
                color: color,
                child: ListTile(
                  title: Text(p.opciones[i]),
                  onTap: () => setState(() => seleccion = i),
                ),
              );
            }),
            const SizedBox(height: 12),
            ElevatedButton(onPressed: _siguiente, child: const Text('Siguiente')),
            Text('Tiempo: $tiempo s'),
          ],
        ),
      ),
    );
  }
}
class ResultadoQuiz extends StatelessWidget {
  final int puntaje;
  const ResultadoQuiz({super.key, required this.puntaje});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Resultados')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Tu puntaje final es: $puntaje',
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const InicioQuiz()),
              ),
              child: const Text('Volver a jugar'),
            ),
          ],
        ),
      ),
    );
  }
}

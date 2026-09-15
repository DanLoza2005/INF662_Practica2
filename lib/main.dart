<<<<<<< HEAD
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
=======
import 'package:flutter/material.dart';
<<<<<<< HEAD
void main() => runApp(const MaterialApp(home: GastoDiaApp()));
class Gasto {
  final double monto;
  final String descripcion;
  final String categoria;
  Gasto({required this.monto, required this.descripcion, required this.categoria});
}
class GastoDiaApp extends StatefulWidget {
  const GastoDiaApp({super.key});
  @override
  State<GastoDiaApp> createState() => _GastoDiaAppState();
}
class _GastoDiaAppState extends State<GastoDiaApp> {
  final _formKey = GlobalKey<FormState>();
  final _montoCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  String? _categoria;
  final List<Gasto> _gastos = [];
  @override
  void dispose() {
    _montoCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }
  void _agregarGasto() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _gastos.add(Gasto(
          monto: double.parse(_montoCtrl.text),
          descripcion: _descCtrl.text,
          categoria: _categoria!,
        ));
        _montoCtrl.clear();
        _descCtrl.clear();
        _categoria = null;
      });
    }
  }
  double get _total => _gastos.fold(0, (s, g) => s + g.monto);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GastoDía')),
>>>>>>> 4af5865fa7ee361fdbd7cee1594470c05526f03f
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
<<<<<<< HEAD
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
=======
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _montoCtrl,
                    decoration: const InputDecoration(labelText: 'Monto'),
                    keyboardType: TextInputType.number,
                    validator: (v) {
                      final valor = double.tryParse(v ?? '');
                      if (valor == null || valor <= 0) return 'Monto inválido';
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _descCtrl,
                    decoration: const InputDecoration(labelText: 'Descripción'),
                    validator: (v) => (v == null || v.isEmpty) ? 'Ingrese descripción' : null,
                  ),
                  DropdownButtonFormField<String>(
                    value: _categoria,
                    items: ['Comida', 'Transporte', 'Otros']
                        .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                        .toList(),
                    onChanged: (v) => setState(() => _categoria = v),
                    validator: (v) => v == null ? 'Seleccione categoría' : null,
                    decoration: const InputDecoration(labelText: 'Categoría'),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(onPressed: _agregarGasto, child: const Text('Agregar')),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text('Total: $_total Bs', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            Expanded(
              child: _gastos.isEmpty
                  ? const Center(child: Text('No hay gastos registrados'))
                  : ListView.builder(
                      itemCount: _gastos.length,
                      itemBuilder: (context, i) {
                        final g = _gastos[i];
                        return ListTile(
                          leading: CircleAvatar(child: Text(g.categoria[0])),
                          title: Text('${g.descripcion} - ${g.monto} Bs'),
                          subtitle: Text(g.categoria),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => setState(() => _gastos.removeAt(i)),
                          ),
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DetalleGasto(gasto: g),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
=======
void main() => runApp(const MaterialApp(home: EcoGuiaApp()));
class Especie {
  final String nombre;
  final String categoria;
  final String descripcion;
  final String curioso;
  Especie({
    required this.nombre,
    required this.categoria,
    required this.descripcion,
    required this.curioso,
  });
}
final especies = [
  Especie(
    nombre: 'Cóndor',
    categoria: 'Ave',
    descripcion: 'El cóndor andino es una de las aves más grandes del mundo.',
    curioso: 'Puede volar más de 200 km en un solo día.',
  ),
  Especie(
    nombre: 'Yareta',
    categoria: 'Planta',
    descripcion: 'Planta milenaria que crece en los Andes.',
    curioso: 'Algunas tienen más de 3000 años de edad.',
  ),
  Especie(
    nombre: 'Puma',
    categoria: 'Mamífero',
    descripcion: 'Felino que habita en gran parte de América.',
    curioso: 'Puede saltar hasta 5 metros de altura.',
  ),
  Especie(
    nombre: 'Kewiña',
    categoria: 'Árbol',
    descripcion: 'Árbol nativo de los Andes.',
    curioso: 'Resiste climas fríos y secos.',
  ),
  Especie(
    nombre: 'Flamenco',
    categoria: 'Ave',
    descripcion: 'Ave de patas largas que vive en lagunas altoandinas.',
    curioso: 'Su color rosado proviene de los pigmentos de su alimento.',
  ),
  Especie(
    nombre: 'Vizcacha',
    categoria: 'Roedor',
    descripcion: 'Roedor que vive en zonas rocosas de altura.',
    curioso: 'Se parece a un conejo pero no lo es.',
  ),
  Especie(
    nombre: 'Quinua',
    categoria: 'Planta',
    descripcion: 'Cereal andino de alto valor nutritivo.',
    curioso: 'Fue considerado sagrado por los Incas.',
  ),
  Especie(
    nombre: 'Lagarto',
    categoria: 'Reptil',
    descripcion: 'Reptil que habita en zonas cálidas.',
    curioso: 'Puede regenerar su cola si la pierde.',
  ),
];
class EcoGuiaApp extends StatefulWidget {
  const EcoGuiaApp({super.key});
  @override
  State<EcoGuiaApp> createState() => _EcoGuiaAppState();
}
class _EcoGuiaAppState extends State<EcoGuiaApp> {
  String filtro = '';
  @override
  Widget build(BuildContext context) {
    final listaFiltrada = especies.where((e) =>
      e.nombre.toLowerCase().contains(filtro.toLowerCase())).toList();
    return Scaffold(
      appBar: AppBar(title: const Text('EcoGuía')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Buscar especie...',
                border: OutlineInputBorder(),
              ),
              onChanged: (valor) => setState(() => filtro = valor),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3/2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: listaFiltrada.length,
              itemBuilder: (context, i) {
                final e = listaFiltrada[i];
                return Card(
                  child: InkWell(
                    onTap: () async {
                      final favorito = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => FichaEspecie(especie: e),
                        ),
                      );
                      if (favorito == true) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('${e.nombre} marcado como favorito')),
                        );
                      }
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.eco, size: 40, color: Colors.green),
                        Text(e.nombre, style: const TextStyle(fontWeight: FontWeight.bold)),
                        Text(e.categoria),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
>>>>>>> 2de65dcb6a757224ccccf71c24935d02a6606b1c
      ),
    );
  }
}
<<<<<<< HEAD
class DetalleGasto extends StatelessWidget {
  final Gasto gasto;
  const DetalleGasto({super.key, required this.gasto});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalle del gasto')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Monto: ${gasto.monto} Bs'),
            Text('Descripción: ${gasto.descripcion}'),
            Text('Categoría: ${gasto.categoria}'),
          ],
        ),
=======
class FichaEspecie extends StatelessWidget {
  final Especie especie;
  const FichaEspecie({super.key, required this.especie});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(especie.nombre)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(especie.descripcion, style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 12),
          Text('Dato curioso: ${especie.curioso}'),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Marcar como favorito'),
          ),
        ],
>>>>>>> 2de65dcb6a757224ccccf71c24935d02a6606b1c
>>>>>>> 4af5865fa7ee361fdbd7cee1594470c05526f03f
      ),
    );
  }
}

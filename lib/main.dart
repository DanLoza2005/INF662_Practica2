import 'package:flutter/material.dart';
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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
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
      ),
    );
  }
}
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
      ),
    );
  }
}

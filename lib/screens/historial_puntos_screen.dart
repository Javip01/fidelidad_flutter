import 'package:flutter/material.dart';
import 'transaccion_model.dart';
import 'ofertas_screen.dart'; // IMPORTANTE: Aquí importamos tu AnimacionXMLGradient

class HistorialPuntosScreen extends StatefulWidget {
  const HistorialPuntosScreen({super.key});

  @override
  State<HistorialPuntosScreen> createState() => _HistorialPuntosScreenState();
}

class _HistorialPuntosScreenState extends State<HistorialPuntosScreen> {

  final List<Map<String, String>> _locales = [
    {'nombre': 'El Rincón Guay', 'logo': 'lib/assets/elrinconguay.png'},
    {'nombre': 'One Love', 'logo': 'lib/assets/onelove.png'},
    {'nombre': 'Rebel Flame', 'logo': 'lib/assets/rebelflame.png'},
    {'nombre': 'Sauna Lavapiés', 'logo': 'lib/assets/saunalava.png'},
    {'nombre': 'The Ring', 'logo': 'lib/assets/thering.png'},
    {'nombre': 'Sauna Toledo', 'logo': 'lib/assets/saunatoledo.png'},
  ];

  void _simularNuevaCompra() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => _FormularioSimulacion(
        locales: _locales,
        onGuardar: (nuevaTransaccion) {
          // ACTUALIZAMOS LAS VARIABLES GLOBALES
          globalHistorial.value = [nuevaTransaccion, ...globalHistorial.value];
          globalPuntos.value += nuevaTransaccion.puntos;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text("Historial de Puntos", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          // Resumen Superior
          Container(
            padding: const EdgeInsets.all(20),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Puntos Totales", style: TextStyle(color: Colors.grey)),
                    // Escuchamos los puntos en tiempo real
                    ValueListenableBuilder<int>(
                        valueListenable: globalPuntos,
                        builder: (context, puntos, child) {
                          String f = puntos.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.');
                          return Text("💎 $f", style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF8B0000)));
                        }
                    ),
                  ],
                ),
                const Icon(Icons.history_edu, size: 40, color: Colors.grey),
              ],
            ),
          ),
          const Divider(height: 1),
          // Lista de Tickets
          Expanded(
            // Escuchamos el historial en tiempo real
            child: ValueListenableBuilder<List<Transaccion>>(
                valueListenable: globalHistorial,
                builder: (context, historial, child) {
                  if (historial.isEmpty) {
                    return const Center(child: Text("No hay transacciones aún", style: TextStyle(color: Colors.grey)));
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: historial.length,
                    itemBuilder: (context, index) {
                      final t = historial[index];
                      return _CardTicket(transaccion: t);
                    },
                  );
                }
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF8B0000),
        onPressed: _simularNuevaCompra,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

class _CardTicket extends StatelessWidget {
  final Transaccion transaccion;
  const _CardTicket({required this.transaccion});

  void _mostrarTicket(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFFFAFAFA),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        contentPadding: const EdgeInsets.all(24),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(transaccion.logoPath, height: 60, fit: BoxFit.contain),
            const SizedBox(height: 16),
            const Text("---------------------------------", style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 8),
            Text(transaccion.local.toUpperCase(), style: const TextStyle(fontFamily: 'monospace', fontWeight: FontWeight.bold, fontSize: 16)),
            Text(transaccion.fechaFormateada, style: const TextStyle(fontFamily: 'monospace', fontSize: 12, color: Colors.black54)),
            const SizedBox(height: 8),
            const Text("---------------------------------", style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${transaccion.productosCount}x Artículos", style: const TextStyle(fontFamily: 'monospace')),
                Text("${transaccion.gasto.toStringAsFixed(2)} €", style: const TextStyle(fontFamily: 'monospace')),
              ],
            ),
            const SizedBox(height: 16),
            const Text("---------------------------------", style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("TOTAL PAGADO", style: TextStyle(fontFamily: 'monospace', fontWeight: FontWeight.bold)),
                Text("${transaccion.gasto.toStringAsFixed(2)} €", style: const TextStyle(fontFamily: 'monospace', fontWeight: FontWeight.bold, fontSize: 18)),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(8),
              color: Colors.black,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.diamond, color: Colors.white, size: 14),
                  const SizedBox(width: 8),
                  Text("OBTENIDOS: +${transaccion.puntos} PTS", style: const TextStyle(fontFamily: 'monospace', color: Colors.white, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text("Gracias por su visita", style: TextStyle(fontFamily: 'monospace', fontStyle: FontStyle.italic, fontSize: 12)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                // AQUÍ APLICAMOS LA ANIMACIÓN Y EL FONDO AL LOGO
                SizedBox(
                  width: 54,
                  height: 54,
                  child: AnimacionXMLGradient(
                    borderRadius: BorderRadius.circular(14),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset(transaccion.logoPath, fit: BoxFit.contain),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(transaccion.local, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      Text(transaccion.tiempoParaCaducar, style: const TextStyle(color: Colors.orange, fontSize: 12, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                Text("+${transaccion.puntos} pts", style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 16)),
              ],
            ),
            const Divider(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Gasto: ${transaccion.gasto}€", style: const TextStyle(fontWeight: FontWeight.w500)),
                TextButton.icon(
                  onPressed: () => _mostrarTicket(context),
                  icon: const Icon(Icons.receipt_long, size: 18, color: Color(0xFF8B0000)),
                  label: const Text("Ver Ticket", style: TextStyle(color: Color(0xFF8B0000))),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _FormularioSimulacion extends StatefulWidget {
  final List<Map<String, String>> locales;
  final Function(Transaccion) onGuardar;
  const _FormularioSimulacion({required this.locales, required this.onGuardar});

  @override
  State<_FormularioSimulacion> createState() => _FormularioSimulacionState();
}

class _FormularioSimulacionState extends State<_FormularioSimulacion> {
  String? localSeleccionado;
  final TextEditingController _gastoController = TextEditingController();
  final TextEditingController _productosController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, left: 20, right: 20, top: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("Simular Compra", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          DropdownButtonFormField<String>(
            hint: const Text("Selecciona Local"),
            items: widget.locales.map((l) => DropdownMenuItem(value: l['nombre'], child: Text(l['nombre']!))).toList(),
            onChanged: (val) => setState(() => localSeleccionado = val),
          ),
          TextField(controller: _gastoController, decoration: const InputDecoration(labelText: "Dinero gastado (€)"), keyboardType: TextInputType.number),
          TextField(controller: _productosController, decoration: const InputDecoration(labelText: "Cantidad de productos"), keyboardType: TextInputType.number),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF8B0000), minimumSize: const Size(double.infinity, 50)),
            onPressed: () {
              if (localSeleccionado == null) return;
              final logo = widget.locales.firstWhere((l) => l['nombre'] == localSeleccionado)['logo']!;
              final gasto = double.tryParse(_gastoController.text) ?? 0;
              final trans = Transaccion(
                local: localSeleccionado!,
                logoPath: logo,
                gasto: gasto,
                puntos: (gasto * 10).toInt(),
                fecha: DateTime.now(),
                productosCount: int.tryParse(_productosController.text) ?? 1,
              );
              widget.onGuardar(trans);
              Navigator.pop(context);
            },
            child: const Text("Generar Ticket y Puntos", style: TextStyle(color: Colors.white)),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
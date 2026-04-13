import 'package:flutter/material.dart';

class OfertasScreen extends StatefulWidget {
  const OfertasScreen({super.key});
  @override
  State<OfertasScreen> createState() => _OfertasScreenState();
}

class _OfertasScreenState extends State<OfertasScreen> {
  final PageController _pageController = PageController(viewportFraction: 0.9);

  final List<Map<String, dynamic>> _promociones = [
    {'texto': '¡2x1 en Copas!\nTodos los Jueves', 'color': const Color(0xFF8E0000)},
    {'texto': '-50% Entrada\nAntes de las 2:00', 'color': const Color(0xFFFF8F00)},
    {'texto': 'Botella VIP\nReserva anticipada', 'color': const Color(0xFF2A0845)},
  ];

  final List<Map<String, String>> _locales = [
    {'nombre': 'El Rincón Guay', 'logo': 'lib/assets/elrinconguay.png'},
    {'nombre': 'One Love', 'logo': 'lib/assets/onelove.png'},
    {'nombre': 'Rebel Flame', 'logo': 'lib/assets/rebelflame.png'},
    {'nombre': 'Sauna Lavapiés', 'logo': 'lib/assets/saunalava.png'},
    {'nombre': 'The Ring', 'logo': 'lib/assets/thering.png'},
    {'nombre': 'Sauna Toledo', 'logo': 'lib/assets/saunatoledo.png'},
  ];

  // POP-UP RESTAURADO
  void _mostrarDetallePremios(BuildContext context, String local, String logoPath) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Text("Canjear en $local", style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: 4,
            itemBuilder: (context, i) {
              int puntos = (i + 1) * 150;
              return Card(
                color: Colors.white,
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: Colors.grey.shade200)),
                margin: const EdgeInsets.only(bottom: 12),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      Image.asset(logoPath, width: 45, height: 45, fit: BoxFit.contain),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Premio Especial ${i + 1}", style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 14)),
                            const SizedBox(height: 4),
                            Text("Características: Canjeable al momento.", style: TextStyle(fontSize: 11, color: Colors.grey.shade600)),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF8B0000),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          minimumSize: Size.zero,
                        ),
                        onPressed: () {},
                        child: Text("$puntos pts", style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cerrar", style: TextStyle(color: Color(0xFF8B0000), fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              const SizedBox(height: 16),
              const Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Text("Ofertas Destacadas", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black))),
              const SizedBox(height: 12),
              _buildCarrusel(),
              const SizedBox(height: 20),
              _buildNormasCard(),
              const SizedBox(height: 24),
              const Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Text("Gastar Puntos", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black))),
              const SizedBox(height: 12),
              _buildGridLocales(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Hola, Usuario", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/puntos'),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(color: const Color(0xFF1A0000), borderRadius: BorderRadius.circular(20), border: Border.all(color: const Color(0xFFFF0033), width: 2)),
              child: const Row(children: [Text("💎", style: TextStyle(fontSize: 16)), SizedBox(width: 8), Text("1.250 pts", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCarrusel() {
    return SizedBox(
      height: 180,
      child: PageView.builder(
        controller: _pageController,
        itemCount: _promociones.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(color: _promociones[index]['color'], borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFFF0033), width: 2)),
            child: Center(child: Text(_promociones[index]['texto'], textAlign: TextAlign.center, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white))),
          );
        },
      ),
    );
  }

  Widget _buildNormasCard() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      elevation: 2,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: Colors.grey.shade300)),
      child: const ExpansionTile(
        title: Text("Normas de uso y puntos", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        iconColor: Colors.black,
        collapsedIconColor: Colors.black54,
        children: [Padding(padding: EdgeInsets.all(16.0), child: Text("1. Los puntos caducan a los 6 meses.\n2. No son acumulables.\n3. Enseña tu QR antes de pagar.", style: TextStyle(color: Colors.black87, fontSize: 14)))],
      ),
    );
  }

  Widget _buildGridLocales() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 1),
      itemCount: _locales.length,
      itemBuilder: (context, index) {
        return AnimacionXMLGradient( // APLICADA LA ANIMACIÓN EXACTA DE TUS XML
          borderRadius: BorderRadius.circular(16),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => _mostrarDetallePremios(context, _locales[index]['nombre']!, _locales[index]['logo']!),
              borderRadius: BorderRadius.circular(16),
              child: Padding(padding: const EdgeInsets.all(16.0), child: Image.asset(_locales[index]['logo']!, fit: BoxFit.contain)),
            ),
          ),
        );
      },
    );
  }
}

// COMPONENTE DE ANIMACIÓN (FUSIÓN DE TUS 3 XML)
class AnimacionXMLGradient extends StatefulWidget {
  final Widget child;
  final BorderRadius borderRadius;
  const AnimacionXMLGradient({super.key, required this.child, required this.borderRadius});

  @override
  State<AnimacionXMLGradient> createState() => _AnimacionXMLGradientState();
}

class _AnimacionXMLGradientState extends State<AnimacionXMLGradient> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  final LinearGradient grad1 = const LinearGradient(colors: [Color(0xFF0A0A0A), Color(0xFF3E0000)], begin: Alignment.bottomLeft, end: Alignment.topRight); // 45 angle
  final LinearGradient grad2 = const LinearGradient(colors: [Color(0xFF121212), Color(0xFF8C4A00)], begin: Alignment.bottomCenter, end: Alignment.topCenter); // 90 angle
  final LinearGradient grad3 = const LinearGradient(colors: [Color(0xFF000000), Color(0xFF2A0845)], begin: Alignment.bottomRight, end: Alignment.topLeft); // 135 angle

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 12))..repeat(); // 4 seg por cada fase
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        double t = _controller.value * 3;
        LinearGradient currentGradient;

        if (t < 1) {
          currentGradient = LinearGradient.lerp(grad1, grad2, t)!;
        } else if (t < 2) {
          currentGradient = LinearGradient.lerp(grad2, grad3, t - 1)!;
        } else {
          currentGradient = LinearGradient.lerp(grad3, grad1, t - 2)!;
        }

        return Container(
          decoration: BoxDecoration(
            borderRadius: widget.borderRadius,
            gradient: currentGradient,
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 4, offset: const Offset(0, 2))],
          ),
          clipBehavior: Clip.antiAlias,
          child: widget.child,
        );
      },
    );
  }
}
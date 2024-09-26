import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PageNotFoundScreen extends StatelessWidget {
  const PageNotFoundScreen({Key? key, required this.route}) : super(key: key);

  final String route;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Página No Encontrada'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '404',
              style: TextStyle(fontSize: 80, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              route != '' ? 'La ruta "$route" no existe.' : 'La ruta a la que intentas acceder no esta disponible.',
              style: const TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                context.go('/home');
              },
              child: const Text('Ir al Inicio'),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_nectia/core/widgets/custom_button.dart';
import 'package:front_nectia/features/auth/providers/auth_provider.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final usernameController = TextEditingController(text: "Test One");
  final passwordController = TextEditingController(text: "Abc123");

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();

    // Capturar el authNotifier antes del await
    final authNotifier = ref.read(authProvider.notifier);

    // Realizar la operación asíncrona
    await authNotifier.login(username, password);

    // Verificar si el widget sigue montado
    if (!mounted) return;

    // Usar ref de manera segura
    final authState = ref.read(authProvider);

    if (authState.errorMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${authState.errorMessage}')),
      );
    } else if (authState.user != null) {
      // Navegar a la pantalla principal
      context.go('/vehicles');
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(width: 3, color: Colors.indigo),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(40),
          child: IntrinsicWidth(
            child: IntrinsicHeight(
              child: Column(
                children: [
                  Text('Iniciar Sesion',
                      style: textTheme.headlineLarge?.copyWith(
                        color: Colors.indigo,
                      )),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: usernameController,
                      decoration: const InputDecoration(labelText: 'Usuario'),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: passwordController,
                      decoration:
                          const InputDecoration(labelText: 'Contraseña'),
                      obscureText: true,
                    ),
                  ),
                  const SizedBox(height: 20),
                  authState.isLoading
                      ? const CircularProgressIndicator()
                      : CustomButton(text: 'Ingresar', onPressed: _login)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

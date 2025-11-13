import 'package:flutter/material.dart';
import 'package:myapp/barra.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:myapp/google_auth_service.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final authService = GoogleAuthService();

  Future<void> loginGoogle(BuildContext context) async {
    try {
      print("Iniciando sesión con Google...");
      await signInWithGoogle();

      if (!context.mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const BarraNavegacion()),
      );
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al iniciar sesión: ${e.toString()}'),
        ),
      );
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    print("Mostrando selector de cuentas de Google...");

    // 🔹 Inicializa la instancia correctamente
    final GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: ['email', 'profile'],
    );

    // 🔹 Inicia sesión con la cuenta de Google
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    if (googleUser == null) {
      throw Exception("Inicio de sesión cancelado por el usuario.");
    }

    // 🔹 Obtiene el token de autenticación
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // 🔹 Crea las credenciales de Firebase
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // 🔹 Inicia sesión en Firebase con las credenciales de Google
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFFBE9E7),
                    Color(0xFFE1BEE7),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Center(
                child: Image.asset('assets/images/logo.png', height: 150),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFCE93D8),
                    Color(0xFF8E44AD),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BarraNavegacion()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset('assets/images/flecha.png', height: 24),
                      const SizedBox(width: 10),
                      const Text(
                        'Click para ver más',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

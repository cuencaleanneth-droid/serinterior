import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:myapp/barra.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  loginGoogle(context) async {
    try {
      print("Vamos a llamar el login con google");
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
    // Trigger the authentication flow
    print("Vamos a llamar la instancia");
    final GoogleSignInAccount googleUser =
        await GoogleSignIn.instance.authenticate();
    print("llamamos la instancia");
    print(googleUser);

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = googleUser.authentication;
    print("llamamos la autenticacion");
    print(googleAuth);

    // Create a new credential
    final credential =
        GoogleAuthProvider.credential(idToken: googleAuth.idToken);
    print("llamamos la credencial");
    print(credential);

    // Once signed in, return the UserCredential
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
                  onPressed: () => loginGoogle(context),
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
                      Image.asset('assets/images/google.png', height: 24),
                      const SizedBox(width: 10),
                      const Text(
                        'Google',
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

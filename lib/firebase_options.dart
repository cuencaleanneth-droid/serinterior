import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

// INSTRUCCIONES:
// Reemplaza los valores de ejemplo de abajo con tus propias claves de Firebase.
// Puedes obtener estas claves desde la configuración de tu proyecto en la consola de Firebase.

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDXxnFR-nnLVtQJ1OmVAb0rdAIU96n2VAU',
    appId: '1:576814429965:web:567cb710856dc4b1572244',
    messagingSenderId: '576814429965',
    projectId: 'aplicacionapp-947b6',
    authDomain: 'aplicacionapp-947b6.firebaseapp.com',
    storageBucket: 'aplicacionapp-947b6.firebasestorage.app',
    measurementId: 'G-6T202CGSE6',
  );

  // Pega aquí tu configuración para WEB

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDDllUcH-Kg_V4FJpDOnGjH4WfEtB2Gcsg',
    appId: '1:576814429965:android:129398e84a48bd3d572244',
    messagingSenderId: '576814429965',
    projectId: 'aplicacionapp-947b6',
    storageBucket: 'aplicacionapp-947b6.firebasestorage.app',
  );

  // Pega aquí tu configuración para ANDROID

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA9Rz-cCIwX72bVpzcX2ahfnE5V_0IeWGs',
    appId: '1:576814429965:ios:2a4776edd4f631e4572244',
    messagingSenderId: '576814429965',
    projectId: 'aplicacionapp-947b6',
    storageBucket: 'aplicacionapp-947b6.firebasestorage.app',
    iosBundleId: 'com.example.myapp',
  );

  // Pega aquí tu configuración para IOS

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA9Rz-cCIwX72bVpzcX2ahfnE5V_0IeWGs',
    appId: '1:576814429965:ios:2a4776edd4f631e4572244',
    messagingSenderId: '576814429965',
    projectId: 'aplicacionapp-947b6',
    storageBucket: 'aplicacionapp-947b6.firebasestorage.app',
    iosBundleId: 'com.example.myapp',
  );

  // Pega aquí tu configuración para MACOS

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDXxnFR-nnLVtQJ1OmVAb0rdAIU96n2VAU',
    appId: '1:576814429965:web:8663aeff66095ba9572244',
    messagingSenderId: '576814429965',
    projectId: 'aplicacionapp-947b6',
    authDomain: 'aplicacionapp-947b6.firebaseapp.com',
    storageBucket: 'aplicacionapp-947b6.firebasestorage.app',
    measurementId: 'G-41SGNSY3GP',
  );

}
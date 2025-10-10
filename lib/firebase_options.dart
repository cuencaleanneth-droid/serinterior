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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - you can reconfigure this by running the FlutterFire CLI again.',
        );
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

  // Pega aquí tu configuración para WEB
  static const FirebaseOptions web = FirebaseOptions(
    apiKey: "REEMPLAZA_CON_TU_API_KEY_WEB",
    appId: "REEMPLAZA_CON_TU_APP_ID_WEB",
    messagingSenderId: "REEMPLAZA_CON_TU_MESSAGING_SENDER_ID",
    projectId: "REEMPLAZA_CON_TU_PROJECT_ID",
    authDomain: "REEMPLAZA_CON_TU_AUTH_DOMAIN",
    storageBucket: "REEMPLAZA_CON_TU_STORAGE_BUCKET",
  );

  // Pega aquí tu configuración para ANDROID
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: "REEMPLAZA_CON_TU_API_KEY_ANDROID",
    appId: "REEMPLAZA_CON_TU_APP_ID_ANDROID",
    messagingSenderId: "REEMPLAZA_CON_TU_MESSAGING_SENDER_ID",
    projectId: "REEMPLAZA_CON_TU_PROJECT_ID",
    storageBucket: "REEMPLAZA_CON_TU_STORAGE_BUCKET",
  );

  // Pega aquí tu configuración para IOS
  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: "REEMPLAZA_CON_TU_API_KEY_IOS",
    appId: "REEMPLAZA_CON_TU_APP_ID_IOS",
    messagingSenderId: "REEMPLAZA_CON_TU_MESSAGING_SENDER_ID",
    projectId: "REEMPLAZA_CON_TU_PROJECT_ID",
    storageBucket: "REEMPLAZA_CON_TU_STORAGE_BUCKET",
    iosBundleId: "REEMPLAZA_CON_TU_IOS_BUNDLE_ID",
    iosClientId: "REEMPLAZA_CON_TU_IOS_CLIENT_ID",
  );

  // Pega aquí tu configuración para MACOS
  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: "REEMPLAZA_CON_TU_API_KEY_MACOS",
    appId: "REEMPLAZA_CON_TU_APP_ID_MACOS",
    messagingSenderId: "REEMPLAZA_CON_TU_MESSAGING_SENDER_ID",
    projectId: "REEMPLAZA_CON_TU_PROJECT_ID",
    storageBucket: "REEMPLAZA_CON_TU_STORAGE_BUCKET",
    iosBundleId: "REEMPLAZA_CON_TU_MACOS_BUNDLE_ID",
    iosClientId: "REEMPLAZA_CON_TU_MACOS_CLIENT_ID",
  );
}

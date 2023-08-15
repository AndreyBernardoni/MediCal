import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyBE92WKlp_bjUEkgxYXiwLzEBZM5gNsQ8o",
            authDomain: "tccflutterflow.firebaseapp.com",
            projectId: "tccflutterflow",
            storageBucket: "tccflutterflow.appspot.com",
            messagingSenderId: "378224660100",
            appId: "1:378224660100:web:3cf1885786c3734759bcd1",
            measurementId: "G-J4WN4WFXYW"));
  } else {
    await Firebase.initializeApp();
  }
}

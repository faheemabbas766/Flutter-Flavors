import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'app.dart';
import 'firebase_options_production.dart';
import 'firebase_options_development.dart';
import 'firebase_options_staging.dart';
import 'flavors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase based on the app flavor
  await initializeFirebase();

  // Log the app flavor to Firebase Realtime Database
  await logAppFlavor(F.appFlavor?.name ?? 'unknown');

  // Start the app
  runApp(const App());
}

/// Initializes Firebase with the appropriate options based on the app flavor.
Future<void> initializeFirebase() async {
  final firebaseOptions = _getFirebaseOptions(F.appFlavor);
  await Firebase.initializeApp(options: firebaseOptions);
}

/// Returns the Firebase options corresponding to the app flavor.
FirebaseOptions _getFirebaseOptions(Flavor? flavor) {
  switch (flavor) {
    case Flavor.production:
      return DefaultFirebaseOptionsProduction.currentPlatform;
    case Flavor.development:
      return DefaultFirebaseOptionsDevelopment.currentPlatform;
    case Flavor.staging:
      return DefaultFirebaseOptionsStaging.currentPlatform;
    default:
      throw Exception('Invalid or undefined app flavor');
  }
}

/// Logs the app flavor to Firebase Realtime Database.
Future<void> logAppFlavor(String flavor) async {
  final database = FirebaseDatabase.instance.ref('faheem');
  try {
    await database.child('flavor_logs').set({
      'level': flavor,
      'timestamp': DateTime.now().toIso8601String(),
    });
  } catch (error) {
    debugPrint('Failed to log flavor: $error');
  }
}

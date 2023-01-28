import '../firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:major_try/data/globals.dart' as globals;
import 'package:flutter/material.dart';

void initialize() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // fetching ngrok web URL and sending skip warning page header initially
  try {
    final response =
        await http.get(Uri.parse('https://api.ngrok.com/endpoints'), headers: {
      'authorization':
          'Bearer 2IM2LndbwcUOxfcotzI4ZDY45ne_3SxMZVDVFGg7kbv26uW3U',
      'ngrok-version': '2'
    }); //fetch URL of ngrok
    final body = json.decode(response.body);
    globals.url = body["endpoints"][0]["public_url"];
    final _ = await http.get(Uri.parse(globals.url), headers: {
      'ngrok-skip-browser-warning': '1234'
    }); // // Send authorization headers to the backend and skip warning.
  } catch (e) {
    print("Exception occured while trying to initialize API: " + e.toString());
  }
}

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:major_try/data/globals.dart' as globals;
import 'package:flutter/material.dart';
import 'package:major_try/data/api.dart' as api;

void initialize() async {
  WidgetsFlutterBinding.ensureInitialized();

  // fetching ngrok web URL and sending skip warning page header initially
  try {
    final response = await http
        .get(Uri.parse('https://api.ngrok.com/endpoints'), headers: {
      'authorization': 'Bearer ${api.api_key}',
      'ngrok-version': '2'
    }); //fetch URL of ngrok with api key from api.dart (to be added manually to avoid API key leakage)
    final body = json.decode(response.body);
    globals.url = body["endpoints"][0]["public_url"];
    final _ = await http.get(
      Uri.parse(globals.url),
      headers: {'ngrok-skip-browser-warning': '1234'},
    );
    // Send authorization headers to the backend and skip warning.
  } catch (e) {
    // ignore: avoid_print
    print("Exception occured while trying to initialize API: $e");
  }
}

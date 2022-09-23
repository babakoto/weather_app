import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class EnvironmentService {
  static String? apiKey;
  static String? host;

  static Future<void> config() async {
    await dotenv.load(fileName: ".env");
    var env = dotenv.env;
    apiKey = env["API_KEY"];
    host = env["HOST"];
  }

  static show() {
    if (kDebugMode) {
      print("""
     -----------------
     ENVIRONMENTS DEBUG
    -------------------- 
    API => $apiKey
    HOST => $host
   ----------------------------- 
    """);
    }
  }
}

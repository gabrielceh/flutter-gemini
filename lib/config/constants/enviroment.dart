import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static Future<void> initEnvironment() async {
    await dotenv.load(fileName: ".env");
  }

  static String endpointApi = dotenv.env['ENDPOINT_API'] ?? 'NO API_URL';
}

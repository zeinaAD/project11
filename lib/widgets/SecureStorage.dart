import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:project1/ipaddress.dart';
import 'package:http/http.dart' as http;

class SecureStorage {
  static final _storage = FlutterSecureStorage();

  static Future<void> setUserEmail(String email) async {
    await _storage.write(key: 'userEmail', value: email);
  }

  static Future<String?> getUserEmail() async {
    return await _storage.read(key: 'userEmail');
  }

  Future<String?> getUserName(String email) async {
    try {
      // Replace with your server's IP and correct port
      // var url = Uri.parse('http://$ipAddress:5000/getName?email=$email');
      final ipAddress = await getLocalIPv4Address();
      final response =
          await http.get(Uri.parse('http://$ipAddress:5000/getName/$email'));

      // var response = await http.get(url);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data[
            'name']; // Assuming the server returns { "name": "User Name" }
      } else if (response.statusCode == 404) {
        print('User not found');
        return null; // Handle user not found
      } else {
        print('Error: ${response.statusCode}');
        return null; // Handle other types of errors
      }
    } catch (e) {
      print('Error connecting to the server: $e');
      return null; // Handle errors related to the connection
    }
  }
}

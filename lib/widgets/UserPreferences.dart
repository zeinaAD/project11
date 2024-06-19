import 'dart:convert';
import 'package:project1/ipaddress.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class UserPreferences {
  static late SharedPreferences _preferences;

  //bool paymentMethod = false;

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future setEmail(String email) async {
    await _preferences.setString('email', email);
  }

  static String? getEmail() {
    return _preferences.getString('email');
  }

  static Future setWidthandheight(double height, double width) async {
    await _preferences.setDouble('height', height);
    await _preferences.setDouble('width', width);
  }

  // Method to retrieve height
  static double? getHeight() {
    return _preferences.getDouble('height');
  }

  // Method to retrieve width
  static double? getWidth() {
    return _preferences.getDouble('width');
  }

  static Future removeEmail() async {
    await _preferences.remove('email');
  }

  static Future setUserName(String username) async {
    await _preferences.setString('username', username);
  }

  static String? getUserName() {
    return _preferences.getString('username');
  }

   static Future setimageUrl(String imageUrl) async {
    await _preferences.setString('imageUrl', imageUrl);
  }

  static String? getimageUrl() {
    return _preferences.getString('imageUrl');
  }

  static Future removeUserName() async {
    await _preferences.remove('username');
  }

  static Future setUserID(String id) async {
    await _preferences.setString('_id', id);
  }

  static String? getUserID() {
    return _preferences.getString('id');
  }

    static Future setUserPN(String phoneNumber) async {
    await _preferences.setString('phoneNumber', phoneNumber);
  }

  static String? getUserPN() {
    return _preferences.getString('phoneNumber');
  }

  // Method to fetch the username from the server based on the stored email
  static Future getName(String email) async {
    //String? email = getEmail();
    final ipAddress = await getLocalIPv4Address();
    if (email != null) {
      try {
        final response =
            await http.get(Uri.parse('http://$ipAddress:5000/getName/$email'));

        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          String? username = data['username'];
          if (username != null) {
            setUserName(username); // Save the fetched name in SharedPreferences
            return username;
          }
        } else {
          throw Exception('Failed to fetch username from the server');
        }
      } catch (e) {
        print('Error fetching username: $e');
      }
    } else {
      print('Email is not set');
    }
  }

  static Future getID(String email) async {
    //String? email = getEmail();
    final ipAddress = await getLocalIPv4Address();
    if (email != null) {
      try {
        final response =
            await http.get(Uri.parse('http://$ipAddress:5000/getID/$email'));

        if (response.statusCode == 200 || response.statusCode == 201) {
          var data = jsonDecode(response.body);
          String? id = data['_id'];
          if (id != null) {
            setUserID(id); // Save the fetched name in SharedPreferences
            return id;
          }
        } else {
          throw Exception('Failed to fetch id from the server');
        }
      } catch (e) {
        print('Error fetching id: $e');
      }
    } else {
      print('Email is not set');
    }
  }

    static Future getPN(String email) async {
    //String? email = getEmail();
    final ipAddress = await getLocalIPv4Address();
    if (email != null) {
      try {
        final response =
            await http.get(Uri.parse('http://$ipAddress:5000/getPhoneNumber/$email'));

        if (response.statusCode == 200 || response.statusCode == 201) {
          var data = jsonDecode(response.body);
          int? phoneNumber = data['phoneNumber'];
          if (phoneNumber != null) {
            setUserPN(phoneNumber.toString()); // Save the fetched name in SharedPreferences
            return phoneNumber;
          }
        } else {
          throw Exception('Failed to fetch id from the server');
        }
      } catch (e) {
        print('Error fetching id: $e');
      }
    } else {
      print('Email is not set');
    }
  }
}

//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:project1/screens/design_ring.dart';
import 'package:project1/widgets/rounded-button1.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project1/ipaddress.dart';

class design {
  //final String title;
  final String image;
  final String price;
  final String rname;

  // RoundedButton1 roundedButton1;

  design({
    // required this.title,
    required this.image,
    required this.price,
    required this.rname,
    //   required this.menuArr,
    // required this.roundedButton1,
  });

  factory design.fromJson(Map<String, dynamic> json) {
    return design(
      image: json['image'],
      price: json['price'],
      rname: json['rname'],
      //  menuArr:
    );
  }

  static Future<Set<design>> DYRfetching(String name) async {
    final ipAddress =
        await getLocalIPv4Address(); // This function should return the IP address.
    final url = 'http://$ipAddress:5000/fetchDYR/$name';
    print('Requesting: $url'); // Debug: log the URL being requested

    try {
      final response = await http.get(Uri.parse(url));
      print(
          'Status code: ${response.statusCode}'); // Debug: log the status code
      print(
          'Response Body: ${response.body}'); // Debug: log the full response body

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);

        // Ensure the jsonResponse is a Map and contains both 'image' and 'price' keys.
        if (jsonResponse.containsKey('image') &&
            jsonResponse.containsKey('price')) {
          return {
            design.fromJson(jsonResponse)
            /*  design(
              image: jsonResponse['image'],
              price: jsonResponse['price'],
              rname: jsonResponse['rname'],
              //  menuArr:
            ) */
          };
        } else {
          print('Error: Necessary keys not found in the response.');
          throw Exception(
              'Necessary keys ("image" and/or "price") not found in the JSON response.');
        }
      } else {
        throw Exception(
            'Failed to load data, Status code: ${response.statusCode}');
      }
    } on FormatException catch (e) {
      print('Error parsing JSON: $e');
      throw Exception('Error parsing JSON: $e');
    } catch (e) {
      print('An error occurred: $e');
      throw Exception('An error occurred: $e');
    }
  }
}

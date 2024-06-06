import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:project1/ipaddress.dart';

class Product {
  final String title;
  final String image;
  final String price;
  final String rate;

  Product({
    required this.title, // name
    required this.image,
    required this.price,
    required this.rate, //description
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      title: json['name'],
      image: json['image'],
      price: json['price'].toString(),
      rate: json['description'],
    );
  }

  static Future<List<Product>> fetchGProducts(String category) async {
    final ipAddress = await getLocalIPv4Address();
    // Update your API endpoint URL to include the category as a query parameter
    final response = await http
        .get(Uri.parse('http://$ipAddress:5000/fetchGItems/$category'));

    if (response.statusCode == 200) {
      List<Product> products = (json.decode(response.body) as List)
          .map((data) => Product.fromJson(data))
          .toList();
      print(
          'products loaded successfully, Status code: ${response.statusCode}');
      return products;
    } else {
      print('Failed to load products, Status code: ${response.statusCode}');
      throw Exception(
          'Failed to load products, Status code: ${response.statusCode}');
    }
  }
}

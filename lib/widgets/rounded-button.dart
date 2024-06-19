import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project1/ipaddress.dart';
import 'package:project1/screens/admin_page.dart';
import 'package:project1/screens/home_page.dart';
import 'package:project1/screens/login1.dart';
import 'package:project1/screens/ring_on_hand.dart';
import 'package:project1/utilities/constants.dart';
import 'package:http/http.dart' as http;
import 'package:project1/widgets/SecureStorage.dart';
import 'package:project1/widgets/UserPreferences.dart';

class RoundedButton extends StatefulWidget {
  const RoundedButton({
    super.key,
    required this.buttonName,
    required this.usernameController,
    required this.emailController,
    required this.passwordController,
    required this.phoneNumberController,
  });

  final String buttonName;
  final TextEditingController usernameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController phoneNumberController;

  @override
  State<RoundedButton> createState() => _RoundedButtonState();
}

class _RoundedButtonState extends State<RoundedButton> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  void _incorrectpassword() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Color(0xFFDFDED9),
            title: Text("Wrong Password!"),
            content: Text("Please Try Again"),
            actions: [
              MaterialButton(
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                },
                child: Text("Ok"),
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                },
                child: Text("Cancel"),
              ),
            ],
          );
        });
  }

  void _usernotfound() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Color(0xFFDFDED9),
            title: Text("User Not Found!"),
            content: Text("Please create an account"),
            actions: [
              MaterialButton(
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                },
                child: Text("Ok"),
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                },
                child: Text("Cancel"),
              ),
            ],
          );
        });
  }

  void _errorinregister() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Color(0xFFDFDED9),
            title: Text("Error!"),
            content: Text("Please Try Again"),
            actions: [
              MaterialButton(
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                },
                child: Text("Ok"),
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                },
                child: Text("Cancel"),
              ),
            ],
          );
        });
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    // Regular Expression for email validation
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

    String? _validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    }
    // Regular Expression for email validation
    if (!RegExp(r'^\+?[\d\s]{10,15}$').hasMatch(value)) {
    return 'Please enter a valid phone number';
  }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    // Password must be at least 8 characters
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    // Password must contain at least one special character
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return 'Password must contain at least one special character';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    String? password = widget.passwordController.text;

    if (password == null || value == null || password != value) {
      return 'Passwords do not match';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.08,
      width: size.width * 0.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ElevatedButton(
        onPressed: () async {
          final email = widget.emailController.text;
          final password = widget.passwordController.text;
          final username = widget.usernameController.text;
          final phoneNumber = widget.phoneNumberController.text;

          if (widget.buttonName == "Register") {
            // _validateEmail(email);
            // _validatePassword(password);
            // _validateConfirmPassword(password);
            await signUp(
                email: email,
                password: password,
                username: username,
                phoneNumber: phoneNumber);
            /* Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => loginpagee()),
            ); */
          } else if (widget.buttonName == "Login") {
            // Navigator.of(context).push(
            //   MaterialPageRoute(builder: (context) => RingOnHand()),
            // );
            await logIn(
              email: email,
              password: password,
              context: context,
            );
            /*  Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MainScreen()),
            ); */
          } else if (widget.buttonName == "Send") {}
        },
        child: Text(
          widget.buttonName,
          style: TextStyle(
            color: Color(0xA5FFFFFF),
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ), //kBodyText.copyWith(fontWeight: FontWeight.bold),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: kourcolor1,
        ),
      ),
    );
  }

  Future<void> signUp({
    required String username,
    required String email,
    required String password,
    required String phoneNumber,
  }) async {
    final ipAddress = await getLocalIPv4Address();
    final url = Uri.parse('http://$ipAddress:5000/signup');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'username': username,
          'email': email,
          'password': password,
          'phoneNumber': phoneNumber,
        },
      );

      if (response.statusCode == 200) {
        // Data sent successfully
        print('Signup successful');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => loginpagee()),
        );
      } else {
        _errorinregister();

        print('HTTP error: ${response.statusCode}');
      }
    } catch (error) {
      // Handle network or other errors
      print('Error: $error');
    }
  }

  Future<void> logIn({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    // final userData = Provider.of<UserData>(context, listen: false);
    // userData.setRegisterID(email);
    print("email");
    print(email);

    print("password");
    print(password);

    final ipAddress = await getLocalIPv4Address();
    print("*ipAddress:" + ipAddress);
    final url = Uri.parse('http://$ipAddress:5000/login');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        /////////////////////
        UserPreferences.setEmail(email);
        UserPreferences.getName(email);
        UserPreferences.getID(email);
        UserPreferences.getPN(email);
        ////////////////////

        if (email == "zeina.fawziad@gmail.com" && password == "1234" ||
            email == "rand.nabil.2019@gmail.com" && password == "12345678") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AdminPage()),
          );

          print("admin");
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MainScreen()),
          );
          print("normal user");
        }
        print('Login successful');
        /* Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MainScreen()),
        ); */
      } else if (response.statusCode == 401) {
        // Incorrect password
        print('Incorrect password');
        _incorrectpassword();
      } else if (response.statusCode == 404) {
        // User not found
        print('User not found');
        _usernotfound();
        /* setState(() {
          var errorMessage =
              'This account doesn\'t exist. Please Sign up first.';
        }); */
      } else {
        print('HTTP error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }
}

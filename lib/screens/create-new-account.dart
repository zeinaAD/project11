import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project1/ipaddress.dart';
import 'package:project1/utilities/constants.dart';
import 'package:project1/widgets/background-image.dart';
import 'package:project1/widgets/confirm-password.dart';
import 'package:project1/widgets/password-input.dart';
import 'package:project1/widgets/rounded-button.dart';
import 'package:project1/widgets/text-field-input.dart';

class CreateNewAccount extends StatefulWidget {
  const CreateNewAccount({super.key});

  @override
  State<CreateNewAccount> createState() => _CreateNewAccountState();
}

class _CreateNewAccountState extends State<CreateNewAccount> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmpasswordController =
      TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        BackgroundImage(image: 'images/IRIS3.jpeg'),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: size.width * 0.1,
                ),
                SizedBox(
                  height: size.width * 0.6,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextInputField(
                        icon: Icons.account_circle,
                        hint: 'User',
                        inputType: TextInputType.name,
                        inputAction: TextInputAction.next,
                        controller: usernameController,
                      ),
                      TextInputField(
                        icon: Icons.email,
                        hint: 'Email',
                        inputType: TextInputType.emailAddress,
                        inputAction: TextInputAction.next,
                        controller: emailController,
                      ),
                      PasswordInput(
                        icon: Icons.lock,
                        hint: 'Password',
                        inputType: TextInputType.name,
                        inputAction: TextInputAction.next,
                        controller: passwordController,
                      ),
                      ConfirmPassword(
                        icon: Icons.lock,
                        hint: 'Confirm Password',
                        inputType: TextInputType.name,
                        inputAction: TextInputAction.done,
                        controller: confirmpasswordController,
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      RoundedButton(
                        buttonName: 'Register',
                        emailController: emailController,
                        passwordController: passwordController,
                        usernameController: usernameController,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account?',
                            style: TextStyle(
                              color: Color(0xA5FFFFFF),
                              fontSize: 22,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/');
                            },
                            child: Text(
                              ' Login',
                              /* style: kBodyText.copyWith(
                                  color: kBlue, fontWeight: FontWeight.bold), */
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.white,
                                fontWeight: FontWeight.bold,
                                //  color: Color.fromARGB(180, 192, 187, 187),
                                color: Color(0xA5FFFFFF),
                                fontSize: 22,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

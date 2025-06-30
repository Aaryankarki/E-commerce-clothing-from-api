import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:ecommerce/constant/api.dart';
import 'package:ecommerce/screen/products/product_screen.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController userName = TextEditingController();
  final TextEditingController password = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  void onLogin() async {
    final dio = Dio();
    if (_formkey.currentState?.validate() == true) {
      try {
        final response = await dio.post(
          "$base_api/auth/login",

          data: {"username": userName.text, "password": password.text},
        );
        Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (context) => HomePage()));
        log("Login successful: ${response.data}");
      } catch (e) {
        log("Login failed: ${e.toString()}");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 100, 10, 20),
          child: Form(
            key: _formkey,

            child: Column(
              children: [
                TextFormField(
                  controller: userName,
                  decoration: InputDecoration(
                    labelText: "UserName",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "please enter your LoginId";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 30),
                TextFormField(
                  controller: password,
                  decoration: InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "please Password";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 30),
                FilledButton(onPressed: onLogin, child: Text("Login")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

mixin ValidatorMixin {
  String? notEmpty(String fieldName, String? value) {
    if (value == null || value == '') {
      return "$fieldName is required.";
    }
    return null;
  }
}

class _LoginState extends State<Login> with ValidatorMixin {
  final formGlobalKey = GlobalKey<FormState>();

  String username = '';
  String password = '';
  String givenName = '';
  String familyName = '';

  Future<Response> createUser() async {
    final prefs = await SharedPreferences.getInstance();
    final serverUrl = prefs.getString("serverUrl");

    return post(Uri.parse("$serverUrl/user"),
        body: jsonEncode(<String, String>{
          'username': username,
          'firstName': givenName,
          'lastName': familyName
        }));
  }

  Future<Response> login() async {
    final prefs = await SharedPreferences.getInstance();
    final serverUrl = prefs.getString("serverUrl");

    return post(Uri.parse("$serverUrl/login"),
        body: jsonEncode(<String, String>{
          'username': username,
          'password': password,
        }));
  }

  bool isSigningUp = false;

  @override
  Widget build(BuildContext ctx) {
    final ourWidth = MediaQuery.of(ctx).size.width;
    final ourHeight = MediaQuery.of(ctx).size.height;

    final horizontalTextInset = .02 * ourWidth;
    final sizedBoxHeight = .015 * ourHeight;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: Text("Login Page")),
        body: SingleChildScrollView(
            child: Center(
                child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 50),
                    child: Form(
                        key: formGlobalKey,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: horizontalTextInset),
                              child: TextFormField(
                                validator: (value) =>
                                    notEmpty('Username', value),
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Username',
                                    hintText: 'Enter a valid username'),
                                onChanged: (value) => setState(() {
                                  username = value;
                                }),
                              ),
                            ),
                            SizedBox(height: sizedBoxHeight),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: horizontalTextInset),
                              child: TextFormField(
                                obscureText: true,
                                validator: (value) =>
                                    notEmpty('Password', value),
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Password',
                                    hintText: 'Enter a valid password'),
                                onChanged: (value) => setState(() {
                                  password = value;
                                }),
                              ),
                            ),
                            SizedBox(height: sizedBoxHeight),
                            // FIXME: Is there a better way to do conditional rendering?
                            isSigningUp
                                ? Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: .02 * ourWidth),
                                    child: TextFormField(
                                      validator: (value) =>
                                          notEmpty('First name', value),
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'First Name',
                                          hintText: 'Enter your first name'),
                                      onChanged: (value) => setState(() {
                                        givenName = value;
                                      }),
                                    ),
                                  )
                                : Container(),
                            isSigningUp
                                ? SizedBox(height: sizedBoxHeight)
                                : Container(),
                            isSigningUp
                                ? Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: horizontalTextInset),
                                    child: TextFormField(
                                      validator: (value) =>
                                          notEmpty('Last name', value),
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Last Name',
                                          hintText: 'Enter your last name'),
                                      onChanged: (value) => setState(() {
                                        familyName = value;
                                      }),
                                    ),
                                  )
                                : Container(),
                            isSigningUp
                                ? SizedBox(height: sizedBoxHeight)
                                : Container(),
                            ElevatedButton(
                                onPressed: () {
                                  formGlobalKey.currentState?.validate();
                                },
                                child: Text(isSigningUp ? 'Sign Up' : 'Login')),
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: horizontalTextInset),
                                  child: Text("Switch to sign-up mode?"),
                                ),
                                Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Switch(
                                      onChanged: (value) => setState(() {
                                        isSigningUp = value;
                                      }),
                                      value: isSigningUp,
                                    ))
                              ],
                            )
                          ],
                        ))))));
  }
}

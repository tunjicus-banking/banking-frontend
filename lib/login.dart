import 'package:flutter/material.dart';

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

  bool isSigningUp = true;

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: Text("Login Page")),
        body: Center(
            child: Padding(
                padding: EdgeInsets.symmetric(vertical: 50),
                child: Form(
                    key: formGlobalKey,
                    child: Column(
                      children: [
                        Padding(
                          // TODO: Replace this horizontal w/ a percentage by using
                          // MediaQuery.of(context).size.width
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: TextFormField(
                            validator: (value) => notEmpty('Username', value),
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Username',
                                hintText: 'Enter a valid username'),
                            onChanged: (value) => setState(() {
                              username = value;
                            }),
                          ),
                        ),
                        // TODO: Should probably also replace with percentage of height
                        SizedBox(height: 20),
                        Padding(
                          // TODO: Replace this horizontal w/ a percentage by using
                          // MediaQuery.of(context).size.width
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: TextFormField(
                            obscureText: true,
                            validator: (value) => notEmpty('Password', value),
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Password',
                                hintText: 'Enter a valid password'),
                            onChanged: (value) => setState(() {
                              password = value;
                            }),
                          ),
                        ),
                        SizedBox(height: 20),
                        // FIXME: Is there a better way to do conditional rendering?
                        isSigningUp
                            ? Padding(
                                // TODO: Replace this horizontal w/ a percentage by using
                                // MediaQuery.of(context).size.width
                                padding: EdgeInsets.symmetric(horizontal: 15),
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
                        isSigningUp ? SizedBox(height: 20) : Container(),
                        isSigningUp
                            ? Padding(
                                // TODO: Replace this horizontal w/ a percentage by using
                                // MediaQuery.of(context).size.width
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: TextFormField(
                                  validator: (value) =>
                                      notEmpty('Last name', value),
                                  initialValue: familyName,
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
                        isSigningUp ? SizedBox(height: 20) : Container(),
                        ElevatedButton(
                            onPressed: () {
                              formGlobalKey.currentState?.validate();
                            },
                            child: Text(isSigningUp ? 'Sign Up' : 'Login')),
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
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
                    )))));
  }
}

/*
 * Copyright 2018 Leszek Nowaczyk. All rights reserved.
 * If you get hold of this code you probably found it on github ;)
 */
import 'package:flutter/material.dart';
import 'package:ic_fantasy_football/controller/internet_async.dart';


class RegisterView extends StatefulWidget {
  @override
  _RegisterViewState createState() => new _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {

  String _username, _email, _password;
  bool _buttonEnabled = true;

  TextEditingController controller = TextEditingController();
  TextEditingController controller2 = TextEditingController();

  String _validateEmail(String value) {
    final RegExp emailRegEx= RegExp("^([0-9a-zA-Z]([-.+\\w]*[0-9a-zA-Z])*@([0-9a-zA-Z][-\\w]*[0-9a-zA-Z]\\.)+[a-zA-Z]{2,9})\$");
    if (!emailRegEx.hasMatch(value)) {
      return 'The E-mail Address must be a valid.';
    }

    return null;
  }
  final _formKey = GlobalKey<FormState>();


  Widget _register = Text("Register");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("IC Fantasy Football"),),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Builder(builder: (context) => Container(
            padding: const EdgeInsets.all(40.0),
            child: new Form(
              key: _formKey,
              autovalidate: true,
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  new Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                  ),
                  Image.asset("assets/logo.png", height: 100.0, alignment: Alignment.center,),
                  new TextFormField(
                      decoration: new InputDecoration(
                          hintText: "Username", fillColor: Colors.white
                      ),
                      keyboardType: TextInputType.emailAddress,
                      onSaved: (string) => _username = string,
                      validator: (value) {
                        if (value.length < 4) {
                          return 'Enter a username that is at least 4 characters long';
                        } else if (value.length > 29) {
                          return 'Enter a username that is at least 4 characters long';
                        }
                      }
                  ),
                  new TextFormField(
                    controller: controller2,
                    decoration: new InputDecoration(
                        hintText: "Email", fillColor: Colors.white),
                    keyboardType: TextInputType.text,
                    onSaved: (string) => _email = string,
                    validator: _validateEmail,
                  ),
                  new TextFormField(
                    decoration: new InputDecoration(
                        hintText: "Repeat Email", fillColor: Colors.white),
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      final RegExp emailRegEx= RegExp("^([0-9a-zA-Z]([-.+\\w]*[0-9a-zA-Z])*@([0-9a-zA-Z][-\\w]*[0-9a-zA-Z]\\.)+[a-zA-Z]{2,9})\$");
                      if (!emailRegEx.hasMatch(value)) {
                        return 'The E-mail Address must be a valid';
                      } else if (value != controller2.text) {
                        return 'Emails do not match';
                      }
                    },
                  ),
                  new TextFormField(
                      decoration: new InputDecoration(
                          hintText: "Password", fillColor: Colors.white),
                      obscureText: true,
                      controller: controller,
                      keyboardType: TextInputType.text,
                      onSaved: (string) => _password = string,
                      validator: (value) {
                        if (value.length < 6) {
                          return 'Enter a password that is at least 6 characters long';
                        } else if (value.length > 29) {
                          return 'Enter a password that is at most 29 characters long';
                        }
                      }
                  ),
                  new TextFormField(
                      decoration: new InputDecoration(
                          hintText: "Repeat Password", fillColor: Colors.white),
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value.length < 6) {
                          return 'Enter a password that is at least 6 characters long';
                        } else if (value.length > 29) {
                          return 'Enter a password that is at most 29 characters long';
                        } else if (value != controller.text) {
                          return 'Passwords do not match';
                        }
                      }
                  ),
                  new Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                  ),
                  new MaterialButton(
                    height: 50.0,
                    minWidth: 200.0,
                    color: Colors.blueAccent,
                    splashColor: Colors.teal,
                    textColor: Colors.white,
                    child: _register ,
                    onPressed: () {
                      // Validate will return true if the form is valid, or false if
                      // the form is invalid.
                      if (_formKey.currentState.validate() && _buttonEnabled) {
                        _formKey.currentState.save();
                        setState(() {
                          _register = FutureBuilder(
                            future: InternetAsync().addUser(context, _username, _email.toLowerCase(), _password),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.done) {
                                _buttonEnabled = true;
                                return Text("Register");
                              }
                              // By default, show a loading spinner and disable button
                              _buttonEnabled = false;
                              return CircularProgressIndicator();
                            },
                          );
                        });
                      }
                    }
                  )
                ],
              ),
            ),
          ),
        )
      )
      )
    );
  }
}

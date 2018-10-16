/*
 * Copyright 2018 Leszek Nowaczyk. All rights reserved.
 * If you get hold of this code you probably found it on github ;)
 */
import 'package:flutter/material.dart';
import 'package:ic_fantasy_football/controller/internet_async.dart';


class ResetPasswordView extends StatefulWidget {

  final String email;

  ResetPasswordView({
    Key key,
    @required this.email
  })  : super(key: key);

  @override
  _ResetPasswordViewState createState() => new _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {

  String _password;
  bool _buttonEnabled = true;

  TextEditingController controller = TextEditingController();

  final _formKey = GlobalKey<FormState>();


  Widget _register = Text("Change Password");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Reset password for " + widget.email),),
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
                                    future: InternetAsync().resetPassword(context, widget.email, _password),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState == ConnectionState.done) {
                                        _buttonEnabled = true;
                                        return Text("Change password");
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

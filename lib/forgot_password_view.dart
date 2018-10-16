/*
 * Copyright 2018 Leszek Nowaczyk. All rights reserved.
 * If you get hold of this code you probably found it on github ;)
 */

import 'package:flutter/material.dart';
import 'package:ic_fantasy_football/controller/internet_async.dart';


class ForgotPasswordView extends StatefulWidget {
  @override
  _ForgotPasswordViewState createState() => new _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {

  String _email, _resetCode;
  bool _buttonEnabled = true;

  String _validateEmail(String value) {
    final RegExp emailRegEx= RegExp("^([0-9a-zA-Z]([-.+\\w]*[0-9a-zA-Z])*@([0-9a-zA-Z][-\\w]*[0-9a-zA-Z]\\.)+[a-zA-Z]{2,9})\$");
    if (!emailRegEx.hasMatch(value)) {
      return 'The E-mail Address must be a valid.';
    }

    return null;
  }
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();


  Widget _register = Text("Email me a reset code");
  Widget _reset = Text("Check reset code");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("IC Fantasy Football"),),
        body: Scrollbar(
            child: SingleChildScrollView(
                child: Builder(builder: (context) => Container(
                  padding: const EdgeInsets.all(40.0),
                  child: Column(
                    children: <Widget>[
                      Form(
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
                                  hintText: "Email", fillColor: Colors.white),
                              keyboardType: TextInputType.text,
                              onSaved: (string) => _email = string,
                              validator: _validateEmail,
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
                                        future: InternetAsync().sendEmailResetPassword(context, _email),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState == ConnectionState.done) {
                                            _buttonEnabled = true;
                                            return Text("Email me a reset code");
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
                      Form(
                        key: _formKey2,
                        child: new Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            new Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                            ),
                            new TextFormField(
                              decoration: new InputDecoration(
                                  hintText: "Reset Code", fillColor: Colors.white),
                              keyboardType: TextInputType.text,
                              onSaved: (string) => _resetCode = string,
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
                                child: _reset,
                                onPressed: () {
                                  // Validate will return true if the form is valid, or false if
                                  // the form is invalid.
                                  if (_formKey.currentState.validate() &&_buttonEnabled) {

                                    _formKey.currentState.save();
                                    _formKey2.currentState.save();
                                    setState(() {
                                      _reset = FutureBuilder(
                                        future: InternetAsync().checkPasswordResetCode(context, _email, _resetCode),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState == ConnectionState.done) {
                                            _buttonEnabled = true;
                                            return Text("Check reset code");
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
                    ],
                  )
                ),
                )
            )
        )
    );
  }
}

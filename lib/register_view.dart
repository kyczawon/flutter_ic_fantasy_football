/*
 * Copyright 2018 Leszek Nowaczyk. All rights reserved.
 * If you get hold of this code you probably found it on github ;)
 */
import 'package:flutter/material.dart';
import 'package:validate/validate.dart';


class RegisterView extends StatefulWidget {
  @override
  _RegisterViewState createState() => new _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {

//  String _validateEmail(String value) {
//    if (!Validate.isEmail(value)) {
//      return 'The E-mail Address must be a valid email address.';
//    }
//
//    return null;
//  }

  String _validatePassword(String value) {
    if (value.length < 8) {
      return 'The Password must be at least 8 characters.';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("IC Fantasy Football"),),
      body: Container(
        padding: const EdgeInsets.all(40.0),
        child: new Form(
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
              ),
              new TextFormField(
                decoration: new InputDecoration(
                    hintText: "Email", fillColor: Colors.white),
                obscureText: true,
                keyboardType: TextInputType.text,
              ),
              new TextFormField(
                decoration: new InputDecoration(
                    hintText: "Repeat Email", fillColor: Colors.white),
                obscureText: true,
                keyboardType: TextInputType.text,
              ),
              new TextFormField(
                decoration: new InputDecoration(
                    hintText: "Password", fillColor: Colors.white),
                obscureText: true,
                keyboardType: TextInputType.text,
              ),
              new TextFormField(
                decoration: new InputDecoration(
                    hintText: "Repeat Password", fillColor: Colors.white),
                obscureText: true,
                keyboardType: TextInputType.text,
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
                child: Text("Register"),
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}

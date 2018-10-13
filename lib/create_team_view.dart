/*
 * Copyright 2018 Leszek Nowaczyk. All rights reserved.
 * If you get hold of this code you probably found it on github ;)
 */

import 'package:flutter/material.dart';

class CreateTeamView extends StatefulWidget {
  @override
  _CreateTeamViewState createState() => _CreateTeamViewState();
}

class _CreateTeamViewState extends State<CreateTeamView> {

  double _budget = 67.0;

  emptyPlayer(int i) {
    return Expanded(
      child: InkWell(
        onTap: () => null,
        child: Image.asset("assets/shirt_blank.png", fit: BoxFit.fitHeight,),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    Function updateState = () {
      setState(() {
      });
    };

    return Scaffold(
        body: Stack(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                      child: Stack(
                          children: <Widget>[
                            Positioned.fill(
                                child: Image.asset("assets/pitch.jpg", fit: BoxFit.fitWidth, alignment: Alignment.topLeft,)
                            )
                          ]
                      )
                  ),
                ],
              ),
              Column( //players
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                      flex: 4,
                      child: Container()
                  ),
                  Expanded(
                      flex: 6,
                      child:  Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: List.generate(2, (index) => emptyPlayer(index)),
                      )
                  ),
                  Expanded(
                      flex: 1,
                      child: Container()
                  ),
                  Expanded(
                      flex: 6,
                      child:  Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: List.generate(5, (index) =>  emptyPlayer(index+2)),
                      )
                  ),
                  Expanded(
                      flex: 1,
                      child: Container()
                  ),
                  Expanded(
                      flex: 6,
                      child:  Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: List.generate(5, (index) =>  emptyPlayer(index+7)),
                      )
                  ),
                  Expanded(
                      flex: 1,
                      child: Container()
                  ),
                  Expanded(
                      flex: 6,
                      child:  Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: List.generate(4, (index) =>  emptyPlayer(index+12)),
                      )
                  ),
                  Expanded(
                      flex: 7,
                      child: Container()
                  ),
                  Container(padding: EdgeInsets.only(left: 8.0, right: 8.0),child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Text("Remaining Budget"),
                          ),
                          Text("£${_budget}m")
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Text("At least one player from every team:"),
                          ),
                          Checkbox(
                            value: false,
                            onChanged: (bool) => null,
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Text("At least two freshers:"),
                          ),
                          Checkbox(
                            value: false,
                            onChanged: (bool) => null,
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Text("Max three players from same team"),
                          ),
                          Checkbox(
                            value: true,
                            onChanged: (bool) => null,
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: "Team Name",
                                ),
                              )
                          ),
                          Checkbox(
                            value: false,
                            onChanged: (bool) => null,
                          )
                        ],
                      ),
                    ],
                  ),)
                  ,
                  new MaterialButton(
                    height: 50.0,
                    minWidth: double.infinity,
                    color: Colors.blueAccent,
                    splashColor: Colors.teal,
                    textColor: Colors.white,
                    child: Text("Press to save changes"),
                    onPressed: () => null,
//                      onPressed: () {
//                        setState(() {
//                          saveChanges = FutureBuilder(
//
//                            future: InternetAsync().updateTeam(context),
//                            builder: (context, snapshot) {
//                              if (snapshot.connectionState == ConnectionState.done) {
//                                return Text("Press to save changes");
//                              }
//
//                              // By default, show a loading spinner
//                              return CircularProgressIndicator();
//                            },
//                          );
//                        });
//                      }
                  ),

                ],
              ),
            ],
        )
    );
  }
}

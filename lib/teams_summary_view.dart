/*
 * Copyright 2018 Leszek Nowaczyk. All rights reserved.
 * If you get hold of this code you probably found it on github ;)
 */

import 'package:flutter/material.dart';
import 'package:ic_fantasy_football/controller/team_lab.dart';
import 'package:ic_fantasy_football/model/team.dart';
import 'package:ic_fantasy_football/teams_details_view.dart';

class TeamsSummaryView extends StatelessWidget {
  final List<Team> teams = TeamLab.get().teams;
  @override
  Widget build(BuildContext context) {
    final List<Team> teams2 = List.from(teams);
    teams.sort((Team a, Team b) {
      return a.points.compareTo(b.points);
    });
    teams2.sort((Team a, Team b) {
      return b.pointsWeek.compareTo(a.pointsWeek);
    });

    return Column (
      children: <Widget>[
        new MaterialButton(
            height: 50.0,
            minWidth: 200.0,
            color: Colors.blueAccent,
            splashColor: Colors.teal,
            textColor: Colors.white,
            child: Text("View all teams"),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {return TeamsDetailsView();})),
        ),
        Text ("Overall Leadearboard"),
        Container(
          color: Colors.amber,
          child: Row(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Image.asset("assets/first.png", height: 100.0,),
                  Text(teams[teams.length-1].points.toString()),
                  Text(teams[teams.length-1].pointsWeek.toString())
                ],
              ),
              Column(
                children: <Widget>[
                  Text(teams[teams.length-1].name),
                  Text(teams[teams.length-1].owner),
                ],
              )
            ],
          ),
        ),
        Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.white70,
                child: Row(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Image.asset("assets/second.png", height: 100.0,),
                        Text(teams[teams.length-2].points.toString()),
                        Text(teams[teams.length-2].pointsWeek.toString())
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Text(teams[teams.length-2].name),
                        Text(teams[teams.length-2].owner),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.brown,
                child: Row(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Image.asset("assets/third.png", height: 100.0,),
                        Text(teams[teams.length-3].points.toString()),
                        Text(teams[teams.length-3].pointsWeek.toString())
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Text(teams[teams.length-3].name),
                        Text(teams[teams.length-3].owner),
                      ],
                    )
                  ],
                ),
              )
            ),
          ],
        ),
        Text ("Weekly Leadearboard"),
        Container(
          color: Colors.amber,
          child: Row(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Image.asset("assets/first.png", height: 100.0,),
                  Text(teams2[0].points.toString()),
                  Text(teams2[0].pointsWeek.toString())
                ],
              ),
              Column(
                children: <Widget>[
                  Text(teams2[0].name),
                  Text(teams2[0].owner),
                ],
              )
            ],
          ),
        ),
        Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.white70,
                child: Row(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Image.asset("assets/second.png", height: 100.0,),
                        Text(teams2[1].points.toString()),
                        Text(teams2[1].pointsWeek.toString())
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Text(teams2[1].name),
                        Text(teams2[1].owner),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Expanded(
                flex: 1,
                child: Container(
                  color: Colors.brown,
                  child: Row(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Image.asset("assets/third.png", height: 100.0,),
                          Text(teams2[2].points.toString()),
                          Text(teams2[2].pointsWeek.toString())
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Text(teams2[2].name),
                          Text(teams2[2].owner),
                        ],
                      )
                    ],
                  ),
                )
            ),
          ],
        )
      ],
    );
  }
}


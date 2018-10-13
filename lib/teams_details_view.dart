/*
 * Copyright 2018 Leszek Nowaczyk. All rights reserved.
 * If you get hold of this code you probably found it on github ;)
 */
import 'package:flutter/material.dart';
import 'package:ic_fantasy_football/controller/team_lab.dart';
import 'package:ic_fantasy_football/model/team.dart';
import 'package:ic_fantasy_football/team_other_display_view.dart';

class TeamsDetailsView extends StatefulWidget {

  const TeamsDetailsView ({
    Key key,
  })  : super(key: key);

  @override
  _TeamsDetailsViewState createState() => _TeamsDetailsViewState();
}

class _TeamsDetailsViewState extends State<TeamsDetailsView> {
  bool sortDesc = true, sortName = false, sortOwner = false, sortValue = false, sortPoints = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Teams"),),
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: InkWell(
                    onTap: () {
                      setState(() {
                        (sortDesc) ? sortDesc = false : sortDesc = true;
                        sortName = true;
                        sortOwner = false;
                        sortValue = false;
                        sortPoints = false;
                        TeamLab.get().teams.sort((Team a, Team b) {
                          if (sortDesc) {
                            return a.name.toLowerCase().compareTo(b.name.toLowerCase());
                          } else {
                            return b.name.toLowerCase().compareTo(a.name.toLowerCase());
                          }
                        });
                      });
                    },
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text("Name"),
                        ),
                        (sortName) ? Icon((sortDesc) ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up) : Container()
                      ],
                    )
                ),
              ),
              Expanded(
                flex: 1,
                child: InkWell(
                    onTap: () {
                      setState(() {
                        (sortDesc) ? sortDesc = false : sortDesc = true;
                        sortName = false;
                        sortOwner = true;
                        sortValue = false;
                        sortPoints = false;
                        TeamLab.get().teams.sort((Team a, Team b) {
                          if (sortDesc) {
                            return a.owner.toLowerCase().compareTo(b.owner.toLowerCase());
                          } else {
                            return b.owner.toLowerCase().compareTo(a.owner.toLowerCase());
                          }
                        });
                      });
                    },
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text("Onwer"),
                        ),
                        (sortOwner) ? Icon((sortDesc) ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up) : Container()
                      ],
                    )
                ),
              ),
              Expanded(
                flex: 1,
                child: InkWell(
                    onTap: () {
                      setState(() {
                        (sortDesc) ? sortDesc = false : sortDesc = true;
                        sortName = false;
                        sortOwner = false;
                        sortValue = true;
                        sortPoints = false;
                        TeamLab.get().teams.sort((Team a, Team b) {
                          if (sortDesc) {
                            return a.price.compareTo(b.price);
                          } else {
                            return b.price.compareTo(a.price);
                          }
                        });
                      });
                    },
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text("Value"),
                        ),
                        (sortValue) ? Icon((sortDesc) ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up) : Container()
                      ],
                    )
                ),
              ),
              Expanded(
                flex: 1,
                child: InkWell(
                    onTap: () {
                      setState(() {
                        (sortDesc) ? sortDesc = false : sortDesc = true;
                        sortName = false;
                        sortOwner = false;
                        sortValue = false;
                        sortPoints = true;
                        TeamLab.get().teams.sort((Team a, Team b) {
                          if (sortDesc) {
                            return a.points.compareTo(b.points);
                          } else {
                            return b.points.compareTo(a.points);
                          }
                        });
                      });
                    },
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text("Points"),
                        ),
                        (sortPoints) ? Icon((sortDesc) ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up) : Container()
                      ],
                    )
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                Team team = TeamLab.get().teams[index];
                return InkWell(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {return TeamOtherDisplayView(team: team,);})),
                    child: Row(children: <Widget>[
                      Expanded(

                        flex: 1,
                        child: Text(team.name),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(team.owner),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(team.price.toString()),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(team.points.toString()),
                      ),
                    ],)
                );
              },
              itemCount: TeamLab.get().teams.length,
            ),
          )
        ],
      ),
    );
  }
}

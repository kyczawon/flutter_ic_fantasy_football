/*
 * Copyright 2018 Leszek Nowaczyk. All rights reserved.
 * If you get hold of this code you probably found it on github ;)
 */

import 'package:flutter/material.dart';
import 'package:ic_fantasy_football/model/player.dart';

class PlayerDetailsView extends StatelessWidget {
  final Player _p;

  PlayerDetailsView(this._p);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_p.fullName),
      ),
      body: Column(children: <Widget>[
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10, left: 10),
              child: Column(
                children: <Widget>[
                  Text(
                    _p.fullName,
                    style: TextStyle(color: Colors.black87, fontSize: 20),
                  ),
                  Text(
                    _p.position + ' in the ' + _p.teamAsString + ' team',
                    style: TextStyle(color: Colors.black87, fontSize: 20),
                  ),
                ],
              )),
        ),
        Row(
          children: <Widget>[
            Image.asset(
              _p.image,
              height: 200.0,
            ),
            Column(
              children: <Widget>[
                getStatText('Points', _p.points.toString()),
                getStatText('Points This Week', _p.pointsWeek.toString()),
                getStatText('Apps', _p.appearances.toString()),
                getStatText('Sub Apps', _p.subAppearances.toString()),
                getStatText('Goals', _p.goals.toString()),
                getStatText('Assists', _p.assists.toString()),
                getStatText('MOTMs', _p.motms.toString()),
                getStatText('CSs', _p.cleanSheets.toString()),
                getStatText('Yellow Cards', _p.yellowCards.toString()),
                getStatText('Red Cards', _p.redCards.toString()),
                getStatText('Own Goals', _p.ownGoals.toString()),
              ],
            )
          ],
        ),
      ]),
    );
  }

  Widget getStatText(String text, String stat) {
    return new RichText(
      text: new TextSpan(
        style: new TextStyle(
          fontSize: 14.0,
          color: Colors.black87,
        ),
        children: <TextSpan>[
          new TextSpan(
              text: text + ': ',
              style: new TextStyle(fontWeight: FontWeight.bold)),
          new TextSpan(text: stat),
        ],
      ),
    );
  }
}

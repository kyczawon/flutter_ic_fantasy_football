/*
 * Copyright 2018 Leszek Nowaczyk. All rights reserved.
 * If you get hold of this code you probably found it on github ;)
 */

// Copyright 2018 Leszek Nowaczyk. All rights reserved.
// If you get hold of this code you probably found it on github ;)

import 'package:flutter/material.dart';
import 'package:ic_fantasy_football/model/player.dart';
import 'package:ic_fantasy_football/player_details_view.dart';

class PlayerDisabledDragView extends StatefulWidget {
  final Player player;

  PlayerDisabledDragView({Key key, @required this.player}) : super(key: key);

  @override
  _PlayerDisabledDragViewState createState() => _PlayerDisabledDragViewState();
}

class _PlayerDisabledDragViewState extends State<PlayerDisabledDragView> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child: GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return PlayerDetailsView(widget.player);
              }));
            },
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Image.asset(
                    widget.player.image,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Container(
                  color: Colors.green,
                  child: Text(
                    widget.player.firstName.substring(0, 1) +
                        ". " +
                        widget.player.lastName,
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  color: Colors.green,
                  child: Text(
                      widget.player.points.toString() +
                          "|" +
                          widget.player.pointsWeek.toString(),
                      textAlign: TextAlign.center),
                ),
              ],
            )));
  }
}

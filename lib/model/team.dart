/*
 * Copyright 2018 Leszek Nowaczyk. All rights reserved.
 * If you get hold of this code you probably found it on github ;)
 */

import 'package:ic_fantasy_football/model/player.dart';
import 'package:ic_fantasy_football/controller/player_lab.dart';

class Team {
   int _teamId;
   String _name;
   String _owner;
   double _price;
   int _points;
   int _pointsWeek;
   int _defNum;
   int _midNum;
   int _fwdNum;
   List<Player> _players = new List();


   Team(this._teamId, this._name, this._owner, this._price, this._points, this._pointsWeek,
       this._defNum, this._midNum, this._fwdNum, goalId, player1Id,
       player2Id, player3Id, player4Id, player5Id,
       player6Id, player7Id, player8Id, player9Id,
       player10Id, subGoalId, sub1Id, sub2Id, sub3Id,
       sub4Id) {
     PlayerLab playerLab = PlayerLab.get();
     _players.add(playerLab.getPlayer(goalId));
     _players.add(playerLab.getPlayer(player1Id));
     _players.add(playerLab.getPlayer(player2Id));
     _players.add(playerLab.getPlayer(player3Id));
     _players.add(playerLab.getPlayer(player4Id));
     _players.add(playerLab.getPlayer(player5Id));
     _players.add(playerLab.getPlayer(player6Id));
     _players.add(playerLab.getPlayer(player7Id));
     _players.add(playerLab.getPlayer(player8Id));
     _players.add(playerLab.getPlayer(player9Id));
     _players.add(playerLab.getPlayer(player10Id));
     _players.add(playerLab.getPlayer(subGoalId));
     _players.add(playerLab.getPlayer(sub1Id));
     _players.add(playerLab.getPlayer(sub2Id));
     _players.add(playerLab.getPlayer(sub3Id));
     _players.add(playerLab.getPlayer(sub4Id));
   }

   factory Team.fromJson(Map<String, dynamic> json, int teamId) {
     return Team(teamId, json['name'], json['owner'], double.parse(json['price']), int.parse(json['points']),
      int.parse(json['points_week']), int.parse(json['def_num']), int.parse(json['mid_num']), int.parse(json['fwd_num']),
      int.parse(json['goal']), int.parse(json['player1']), int.parse(json['player2']), int.parse(json['player3']),
      int.parse(json['player4']), int.parse(json['player5']), int.parse(json['player6']), int.parse(json['player7']),
      int.parse(json['player8']), int.parse(json['player9']), int.parse(json['player10']), int.parse(json['sub_goal']),
      int.parse(json['sub1']), int.parse(json['sub2']), int.parse(json['sub3']),int.parse(json['sub4']));
   }

   factory Team.fromTeamsJson(Map<String, dynamic> json) {
     return Team(int.parse(json['team_id']), json['name'], json['owner'], double.parse(json['price']), int.parse(json['points']),
         int.parse(json['points_week']), int.parse(json['def_num']), int.parse(json['mid_num']), int.parse(json['fwd_num']),
         int.parse(json['goal']), int.parse(json['player1']), int.parse(json['player2']), int.parse(json['player3']),
         int.parse(json['player4']), int.parse(json['player5']), int.parse(json['player6']), int.parse(json['player7']),
         int.parse(json['player8']), int.parse(json['player9']), int.parse(json['player10']), int.parse(json['sub_goal']),
         int.parse(json['sub1']), int.parse(json['sub2']), int.parse(json['sub3']),int.parse(json['sub4']));
   }

   int get fwdNum => _fwdNum;

   int get midNum => _midNum;

   int get defNum => _defNum;

   int get pointsWeek => _pointsWeek;

   int get points => _points;

   double get price => _price;

   String get owner => _owner;

   String get name => _name;

   int get teamId => _teamId;

   String playerAt (int index) => players[index].playerID.toString();

   List<Player> get players => _players;

   set fwdNum(int value) {
     _fwdNum = value;
   }

   set midNum(int value) {
     _midNum = value;
   }

   set defNum(int value) {
     _defNum = value;
   }

   shiftPlayersAndInsert(delIndex, insertIndex, player) {
     _players.removeAt(delIndex);
     _players.insert(insertIndex, player);
   }

   int getCurrentWeeklyPoints() {
     int currentWeeklyPoints = 0;
     for (Player player in players) {
       currentWeeklyPoints+=player.pointsWeek;
     }
     return currentWeeklyPoints;
   }

}
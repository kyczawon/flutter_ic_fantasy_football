/*
 * Copyright 2018 Leszek Nowaczyk. All rights reserved.
 * If you get hold of this code you probably found it on github ;)
 */

import 'package:ic_fantasy_football/model/team_stats.dart';
import 'package:ic_fantasy_football/model/player_update.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ic_fantasy_football/model/player.dart';
import 'package:ic_fantasy_football/model/user.dart';

part 'player_update_lab.g.dart';

@JsonSerializable(nullable: false, createToJson: true, createFactory: false, explicitToJson: false)
class PlayerUpdateLab  {
  bool _cleanSheet = false;
  int _team;
  int _ICScore;
  int _opponentScore;
  String _opponent;
  String _username;
  int _userId;
  Map<int, PlayerUpdate> _players = Map();

  PlayerUpdateLab() {
    TeamStats ts = TeamStats.get();
    User user = User.get();
    //override clean sheets
    _cleanSheet = ts.cleanSheet;
    _team = ts.team;
    _opponentScore = ts.opponentScore;
    _ICScore = ts.ICScore;
    _opponent = ts.opponent;
    _username = user.username;
    _userId = user.userId;

    for (Player p in ts.getSelectedPlayers(Stat.appearances)) {
      _players[p.playerID] = (PlayerUpdate(p.playerID, false, p.position));
    }
    for (Player p in ts.getSelectedPlayers(Stat.subs)) {
      _players[p.playerID] = (PlayerUpdate(p.playerID, true, p.position));
    }
    for (Player p in ts.getSelectedPlayers(Stat.motm)) {
    _players[p.playerID].motms = 1;
    }
    for (Player p in ts.getSelectedPlayers(Stat.goals)) {
      _players[p.playerID].goals += 1;
    }
    for (Player p in ts.getSelectedPlayers(Stat.assists)) {
      _players[p.playerID].assists += 1;
    }
    for (Player p in ts.getSelectedPlayers(Stat.ownGoals)) {
      _players[p.playerID].ownGoals += 1;
    }
    for (Player p in ts.getSelectedPlayers(Stat.redCards)) {
    _players[p.playerID].redCards += 1;
    }
    for (Player p in ts.getSelectedPlayers(Stat.yellowCards)) {
    _players[p.playerID].yellowCards += 1;
    }
  }

  List<PlayerUpdate> get playerUpdates => _players.values.toList();

  bool get cleanSheet => _cleanSheet;

  int get team => _team;

  Map<String, dynamic> toJson() => _$PlayerUpdateLabToJson(this);

  int get ICScore => _ICScore;

  int get opponentScore => _opponentScore;

  String get opponent => _opponent;

  int get userId => _userId;

  String get username => _username;


}

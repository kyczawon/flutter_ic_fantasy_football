/*
 * Copyright 2018 Leszek Nowaczyk. All rights reserved.
 * If you get hold of this code you probably found it on github ;)
 */
import 'package:ic_fantasy_football/model/player.dart';
import 'package:ic_fantasy_football/controller/player_lab.dart';

enum Stat {
  appearances,
  subs,
  motm,
  yellowCards,
  redCards,
  goals,
  assists,
  ownGoals
}

class TeamStats {
  int _team = 1;
  String _opponent = "";
  int _ICScore = 0;
  int _opponentScore = 0;
  List<Player> _appAvailablePlayers = PlayerLab.get().players;
  List<Player> _subAvailablePlayers = PlayerLab.get().players;
  List<List<Player>> _currentStats =
      List.generate(Stat.ownGoals.index + 1, (int index) => List());
  static TeamStats _teamStats;

  static TeamStats get() {
    if (_teamStats == null) {
      _teamStats = new TeamStats();
    }
    return _teamStats;
  }

  //(players for the rest selection can be selected as union of index 0 and 1 in _currentStats
  List<Player> getAvailablePlayers(Stat stat) {
    if (stat == Stat.appearances) {
      return _appAvailablePlayers;
    }
    if (stat == Stat.subs) {
      return _subAvailablePlayers;
    }

    return _currentStats[0] + _currentStats[1];
  }

  List<Player> getSelectedPlayers(Stat stat) {
    return _currentStats[stat.index];
  }

  bool isPlayerSelected(Player player, Stat stat) {
    return _currentStats[stat.index].contains(player);
  }

  int getStatCount(Stat stat) {
    return _currentStats[stat.index].length;
  }

  int getStatPlayerCount(Player player, Stat stat) {
    return _currentStats[stat.index].where((Player p) => p == player).length;
  }

  //remove appearance players from subs list
  setSubSelection() {
    _subAvailablePlayers = PlayerLab.get().players;
    for (Player player in _currentStats[0]) {
      _subAvailablePlayers.remove(player);
    }
  }

  addPlayer(Player player, Stat stat) {
    _currentStats[stat.index].add(player);
  }

  removePlayer(Player player, Stat stat) {
    _currentStats[stat.index].remove(player);
  }

  Stat nextStat(Stat stat) {
    return Stat.values[stat.index + 1];
  }

  //all stats including goals and after are buttoned
  bool isNextStatButtoned(Stat stat) {
    return nextStat(stat).index >= Stat.goals.index;
  }

  bool isFinalButton(Stat stat) {
    return stat.index == Stat.ownGoals.index;
  }

  String statAsString(Stat stat) {
    switch (stat) {
      case Stat.appearances:
        return "Starting players";
      case Stat.subs:
        return "Subs";
      case Stat.motm:
        return "MOTM";
      case Stat.goals:
        return "Goals";
      case Stat.assists:
        return "Assists";
      case Stat.ownGoals:
        return "Own Goals";
      case Stat.yellowCards:
        return "Yellow Cards";
      case Stat.redCards:
        return "Red Cards";
    }
  }

  void resetAll() {
    _currentStats =
        List.generate(Stat.ownGoals.index + 1, (int index) => List());
  }

  bool get cleanSheet => _opponentScore == 0;

  static set teamStats(TeamStats value) {
    _teamStats = value;
  }


  int get ICScore => _ICScore;

  set opponentScore(int value) {
    _opponentScore = value;
  }

  set ICScore(int value) {
    _ICScore = value;
  }

  int get opponentScore => _opponentScore;

  String get opponent => _opponent;

  set opponent(String value) {
    _opponent = value;
  }

  int get team => _team;

  set team(int value) {
    _team = value;
  }


}

/*
 * Copyright 2018 Leszek Nowaczyk. All rights reserved.
 * If you get hold of this code you probably found it on github ;)
 */
import 'package:ic_fantasy_football/model/player.dart';

class PlayerLab {
  List<Player> _players = List();
  static PlayerLab _sPlayerLab;

  static PlayerLab get() {
    if (_sPlayerLab == null) {
      throw "sPlayerLab is null";
    }
    return _sPlayerLab;
  }

  void addPlayer(Player player) {
    _sPlayerLab.players.add(player);
  }

  Player getPlayer(int id) {
    for (Player player in _players) {
      if (player.playerID == id) {
        return player;
      }
    }
    return null;
  }

  PlayerLab();

  PlayerLab.fromJson(List<dynamic> json) {
    _sPlayerLab = PlayerLab();
    for (Map<String, dynamic> playerJson in json) {
        addPlayer(Player.fromJson(playerJson));
      }
  }

  List<Player> get players => _players;

}

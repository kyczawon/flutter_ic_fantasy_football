// Copyright 2018 Leszek Nowaczyk. All rights reserved.
// If you get hold of this code you probably found it on github ;)

import 'package:json_annotation/json_annotation.dart';

part 'player_update.g.dart';

@JsonSerializable(createToJson: true, createFactory: false, explicitToJson: false)
class PlayerUpdate {
  int _playerID;
  int _appearances = 0;
  int _subAppearances = 0;
  int _goals = 0;
  int _assists = 0;
  int _cleanSheets = 0;
  int _motms = 0;
  int _ownGoals = 0;
  int _redCards = 0;
  int _yellowCards = 0;
  String _position;

  PlayerUpdate(this._playerID, bool isSub, String position) {
    if (isSub) {
      _subAppearances = 1;
    } else {
      _appearances = 1;
    }
    _position = position;
  }

  set yellowCards(int value) {
    _yellowCards = value;
  }

  set redCards(int value) {
    _redCards = value;
  }

  set ownGoals(int value) {
    _ownGoals = value;
  }

  set motms(int value) {
    _motms = value;
  }

  set cleanSheets(int value) {
    _cleanSheets = value;
  }

  set assists(int value) {
    _assists = value;
  }

  set goals(int value) {
    _goals = value;
  }

  set subAppearances(int value) {
    _subAppearances = value;
  }

  set appearances(int value) {
    _appearances = value;
  }

  int get yellowCards => _yellowCards;

  int get redCards => _redCards;

  int get ownGoals => _ownGoals;

  int get motms => _motms;

  int get cleanSheets => _cleanSheets;

  int get assists => _assists;

  int get goals => _goals;

  int get subAppearances => _subAppearances;

  int get appearances => _appearances;

  int get playerID => _playerID;

  String get position => _position;

  Map<String, dynamic> toJson() => _$PlayerUpdateToJson(this);
}

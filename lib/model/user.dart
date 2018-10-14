/*
 * Copyright 2018 Leszek Nowaczyk. All rights reserved.
 * If you get hold of this code you probably found it on github ;)
 */

import 'package:ic_fantasy_football/model/team.dart';

class User {
  int _userId;
  int _teamId;
  String _username;
  int _adminedTeam;
  bool _isSuperAdmin;
  static User _sUser;
  Team _team;

  User(this._userId, this._teamId, this._username, this._adminedTeam,
      this._isSuperAdmin);

  User. fromJson(Map<String, dynamic> json, String username) {
    create(int.parse(json['user_id']), int.parse(json['team_id']), username, int.parse(json['admined_team']), json['is_super_admin']==1);
  }

  static User get() {
    if (_sUser == null) {
      throw "User is null";
    }
    return _sUser;
  }

  static void create(int userId, int teamId, String username, int adminedTeam, bool isSuperAdmin) {
    if (_sUser == null) {
      _sUser = new User(userId, teamId, username, adminedTeam, isSuperAdmin);
    }
  }



  void clearUser() {
    _sUser = null;
  }

  int get userId => _userId;

  int get teamId => _teamId;

  String get username => _username;

  int get adminedTeam => _adminedTeam;

  bool get isSuperAdmin => _isSuperAdmin;

  Team get team => _team;

  set team(Team value) {
    _team = value;
  }

  set teamId(int value) {
    _teamId = value;
  }


}


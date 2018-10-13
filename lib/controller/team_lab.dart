/*
 * Copyright 2018 Leszek Nowaczyk. All rights reserved.
 * If you get hold of this code you probably found it on github ;)
 */

/*
 * Copyright 2018 Leszek Nowaczyk. All rights reserved.
 * If you get hold of this code you probably found it on github ;)
 */
import 'package:ic_fantasy_football/model/team.dart';
import 'package:ic_fantasy_football/model/user.dart';

class TeamLab {
  List<Team> _teams = List();
  static TeamLab _sTeamLab;

  static TeamLab get() {
    if (_sTeamLab == null) {
      throw "sTeamLab is null";
    }
    return _sTeamLab;
  }

  void addTeam(Team team) {
    User user = User.get();
    if (team.teamId == user.teamId) {
      user.team = team;
    }
    _sTeamLab.teams.add(team);
  }

  TeamLab();

  TeamLab.fromJson(List<dynamic> json) {
    _sTeamLab = TeamLab();
    for (Map<String, dynamic> teamJson in json) {
      addTeam(Team.fromTeamsJson(teamJson));
    }
  }

  List<Team> get teams => _teams;

}

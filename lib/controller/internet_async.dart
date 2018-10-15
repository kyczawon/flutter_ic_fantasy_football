/*
 * Copyright 2018 Leszek Nowaczyk. All rights reserved.
 * If you get hold of this code you probably found it on github ;)
 */

import 'package:flutter/material.dart';
import 'package:ic_fantasy_football/navigation_drawer.dart';
import 'package:ic_fantasy_football/model/user.dart';
import 'package:ic_fantasy_football/model/team.dart';
import 'package:ic_fantasy_football/model/app_state.dart';
import 'package:ic_fantasy_football/controller/player_lab.dart';
import 'package:ic_fantasy_football/controller/team_lab.dart';
import 'package:ic_fantasy_football/create_team_view.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flushbar/flushbar.dart';

import 'package:http/http.dart' as http;

class InternetAsync {
  Future<User> fetchUser(context, username, password) async {
    String message ="";
    http.Response response;
    try {
      response = await http.get("https://union.ic.ac.uk/acc/football/android_connect/check_user.php?username=" + username
          + "&password="+ password);
      if (response.statusCode == 200) {
        if (response.body.toString() != '"Invalid username or password"') {
          // If the call to the server was successful, parse the JSON to get user data
          User.fromJson(json.decode(response.body)[0], username);
          fetchAppState(context);
          fetchPlayers(context);
        } else {
          message = 'Invalid username or password';
        }
      } else {
        message = 'Cannot connect to server';
      }
    }
    catch (e) {
      message = 'Cannot connect to server';
    }
    if (message != "") {
      final snackBar = SnackBar(
          content: Text(message),
          duration: Duration(seconds: 2)
      );
      Scaffold.of(context).showSnackBar(snackBar);
    }
    return null;
  }

  //the last fetch has to build the navigation drawer
  fetchAppState(context) async {
    String message ="";
    http.Response response;
    try {
      response = await http.get("https://union.ic.ac.uk/acc/football/android_connect/get_state.php");
      if (response.statusCode == 200) {
        // If the call to the server was successful, parse the JSON to get user data
        AppState.fromJson(json.decode(response.body)[0]);
      } else {
        message = 'Cannot fetch app state from servers';
      }
    } catch (e) {
      message = 'Cannot fetch app state from servers';
    }
    if (message != "") {
      final snackBar = SnackBar(
          content: Text(message),
          duration: Duration(seconds: 2)
      );
      Scaffold.of(context).showSnackBar(snackBar);
    }
  }

  fetchPlayers(context) async {
    String message ="";
    http.Response response;
    try {
      response = await http.get("https://union.ic.ac.uk/acc/football/android_connect/players.php");
      if (response.statusCode == 200) {
        // If the call to the server was successful, parse the JSON to get user data
        PlayerLab.fromJson(json.decode(response.body));
        fetchTeams(context);
      } else {
        message = 'Cannot fetch players from servers';
      }
    } catch (e) {
      message = 'Cannot fetch players from servers';
    }
    if (message != "") {
      final snackBar = SnackBar(
          content: Text(message),
          duration: Duration(seconds: 2)
      );
      Scaffold.of(context).showSnackBar(snackBar);
    }
  }

  fetchTeams(context) async {
    String message ="";
    http.Response response;
    try {
      response = await http.get("https://union.ic.ac.uk/acc/football/android_connect/teams.php");
      if (response.statusCode == 200) {
        // If the call to the server was successful, parse the JSON to get teams data
        TeamLab.fromJson(json.decode(response.body));
        if (User.get().teamId == 0) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (BuildContext context) {
            return CreateTeamView();
          }));
        } else {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (BuildContext context) {
            return NavigationDrawer();
          }));
        }
      } else {
        message = 'Cannot fetch teams from servers';
      }
    } catch (e) {
      message = 'Cannot fetch teams from servers';
    }
    if (message != "") {
      final snackBar = SnackBar(
          content: Text(message),
          duration: Duration(seconds: 2)
      );
      Scaffold.of(context).showSnackBar(snackBar);
    }
  }

  Future updateTeam(context) async {
    Team team = User.get().team;
    String message ="";
    http.Response response;
    response = await http.get("https://union.ic.ac.uk/acc/football/android_connect/edit_team.php?team_id=" + team.teamId.toString()
        + "&def_num=" + team.defNum.toString() + "&mid_num=" + team.midNum.toString() + "&fwd_num="+ team.fwdNum.toString()
        + "&goal=" + team.playerAt(0) + "&player1=" + team.playerAt(1) + "&player2=" + team.playerAt(2)
        + "&player3=" + team.playerAt(3) + "&player4=" + team.playerAt(4) + "&player5=" + team.playerAt(5)
        + "&player6=" + team.playerAt(6) + "&player7=" + team.playerAt(7) + "&player8=" + team.playerAt(8)
        + "&player9=" + team.playerAt(9) + "&player10=" + team.playerAt(10) + "&sub_goal=" + team.playerAt(11)
        + "&sub1=" + team.playerAt(12) + "&sub2=" + team.playerAt(13) + "&sub3=" + team.playerAt(14)
        + "&sub4=" + team.playerAt(15));
    if (response.statusCode == 200) {
      message = response.body.toString();
    } else {
      message = 'Could not update players';
    }
    if (message != "") {
      final snackBar = SnackBar(
          content: Text(message),
          duration: Duration(seconds: 2)
      );
      Scaffold.of(context).showSnackBar(snackBar);
    }
  }

  Future addTeam(context, Team team) async {
    String message ="";
    http.Response response;
    try {
      response = await http.get(
          "https://union.ic.ac.uk/acc/football/android_connect/add_team.php?user_id="
              + User
              .get()
              .userId
              .toString() + "&name=" + team.name + "&owner=" + team.owner +
              "&price=" + team.price.toString()
              + "&goal=" + team.playerAt(0) + "&player1=" + team.playerAt(1) +
              "&player2=" + team.playerAt(2)
              + "&player3=" + team.playerAt(3) + "&player4=" +
              team.playerAt(4) + "&player5=" + team.playerAt(5)
              + "&player6=" + team.playerAt(6) + "&player7=" +
              team.playerAt(7) + "&player8=" + team.playerAt(8)
              + "&player9=" + team.playerAt(9) + "&player10=" +
              team.playerAt(10) + "&sub_goal=" + team.playerAt(11)
              + "&sub1=" + team.playerAt(12) + "&sub2=" + team.playerAt(13) +
              "&sub3=" + team.playerAt(14)
              + "&sub4=" + team.playerAt(15));
      if (response.statusCode == 200) {
        //get the teamId of the newly created team
        int teamId = int.parse(json.decode(response.body)[0]['@last_id_in_teams']);
        team.teamId = teamId;
        TeamLab.get().teams.add(team);
        User.get().teamId = teamId;
        User.get().team = team;
        message = response.body.toString();
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (BuildContext context) {
          return NavigationDrawer();
        }));
      } else {
        message = 'Could not add team, try again later';
      }
    } catch (e) {
      message = 'Could not add team, try again later';
    }
    if (message != "") {
      final snackBar = SnackBar(
          content: Text(message),
          duration: Duration(seconds: 2)
      );
      Scaffold.of(context).showSnackBar(snackBar);
    }
  }

  addUser(context, String username, String email, String password) async {
    String message ="";
    http.Response response;
    try {
      response = await http.get("https://union.ic.ac.uk/acc/football/android_connect/check_username&email.php?username=" + username
      + "&email=" + email);
      if (response.statusCode == 200) {
        // If the call to the server was successful, parse the JSON to get teams data
        if (response.body.toString() == 'success') {
          addUserToDB(context, username, email, password);
        } else {
          message = response.body.toString();
        }
      } else {
        message = 'Cannot add user';
      }
    } catch (e) {
      message = 'Cannot add user';
    }
    if (message != "") {
      final snackBar = SnackBar(
          content: Text(message),
          duration: Duration(seconds: 2)
      );
      Scaffold.of(context).showSnackBar(snackBar);
    }
  }

  addUserToDB(context, String username, String email, String password) async {
    String message ="";
    http.Response response;
    try {
      response = await http.get("https://union.ic.ac.uk/acc/football/android_connect/add_user.php?username=" + username
          + "&email=" + email + "&password=" + password);
      if (response.statusCode == 200) {
        // If the call to the server was successful, parse the JSON to get teams data
        if (response.body.toString() == 'success') {
          message = "Click on the link in the confirmation email and log in";
          Navigator.pop(context);
        } else {
          message = response.body.toString();
        }
      } else {
        message = 'Cannot add user to db';
      }
    } catch (e) {
      message = 'Cannot add user to db';
    }
    if (message != "") {
      Flushbar()
        ..message = message
        ..duration = Duration(seconds: 5)
        ..show(context);
    }
  }

}
// Copyright 2018 Leszek Nowaczyk. All rights reserved.
// If you get hold of this code you probably found it on github ;)
import 'package:flutter/material.dart';
import 'package:ic_fantasy_football/team_display_view.dart';
import 'package:ic_fantasy_football/teams_details_view.dart';
import 'package:ic_fantasy_football/players_details_view.dart';
import 'package:ic_fantasy_football/leaderboard_view.dart';
import 'package:ic_fantasy_football/test.dart';
import 'package:ic_fantasy_football/login_view.dart';
import 'package:ic_fantasy_football/model/user.dart';

class NavigationDrawer extends StatefulWidget {
  @override
  _NavigationDrawerState createState() => new _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {

  Widget widgetForBody = TeamDisplayView();

  @override
  Widget build(BuildContext context) {
    Function updateFragment = (Widget widget) {
      setState(() {
        widgetForBody = widget;
      });
    };
    return WillPopScope(
      onWillPop: () async => false,
      child: new Scaffold(
          appBar: new AppBar(title: new Text("IC Fantasy Football"), backgroundColor: Colors.blueAccent),
          drawer: new Drawer(
            child: new ListView(
              children: <Widget>[
                new UserAccountsDrawerHeader(
                    accountEmail: new Text(User.get().username),
                    accountName: new Text(User.get().team.name),
                    currentAccountPicture: new Image(
                        image: new NetworkImage("https://union.ic.ac.uk/acc/football/fantasy/images/logo.png"),
                        fit: BoxFit.fill
                    ),
                    decoration: new BoxDecoration(
                        color: Colors.blueAccent
                    )
                ),
                new ListTile(
                    leading: new Icon(Icons.home),
                    title: new Text("My Team"),
                    onTap: () {
                      setState(() {
                        widgetForBody = TeamDisplayView();
                      });
                      Navigator.pop(context);
                    }
                ),
                new ListTile(
                    title: new Text("Teams"),
                    leading: new Icon(Icons.people),
                    onTap: () {
                      setState(() {
                        widgetForBody = TeamsDetailsView();
                      });
                      Navigator.pop(context);
                    }
                ),
                new ListTile(
                    title: new Text("Players"),
                    leading: new Icon(Icons.person),
                    onTap: () {
                      setState(() {
                        widgetForBody = PlayersDetailsView();
                      });
                      Navigator.pop(context);
                    }
                ),
                new ListTile(
                    title: new Text("LeaderBoards"),
                    leading: new Icon(Icons.format_list_numbered),
                    onTap: () {
                      setState(() {
                        widgetForBody = LeaderboardView();
                      });
                      Navigator.pop(context);
                    }
                ),
//    android:icon="@drawable/ic_web_asset"
//    android:icon="@drawable/ic_menu_share"
//    android:icon="@drawable/ic_exit_to_app"
//    android:icon="@drawable/ic_add"
//    android:icon="@drawable/ic_menu_send"
                new Divider(),
                new ListTile(
                  title: new Text("Log out"),
                  leading: new Icon(Icons.exit_to_app),
                  onTap: () {
                    User.get().clearUser();
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) {return LoginView();}));
      }
                  ,
                ),
                new ListTile(
                  title: new Text("Cancel"),
                  leading: new Icon(Icons.cancel),
                  onTap: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          body: widgetForBody
      ),
    );
  }
}


/*
 * Copyright 2018 Leszek Nowaczyk. All rights reserved.
 * If you get hold of this code you probably found it on github ;)
 */

import 'package:flutter/material.dart';
import 'package:ic_fantasy_football/model/player.dart';
import 'package:ic_fantasy_football/model/team_stats.dart';
import 'package:ic_fantasy_football/set_team_stats_buttoned_view.dart';

class SetTeamStatsView extends StatefulWidget {
  final Stat currentStat;

  SetTeamStatsView({
    Key key,
    Stat stat,
  })  : currentStat = (stat != null) ? stat : Stat.appearances,
        super(key: key) {
    if (currentStat == Stat.appearances || currentStat == null) {
      TeamStats.get().resetAll();
    }
  }

  @override
  _SetTeamStatsViewState createState() => _SetTeamStatsViewState();
}

class _SetTeamStatsViewState extends State<SetTeamStatsView> {
  bool _sortAsc = true;
  int _sortColumnIndex = 0;
  double _columnNameWidth = 60.0;
  double _columnWidth = 40;

  void _rebuild() {
    setState(() {
      // The animations changed, so we need to rebuild.
    });
  }

  PlayersDataSource _playersDataSource;
  int _rowsPerPage = 100;

  @override
  void initState() {
    super.initState();
    _playersDataSource = PlayersDataSource(widget.currentStat, _rebuild);
    _sort<String>((Player p) => p.firstName,
        _sortColumnIndex, _sortAsc);
  }

  void _sort<T>(
      Comparable<T> getField(Player p), int columnIndex, bool ascending) {
    _playersDataSource._sort<T>(getField, ascending);
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAsc = ascending;
    });
  }

  @override
  Widget build(BuildContext context) {
    TeamStats ts = TeamStats.get();
    return Scaffold(
        appBar: new AppBar(
            title: new Text(ts.statAsString(widget.currentStat)),
            backgroundColor: Colors.blueAccent),
        body: Builder(
            builder: (context) => Column(
                  children: <Widget>[
                    Expanded(
                      child: ListView(
                        children: <Widget>[
                          PaginatedDataTable(
                            horizontalMargin: 20.0,
                            columnSpacing: 30.0,
                            availableRowsPerPage: [50, 100, 200, 300],
                            rowsPerPage: _rowsPerPage,
                            onRowsPerPageChanged: (int value) {
                              setState(() {
                                _rowsPerPage = value;
                              });
                            },
                            sortColumnIndex: _sortColumnIndex,
                            sortAscending: _sortAsc,
                            header: Text(ts
                                .statAsString(widget.currentStat)),
                            columns: <DataColumn>[
                              new DataColumn(
                                  label: new Container(
                                      width: _columnNameWidth,
                                      child: Text(
                                        "First Name",
                                        softWrap: true,
                                      )),
                                  numeric: true,
                                  onSort: (int columnIndex, bool ascending) =>
                                      _sort<String>((Player p) => p.firstName,
                                          columnIndex, ascending)),
                              new DataColumn(
                                  label: new Container(
                                      width: _columnNameWidth,
                                      child: Text(
                                        "Last Name",
                                        softWrap: true,
                                      )),
                                  numeric: true,
                                  onSort: (int columnIndex, bool ascending) =>
                                      _sort<String>((Player p) => p.lastName,
                                          columnIndex, ascending)),
                              new DataColumn(
                                  label: new Container(
                                      width: _columnWidth,
                                      child: new Text("Team")),
                                  numeric: true,
                                  onSort: (int columnIndex, bool ascending) =>
                                      _sort<num>((Player p) => p.team,
                                          columnIndex, ascending))
                            ],
                            source: _playersDataSource,
                          )
                        ],
                      ),
                    ),
                    new MaterialButton(
                        height: 50.0,
                        minWidth: double.infinity,
                        color: Colors.blueAccent,
                        splashColor: Colors.teal,
                        textColor: Colors.white,
                        child: Text("Next"),
                        onPressed: () {
                          String message = "";

                          switch (widget.currentStat) {
                            case Stat.appearances:
                              if (ts
                                      .getStatCount(widget.currentStat) >
                                  11) {
                                message =
                                    "More than 11 players can't have started";
                              } else {
                                ts.setSubSelection();
                              }
                              break;
                            case Stat.subs:
                              if (ts
                                      .getStatCount(widget.currentStat) >
                                  5) {
                                message =
                                    "More than 5 players can't have been subbed in";
                              }
                              break;
                            case Stat.motm:
                              if (ts
                                      .getStatCount(widget.currentStat) !=
                                  1) {
                                message = "One player has to be MOTM";
                              }
                              break;
                            case Stat.yellowCards:
                              break;
                            case Stat.redCards:
                              break;
                            default:
                              message = "This state should not exist!!";
                          }

                          if (message != "") {
                            final snackBar = SnackBar(
                                content: Text(message),
                                duration: Duration(seconds: 2));
                            Scaffold.of(context).showSnackBar(snackBar);
                          } else {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (BuildContext context) {
                              Stat nextStat =
                                  ts.nextStat(widget.currentStat);
                              if (ts
                                  .isNextStatButtoned(widget.currentStat)) {
                                return TeamStatsButtoned(stat: nextStat);
                              } else {
                                return SetTeamStatsView(stat: nextStat);
                              }
                            }));
                          }
                        }),
                  ],
                )));
  }
}

class PlayersDataSource extends DataTableSource {
  Stat _currentStat;

  List<Player> _players;
  var _rebuild;

  double _columnWidth = 40.0;
  double _columnNameWidth = 60.0;

  PlayersDataSource(Stat stat, var fun)
      : _rebuild = fun,
        _currentStat = stat,
        _players = TeamStats.get().getAvailablePlayers(stat) {
  }

  void _sort<T>(Comparable<T> getField(Player p), bool ascending) {
    _players.sort((Player a, Player b) {
      if (!ascending) {
        final Player c = a;
        a = b;
        b = c;
      }
      final Comparable<T> aValue = getField(a);
      final Comparable<T> bValue = getField(b);
      return Comparable.compare(aValue, bValue);
    });
    notifyListeners();
  }

  DataCell getCell(String text) {
    return DataCell(Container(
        width: _columnWidth,
        child: Text(
          text,
          overflow: TextOverflow.fade,
          softWrap: false,
        )));
  }

  DataCell getNameCell(String text) {
    return DataCell(Container(
        width: _columnNameWidth,
        child: Text(
          text,
          overflow: TextOverflow.fade,
          softWrap: false,
        )));
  }

  @override
  DataRow getRow(int index) {
    TeamStats ts = TeamStats.get();
    assert(index >= 0);
    if (index >= _players.length) return null;
    final Player player = _players[index];

    return DataRow.byIndex(
        selected: ts.isPlayerSelected(player, _currentStat),
        onSelectChanged: (bool value) {
          if (ts.isPlayerSelected(player, _currentStat) != value) {
            if (!value) {
              ts.removePlayer(player, _currentStat);
            } else {
              ts.addPlayer(player, _currentStat);
            }
            notifyListeners();
          }
        },
        index: index,
        cells: <DataCell>[
          getNameCell(player.firstName),
          getNameCell(player.lastName),
          getCell(player.team.toString())
        ]);
  }

  @override
  int get rowCount => TeamStats.get().getAvailablePlayers(_currentStat).length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => TeamStats.get().getStatCount(_currentStat);
}

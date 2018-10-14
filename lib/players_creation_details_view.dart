/*
 * Copyright 2018 Leszek Nowaczyk. All rights reserved.
 * If you get hold of this code you probably found it on github ;)
 */

/*
 * Copyright 2018 Leszek Nowaczyk. All rights reserved.
 * If you get hold of this code you probably found it on github ;)
 */
import 'package:flutter/material.dart';
import 'package:ic_fantasy_football/controller/player_lab.dart';
import 'package:ic_fantasy_football/model/player.dart';
import 'package:ic_fantasy_football/create_team_view.dart';

class PlayersCreationDetailsView extends StatefulWidget {

  final List<Player> selectedPlayers;
  final int playerIndex;

  const PlayersCreationDetailsView ({
    Key key,
    @required this.selectedPlayers,
    @required this.playerIndex
  })  : super(key: key);

  @override
  _PlayersCreationDetailsViewState createState() => _PlayersCreationDetailsViewState();
}

class _PlayersCreationDetailsViewState extends State<PlayersCreationDetailsView> {
  bool _sortAsc = false;
  int _sortColumnIndex = 0;
  double _columnWidth  = 40.0;
  double _columnNameWidth  = 60.0;
  PlayersDataSource _playersDataSource;
  List<Player> _players;

  int _rowsPerPage = 20;

  void _sort<T>(Comparable<T> getField(Player p), int columnIndex, bool ascending) {
    _playersDataSource._sort<T>(getField, ascending);
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAsc = ascending ;
    });
  }

  @override
  void initState() {
    List<Player> players = PlayerLab.get().players;
    //filter out players by position
    if (widget.playerIndex < 2) {
      _players = List<Player>.from(players.where((player) => player.position=="GK"));
    } else if (widget.playerIndex < 7) {
      _players = List<Player>.from(players.where((player) => player.position=="DEF"));
    } else if (widget.playerIndex < 12) {
      _players = List<Player>.from(players.where((player) => player.position=="MID"));
    } else {
      _players = List<Player>.from(players.where((player) => player.position=="FWD"));
    }
    //filter out players who are already selected
    for (Player player in widget.selectedPlayers) {
      _players.remove(player);
    }
    _playersDataSource = PlayersDataSource(widget.playerIndex, widget.selectedPlayers, _players, context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: ListView(
          children: <Widget>[
            PaginatedDataTable(
              availableRowsPerPage: [10,20,50],
              rowsPerPage: _rowsPerPage,
              onRowsPerPageChanged: (int value) { setState(() { _rowsPerPage = value; }); },
              sortColumnIndex: _sortColumnIndex,
              sortAscending: _sortAsc,
              header: Text("Players"),
              columns: <DataColumn>[
                new DataColumn(
                    label: new Container(width: _columnNameWidth , child: Text("First Name", softWrap: true,)),
                    numeric: true,
                    onSort: (int columnIndex, bool ascending) => _sort<String>((Player p) => p.firstName, columnIndex, ascending)
                ),
                new DataColumn(
                    label: new Container(width: _columnNameWidth , child: Text("Last Name", softWrap: true,)),
                    numeric: true,
                    onSort: (int columnIndex, bool ascending) => _sort<String>((Player p) => p.lastName, columnIndex, ascending)
                ),
                new DataColumn(
                    label: new Container(width: _columnWidth , child: new Text("Position")),
                    numeric: true,
                    onSort: (int columnIndex, bool ascending) => _sort<String>((Player p) => p.position, columnIndex, ascending)
                ),
                new DataColumn(
                    label: new Container(width: _columnWidth , child: new Text("Price")),
                    numeric: true,
                    onSort: (int columnIndex, bool ascending) => _sort<num>((Player p) => p.price, columnIndex, ascending)
                ),
                new DataColumn(
                    label: new Container(width: _columnWidth , child: new Text("Fresher")),
                    numeric: true,
                    onSort: (int columnIndex, bool ascending) => _sort<String>((Player p) => p.isFresher.toString(), columnIndex, ascending)
                ),
                new DataColumn(
                    label: new Container(width: _columnWidth , child: new Text("Team")),
                    numeric: true,
                    onSort: (int columnIndex, bool ascending) => _sort<num>((Player p) => p.team, columnIndex, ascending)
                ),
                new DataColumn(
                    label: new Container(width: _columnWidth , child: new Text("Points")),
                    numeric: true,
                    onSort: (int columnIndex, bool ascending) => _sort<num>((Player p) => p.points, columnIndex, ascending)
                ),
                new DataColumn(
                    label: new Container(width: _columnWidth , child: new Text("Week Points")),
                    numeric: true,
                    onSort: (int columnIndex, bool ascending) => _sort<num>((Player p) => p.pointsWeek, columnIndex, ascending)
                ),
                new DataColumn(
                    label: new Container(width: _columnWidth , child: new Text("Apps")),
                    numeric: true,
                    onSort: (int columnIndex, bool ascending) => _sort<num>((Player p) => p.appearances, columnIndex, ascending)
                ),
                new DataColumn(
                    label: new Container(width: _columnWidth , child: new Text("Sub Apps")),
                    numeric: true,
                    onSort: (int columnIndex, bool ascending) => _sort<num>((Player p) => p.subAppearances, columnIndex, ascending)
                ),
                new DataColumn(
                    label: new Container(width: _columnWidth , child: new Text("Goals")),
                    numeric: true,
                    onSort: (int columnIndex, bool ascending) => _sort<num>((Player p) => p.goals, columnIndex, ascending)
                ),
                new DataColumn(
                    label: new Container(width: _columnWidth , child: new Text("Assists")),
                    numeric: true,
                    onSort: (int columnIndex, bool ascending) => _sort<num>((Player p) => p.assists, columnIndex, ascending)
                ),
                new DataColumn(
                    label: new Container(width: _columnWidth , child: new Text("CSs")),
                    numeric: true,
                    onSort: (int columnIndex, bool ascending) => _sort<num>((Player p) => p.cleanSheets, columnIndex, ascending)
                ),
                new DataColumn(
                    label: new Container(width: _columnWidth , child: new Text("MOTMs")),
                    numeric: true,
                    onSort: (int columnIndex, bool ascending) => _sort<num>((Player p) => p.motms, columnIndex, ascending)
                ),
                new DataColumn(
                    label: new Container(width: _columnWidth , child: new Text("Yellows")),
                    numeric: true,
                    onSort: (int columnIndex, bool ascending) => _sort<num>((Player p) => p.yellowCards, columnIndex, ascending)
                ),
                new DataColumn(
                    label: new Container(width: _columnWidth , child: new Text("Reds")),
                    numeric: true,
                    onSort: (int columnIndex, bool ascending) => _sort<num>((Player p) => p.redCards, columnIndex, ascending)
                ),
                new DataColumn(
                    label: new Container(width: _columnWidth , child: new Text("Own Goals")),
                    numeric: true,
                    onSort: (int columnIndex, bool ascending) => _sort<num>((Player p) => p.ownGoals, columnIndex, ascending)
                ),
              ],
              source: _playersDataSource,
            )
          ],
        )
      )
    );
  }
}

class PlayersDataSource extends DataTableSource {

  PlayersDataSource(this._playerIndex, this._selectedPlayers, this._players, this.context);

  int _playerIndex;
  List<Player> _players;
  List<Player> _selectedPlayers;

  int _selectedCount = 0;
  var context;
  double _columnWidth  = 40.0;
  double _columnNameWidth  = 60.0;

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
    return DataCell(Container(width: _columnWidth, child: Text(text, overflow: TextOverflow.fade, softWrap: false,)));
  }

  DataCell getNameCell(String text, bool isFresher) {
    if (isFresher)  return DataCell(Container(width: _columnNameWidth, child: Text(text, overflow: TextOverflow.fade, softWrap: false,style: TextStyle(decoration: TextDecoration.underline))));
    else return DataCell(Container(width: _columnNameWidth, child: Text(text, overflow: TextOverflow.fade, softWrap: false,)));
  }


  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= _players.length)
      return null;
    final Player player = _players[index];
    return DataRow.byIndex(
      onSelectChanged: (bool) {
        _players.removeAt(index);
        _selectedPlayers[_playerIndex] = player;
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) {return CreateTeamView(players: _players, selectedPlayers: _selectedPlayers,);}));
      },
        index: index,
        cells: <DataCell>[
          getNameCell(player.firstName, player.isFresher),
          getNameCell(player.lastName, player.isFresher),
          getCell(player.position),
          getCell('${player.price}'),
          getCell('${player.isFresher}'),
          getCell('${player.team}'),
          getCell('${player.points}'),
          getCell('${player.pointsWeek}'),
          getCell('${player.appearances}'),
          getCell('${player.subAppearances}'),
          getCell('${player.goals}'),
          getCell('${player.assists}'),
          getCell('${player.cleanSheets}'),
          getCell('${player.motms}'),
          getCell('${player.yellowCards}'),
          getCell('${player.redCards}'),
          getCell('${player.ownGoals}'),
        ]
    );
  }

  @override
  int get rowCount => _players.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;


}

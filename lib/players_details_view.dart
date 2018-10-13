/*
 * Copyright 2018 Leszek Nowaczyk. All rights reserved.
 * If you get hold of this code you probably found it on github ;)
 */
import 'package:flutter/material.dart';
import 'package:ic_fantasy_football/controller/player_lab.dart';
import 'package:ic_fantasy_football/model/player.dart';
import 'package:ic_fantasy_football/team_other_display_view.dart';

class PlayersDetailsView extends StatefulWidget {

  const PlayersDetailsView ({
    Key key,
  })  : super(key: key);

  @override
  _PlayersDetailsViewState createState() => _PlayersDetailsViewState();
}

class _PlayersDetailsViewState extends State<PlayersDetailsView> {
  bool _sortAsc = false;
  int _sortColumnIndex = 0;
  double _columnWidth  = 40.0;
  double _columnNameWidth  = 60.0;

  PlayersDataSource _playersDataSource = PlayersDataSource();
  int _rowsPerPage = 20;

  void _sort<T>(Comparable<T> getField(Player p), int columnIndex, bool ascending) {
    _playersDataSource._sort<T>(getField, ascending);
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAsc = ascending ;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              new DataColumn(
                  label: new Container(width: _columnWidth , child: new Text("Fresher")),
                  numeric: true,
                  onSort: (int columnIndex, bool ascending) => _sort<String>((Player p) => p.isFresher.toString(), columnIndex, ascending)
              ),
            ],
            source: _playersDataSource,
          )
        ],
      )
    );
  }
}

class PlayersDataSource extends DataTableSource {

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


  List<Player> _players = PlayerLab.get().players;

  int _selectedCount = 0;
  double _columnWidth  = 40.0;
  double _columnNameWidth  = 60.0;


  DataCell getCell(String text) {
    return DataCell(Container(width: _columnWidth, child: Text(text, overflow: TextOverflow.fade, softWrap: false,)));
  }

  DataCell getNameCell(String text) {
    return DataCell(Container(width: _columnNameWidth, child: Text(text, overflow: TextOverflow.fade, softWrap: false,)));
  }


  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= _players.length)
      return null;
    final Player player = _players[index];
    return DataRow.byIndex(
        index: index,
        cells: <DataCell>[
          getNameCell(player.firstName),
          getNameCell(player.lastName),
          getCell(player.position),
          getCell('${player.price}'),
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
          getCell('${player.isFresher}'),
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

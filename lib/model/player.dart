// Copyright 2018 Leszek Nowaczyk. All rights reserved.
// If you get hold of this code you probably found it on github ;)

class Player {

  int _playerID;
  String _firstName;
  String _lastName;
  String _position;
  int _team;
  double _price;
  int _points = 0;
  int _pointsWeek = 0;
  int _appearances = 0;
  int _subAppearances = 0;
  int _goals = 0;
  int _assists = 0;
  int _cleanSheets = 0;
  int _motms = 0;
  int _ownGoals = 0;
  int _redCards = 0;
  int _yellowCards = 0;
  bool _isFresher = false;
  String _image;

  Player(this._playerID, this._firstName, this._lastName, this._position,
      this._team, this._price, this._points, this._pointsWeek,
      this._appearances, this._subAppearances, this._goals, this._assists,
      this._cleanSheets, this._motms, this._ownGoals, this._redCards,
      this._yellowCards, this._isFresher) {

    if (_position == ("GK")) {
      this._image = "assets/goal.png";
    } else {
      this._image = "assets/shirt" + team.toString() + ".png";
    }

  }

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(int.parse(json['player_id']), json['first_name'], json['last_name'], json['position'], int.parse(json['team']), double.parse(json['price']),
        int.parse(json['points']), int.parse(json['points_week']), int.parse(json['appearances']), int.parse(json['sub_appearances']),
        int.parse(json['goals']), int.parse(json['assists']), int.parse(json['clean_sheets']), int.parse(json['motms']),
        int.parse(json['own_goals']), int.parse(json['red_cards']), int.parse(json['yellow_cards']), int.parse(json['is_fresher']) == 1,);
  }

  Player.empty() {
    this.image = "assets/shirt_blank.png";
    this.firstName = "first";
    this.lastName = "last";
  }

  String get image => _image;

  set image(String value) {
    _image = value;
  }

  bool get isFresher => _isFresher;

  set isFresher(bool value) {
    _isFresher = value;
  }

  int get yellowCards => _yellowCards;

  set yellowCards(int value) {
    _yellowCards = value;
  }

  int get redCards => _redCards;

  set redCards(int value) {
    _redCards = value;
  }

  int get ownGoals => _ownGoals;

  set ownGoals(int value) {
    _ownGoals = value;
  }

  int get motms => _motms;

  set motms(int value) {
    _motms = value;
  }

  int get cleanSheets => _cleanSheets;

  set cleanSheets(int value) {
    _cleanSheets = value;
  }

  int get assists => _assists;

  set assists(int value) {
    _assists = value;
  }

  int get goals => _goals;

  set goals(int value) {
    _goals = value;
  }

  int get subAppearances => _subAppearances;

  set subAppearances(int value) {
    _subAppearances = value;
  }

  int get appearances => _appearances;

  set appearances(int value) {
    _appearances = value;
  }

  int get pointsWeek => _pointsWeek;

  set pointsWeek(int value) {
    _pointsWeek = value;
  }

  int get points => _points;

  set points(int value) {
    _points = value;
  }

  double get price => _price;

  set price(double value) {
    _price = value;
  }

  int get team => _team;

  set team(int value) {
    _team = value;
  }

  String get position => _position;

  set position(String value) {
    _position = value;
  }

  String get lastName => _lastName;

  set lastName(String value) {
    _lastName = value;
  }

  String get firstName => _firstName;

  set firstName(String value) {
    _firstName = value;
  }

  int get playerID => _playerID;

  set playerID(int value) {
    _playerID = value;
  }




}
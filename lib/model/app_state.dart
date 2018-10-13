/*
 * Copyright 2018 Leszek Nowaczyk. All rights reserved.
 * If you get hold of this code you probably found it on github ;)
 */

class AppState{
    bool _isEditable;
    bool _isTransfer;
    String _nextEditable;
    String _saveBy;
    static AppState _sAppState;

    AppState(this._isEditable, this._isTransfer, this._nextEditable,
        this._saveBy);

    static AppState get() {
      if (_sAppState == null) {
        throw "User is null";
      }
      return _sAppState;
    }

    String get saveBy => _saveBy;

    String get nextEditable => _nextEditable;

    bool get isTransfer => _isTransfer;

    bool get isEditable => _isEditable;

    static void create(bool isEditable, bool isTransfer, String nextEditable, String saveBy) {
      if (_sAppState == null) {
        _sAppState   = new AppState(isEditable, isTransfer, nextEditable, saveBy);
      }
    }

    AppState.fromJson(Map<String, dynamic> json) {
      create(int.parse(json['is_editable']) == 1, int.parse(json['is_transfer']) == 1, json['next_editable'], json['save_by']);
    }

}
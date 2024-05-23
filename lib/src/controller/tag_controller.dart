import 'package:flutter/material.dart';

class TagController extends ChangeNotifier {
  int _selectedIndex = -1;
  int get selectedIndex => _selectedIndex;

  String _selectedtag = "All";
  String get selectedtag => _selectedtag;

  List _tagList = [];
  List get tagList => _tagList;

  void updateIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  void updateTagsindex(String tag) {
    _selectedtag = tag;
    notifyListeners();
  }
}

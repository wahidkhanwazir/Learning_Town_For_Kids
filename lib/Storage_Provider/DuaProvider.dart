import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DuaProvider with ChangeNotifier {
  List<String> duaList = [
    'Dua number 1',
    'Dua number 2',
    'Dua number 3',
    'Dua number 4',
    'Dua number 5',
    'Dua number 6',
    'Dua number 7',
    'Dua number 8',
    'Dua number 9',
    'Dua number 10',
  ];

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  DuaProvider() {
    _loadIndex();
  }

  Future<void> _loadIndex() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _currentIndex = prefs.getInt('currentDuaIndex') ?? 0;

    // Get today's date
    DateTime now = DateTime.now();
    DateTime todayDate = DateTime(now.year, now.month, now.day);

    int lastTimestamp = prefs.getInt('lastUpdateTimestamp') ?? 0;
    if (lastTimestamp > 0) {
      DateTime lastUpdate = DateTime.fromMillisecondsSinceEpoch(lastTimestamp);

      // Check if today is different from the last update date
      if (!isSameDay(todayDate, lastUpdate)) {
        _currentIndex = (_currentIndex + 1) % duaList.length;
        await _saveIndex(_currentIndex);
      }
    }

    _saveCurrentTime();
    notifyListeners();
  }

  Future<void> _saveCurrentTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('lastUpdateTimestamp', DateTime.now().millisecondsSinceEpoch);
  }

  Future<void> _saveIndex(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('currentDuaIndex', index);
    await prefs.setInt('lastUpdateTimestamp', DateTime.now().millisecondsSinceEpoch);
  }

  void checkForUpdate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int lastTimestamp = prefs.getInt('lastUpdateTimestamp') ?? 0;

    // Get today's date
    DateTime now = DateTime.now();
    DateTime todayDate = DateTime(now.year, now.month, now.day);

    if (lastTimestamp > 0) {
      DateTime lastUpdate = DateTime.fromMillisecondsSinceEpoch(lastTimestamp);

      // Check if today is different from the last update date
      if (!isSameDay(todayDate, lastUpdate)) {
        _currentIndex = (_currentIndex + 1) % duaList.length;
        await _saveIndex(_currentIndex);
        notifyListeners();
      }
    }
  }

  // Function to check if two DateTime objects represent the same day
  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year && date1.month == date2.month && date1.day == date2.day;
  }
}

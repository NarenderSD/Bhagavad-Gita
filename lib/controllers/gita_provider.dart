import 'dart:convert';
import 'package:bhagavad_gita/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GitaProvider extends ChangeNotifier {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  static List<Map<String, dynamic>> chaptersList = [];
  static List<Map<String, dynamic>> verseList = [];
  static List<Map<String, dynamic>> vTranslationList = [];
  static List<Map<String, dynamic>> commentaryList = [];
  static int selChapter = 0;
  static int selVerse = 1;
  static List<String> verseBookMark = [];

  Future<void> chaptersJson() async {
    String data = await rootBundle.loadString("assets/json/chapters.json");
    for (var e in json.decode(data)) {
      chaptersList.add(e);
    }
    notifyListeners();
  }

  Future<void> verseJson() async {
    String data = await rootBundle.loadString("assets/json/verse.json");
    for (var e in json.decode(data)) {
      verseList.add(e);
    }
  }

  Future<void> verseTranslationJson() async {
    String data = await rootBundle
        .loadString("assets/json/corrected_translation_gpt3.json");
    for (var e in json.decode(data)) {
      if (e['author_id'] == 1) {
        vTranslationList.add(e);
      }
    }
  }

  Future<void> commentaryJson() async {
    String data = await rootBundle.loadString("assets/json/commentary.json");
    for (var e in json.decode(data)) {
      if (e['author_id'] == 1) {
        commentaryList.add(e);
      }
    }
  }

  addBookMark(int verseNo) async {
    if (!verseBookMark.contains(verseNo.toString())) {
      verseBookMark.add(verseNo.toString());
      await _setStringList("VerseBookMark", verseBookMark);
    }
    myToast(msg: "Bookmark added successfully", bkgColor: Colors.blue);
    notifyListeners();
  }

  removeBookMark(int verseNo) async {
    if (verseBookMark.contains(verseNo.toString())) {
      verseBookMark.remove(verseNo.toString());
      await _setStringList("VerseBookMark", verseBookMark);
    }
    myToast(msg: "Bookmark removed successfully");
    notifyListeners();
  }

  Future<void> getBookMark() async {
    verseBookMark = await _getStringList("VerseBookMark");
    notifyListeners();
  }

  // retrieval of String List
  Future<List<String>> _getStringList(String key) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getStringList(key) ?? [];
  }

  // saving the String List
  Future<void> _setStringList(String key, List<String> value) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setStringList(key, value);
  }
}

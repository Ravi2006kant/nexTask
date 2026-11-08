import 'package:flutter/cupertino.dart';
import 'package:nextask/database/dbHelper.dart';
import 'package:provider/provider.dart';

class TaskProvider extends ChangeNotifier {
  List<Map<String, dynamic>> task = [];

  void trigger() {
    DbHelper.getInstance().fetchTask();
  }

  Future<void> loadData() async {

    final data = await DbHelper.getInstance().fetchTask();

    task = data;
    notifyListeners();
  }
}

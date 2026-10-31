import 'package:flutter/cupertino.dart';
import 'package:nextask/database/dbHelper.dart';
import 'package:provider/provider.dart';

class TaskProvider extends ChangeNotifier{
List task = [];

void trigger(){
  DbHelper.getInstance().fetchTask();
}

}
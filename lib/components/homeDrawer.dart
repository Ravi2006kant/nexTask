import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nextask/database/dbHelper.dart';
import 'package:nextask/taskProvider.dart';
import 'package:provider/provider.dart';

import '../theme/themeProvider.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          SizedBox(height: 75),
          Text(
            "Nex Task",
            style: TextStyle(
              fontSize: 20,
              color: Colors.amber,
              fontWeight: .bold,
            ),
          ),
          ListTile(
            leading: Text(
              "Dark Mode",
              style: TextStyle(fontWeight: .bold, fontSize: 14),
            ),
            trailing: CupertinoSwitch(
              thumbIcon: WidgetStatePropertyAll(
                Icon(
                  context.watch<ThemeProvider>().isdark
                      ? Icons.wb_sunny_outlined
                      : Icons.nightlight,
                  color: Colors.black,
                ),
              ),
              activeTrackColor: Colors.amber,
              value: context.watch<ThemeProvider>().isdark,
              onChanged: (value) async {
                final provider = context.read<ThemeProvider>();
                provider.trigger();
                await provider.saveTheme();
              },
            ),
          ),
          Divider(indent: 15, endIndent: 15),
          ListTile(
            leading: Text(
              "Clear Data",
              style: TextStyle(fontWeight: .bold, fontSize: 14),
            ),
            trailing: Container(
              decoration: BoxDecoration(
                color: Colors.red.withAlpha(50),
                borderRadius: BorderRadius.circular(50),
              ),
              child: CupertinoButton(
                child: Icon(Icons.delete, color: Colors.red, size: 25),
                onPressed: () {

                  DbHelper.getInstance().deleteAllData();
                  context.read<TaskProvider>().loadData();
                },
              ),
            ),
          ),
          Divider(indent: 15, endIndent: 15),
        ],
      ),
    );
  }
}

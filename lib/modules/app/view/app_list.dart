import 'package:flutter/material.dart';
import 'package:precomedio/components/app_listview.dart';

class AppList extends StatefulWidget {
  const AppList({Key? key}) : super(key: key);

  @override
  State<AppList> createState() => _AppListState();
}

class _AppListState extends State<AppList> {
  @override
  Widget build(BuildContext context) {
    return const AppListView();
  }
}

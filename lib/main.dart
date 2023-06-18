import 'package:syscraft_task/repository/local_db/db_service.dart';
import 'package:syscraft_task/src/my_app.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBService.instance.init();
  runApp(const MyApp());
}

import 'package:fashora_app/app.dart';
import 'package:fashora_app/app/service_locator/service_locator.dart';
import 'package:fashora_app/core/network/hive_service.dart';
import 'package:flutter/cupertino.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDependencies();

  // init Hive service
  await HiveService().int();

  // Delete database
  // await HiveService().clearAll();

  runApp(MyApp());
}
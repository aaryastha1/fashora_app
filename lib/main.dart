import 'package:fashora_app/app.dart';
import 'package:fashora_app/app/service_locator/service_locator.dart';
import 'package:flutter/widgets.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize dependencies and HiveService together
  await initDependencies();

  runApp(MyApp());
}
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart'; // <-- added
import 'package:testando_conhecimentos/src/models/service_hive_model.dart';
import 'package:testando_conhecimentos/src/views/addition_service_view.dart';
import 'package:testando_conhecimentos/src/views/homepage_view.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized(); 

  Hive.initFlutter();

  Hive.registerAdapter(ServiceAdapter());

  await Hive.openBox<Service>('services');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: HomepageView(),
      routes: {
        'addition/': (context) => AdditionServiceView(),
      }
    );
  }
}
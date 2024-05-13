import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'Home/Home_Page.dart';
import 'Storage_Provider/Storage_provider.dart';

Future<void> main() async {
  await GetStorage.init();
  runApp(ChangeNotifierProvider<StorageProvider>(
    create: (_) => StorageProvider(),
        child: const MyApp(),
     )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
          child: child!,
        );
      },
      home: const HomePage(),
    );
  }
}

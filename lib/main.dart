import 'package:flutter/material.dart';
import 'package:restep/common/constants/collors.dart';
import 'package:restep/presentation/screens/splash_screen/index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: ConstColors.grayBasic,
          useMaterial3: false,
        ),
        home: Builder(builder: (context) {
          return const SplashScreen();
        }),
      );
  }
}

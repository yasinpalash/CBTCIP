import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unitconverterapp/screens/home_screen.dart';

class UnitConverterApp extends StatelessWidget {
  const UnitConverterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
      theme: ThemeData(
        primaryColor: const Color(0xFF4CAF50),
        scaffoldBackgroundColor: Colors.white,
        textTheme: const TextTheme(
          bodySmall: TextStyle(
            color: Color(0xFF212121),
            fontSize: 18
          ),
        ),
        appBarTheme: const AppBarTheme(
          color: Colors.green,
        ),
        // elevatedButtonTheme: ElevatedButtonThemeData(
        //   style: ElevatedButton.styleFrom(
        //       shape: RoundedRectangleBorder(
        //         borderRadius: BorderRadius.circular(8),
        //       ),
        //       padding: const EdgeInsets.symmetric(vertical: 14),
        //       backgroundColor: const Color(0xFF4CAF50),
        //       textStyle: const TextStyle(fontSize: 16, letterSpacing: 0.5),
        //       foregroundColor: Colors.white),
        // )
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:unitconverterapp/widgets/length.dart';
import '../widgets/app_darwer.dart';
import '../widgets/from_and_to.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Convert Length",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            FromAndTo(),
            SizedBox(
              height: 20,
            ),
            LengthAction(),
          ],
        ),
      ),
    );
  }
}


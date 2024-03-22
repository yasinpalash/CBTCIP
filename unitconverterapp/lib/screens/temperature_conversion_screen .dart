import 'package:flutter/material.dart';
import 'package:unitconverterapp/widgets/app_darwer.dart';
import 'package:unitconverterapp/widgets/from_and_to.dart';

import '../widgets/temperature_logic.dart';

class TemperatureConversionScreen extends StatelessWidget {
  const TemperatureConversionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Convert Temperature",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FromAndTo(),
            SizedBox(
              height: 10,
            ),
            TemperatureLogic(),
          ],
        ),
      ),
    );
  }
}

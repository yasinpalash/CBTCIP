import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unitconverterapp/screens/temperature_conversion_screen%20.dart';
import '../screens/home_screen.dart';
import 'app_bar_drawer.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const AppDrawerBar(),
          const SizedBox(
            height: 14,
          ),
          ListTile(
            onTap: () {
              Get.to(const HomeScreen());
            },
            leading: const Icon(
              Icons.linear_scale,
              color: Color(0xFF212121),
            ),
            title: const Text(
              'Length',
              style: TextStyle(fontSize: 20),
            ),
          ),
          ListTile(
            onTap: () {
              Get.to(const TemperatureConversionScreen());
            },
            leading: const Icon(
              Icons.thermostat_outlined,
              color: Color(0xFF212121),
            ),
            title: const Text(
              'Temperature',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}

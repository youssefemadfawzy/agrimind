import 'package:flutter/material.dart';
import 'package:agrimind/features/home/presentation/widgets/header.dart';
import 'package:agrimind/features/home/presentation/widgets/plant_fish_siwtch.dart';
import 'package:agrimind/features/home/presentation/widgets/CustomBottomNavBar.dart';
import 'package:agrimind/features/home/presentation/widgets/fish_screen.dart';
import 'package:agrimind/features/home/presentation/widgets/plant_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isPlantSelected = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            /// 🔥 Header ثابت
            const Header(),

            const SizedBox(height: 10),

            /// 🔁 Switch
            PlantFishSiwtch(
              isPlantSelected: isPlantSelected,
              onChanged: (value) {
                setState(() {
                  isPlantSelected = value;
                });
              },
            ),

            const SizedBox(height: 10),

            /// 📦 المحتوى المتغير
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: isPlantSelected
                    ? const PlantScreen(key: ValueKey('plant'))
                    : const FishScreen(key: ValueKey('fish')),
              ),
            ),
          ],
        ),
      ),

      /// 🔻 BottomNav ثابت
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}
import 'package:agrimind/core/widgets/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({super.key});

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  int currentIndex = 0; // 👈 ده اللي بيتغير

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(

      currentIndex: currentIndex,

      onTap: (index) {
        setState(() {
          currentIndex = index; // 👈 يحدث لما تدوس
        });
      },

      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,

      items: [
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            AppIcons.Homeicon,
            color: currentIndex == 0 ? Colors.blue : Colors.grey,
          ),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            AppIcons.dataicon,
            color: currentIndex == 1 ? Colors.blue : Colors.grey,
          ),
          label: "Data",
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            AppIcons.settingsicon,
            color: currentIndex == 2 ? Colors.blue : Colors.grey,
          ),
          label: "Control",
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            AppIcons.assestanticon,
            color: currentIndex == 3 ? Colors.blue : Colors.grey,
          ),
          label: "Assistant",
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            AppIcons.moreicon,
            color: currentIndex == 4 ? Colors.blue : Colors.grey,
          ),
          label: "More",
        ),
      ],
    );
  }
}
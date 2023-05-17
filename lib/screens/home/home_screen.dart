import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_gym_book/screens/party/party_screen.dart';
import 'package:my_gym_book/screens/workouts/workout_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Widget> _screens = [
    const WorkoutScreen(),
    const PartyScreen()
  ];

  var _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Gym Book"),
        centerTitle: true,
      ),
      backgroundColor: const Color.fromRGBO(18, 20, 29, 1),
      body: Center(
          child: _screens[_selectedIndex]
      ),
      bottomNavigationBar: FlashyTabBar(
        animationCurve: Curves.linear,
        selectedIndex: _selectedIndex,
        showElevation: true,
        onItemSelected: (index) => setState(() {
          _selectedIndex = index;
        }),
        items: [
          FlashyTabBarItem(
            icon: const Icon(FontAwesomeIcons.dumbbell),
            title: const Text(
              'Treinos',
              style: TextStyle(
                  fontSize: 13
              ),
            ),
          ),
          FlashyTabBarItem(
            icon: const Icon(Icons.group),
            title: const Text(
              'Party',
              style: TextStyle(
                  fontSize: 13
              ),
            ),
          ),
        ],
      ),
    );
  }
}
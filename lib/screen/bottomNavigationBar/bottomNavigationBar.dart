import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../app/theme/color_resource.dart';
import '../directory/ui/directoryScreen.dart';
import '../events/ui/eventScreen.dart';

import '../homeScreen/ui/homeScreen.dart';
import '../leadership/ui/leadershipScreen.dart';
import 'bloc/bottom_nav_bloc.dart';
import 'bloc/bottom_nav_event.dart';
import 'bloc/bottom_nav_state.dart';


class MainBottomNavScreen extends StatelessWidget {
  const MainBottomNavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screens = const [
      HomeScreen(),
      DirectoryScreen(),
      LeadershipScreen(),
      EventScreen(),
    ];

    return BlocProvider(
      create: (_) => BottomNavBloc(),
      child: BlocBuilder<BottomNavBloc, BottomNavState>(
        builder: (context, state) {
          return Scaffold(
            body: screens[state.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: state.currentIndex,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: ColorResource.primaryColor,
              unselectedItemColor: Colors.grey,
              onTap: (index) {
                context.read<BottomNavBloc>().add(ChangeTabEvent(index));
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.book),
                  label: 'Directory',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.lan),
                  label: 'Leadership',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.event),
                  label: 'Events',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
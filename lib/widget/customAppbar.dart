import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../app/theme/color_resource.dart';
import '../screen/bottomNavigationBar/bloc/bottom_nav_bloc.dart';
import '../screen/bottomNavigationBar/bloc/bottom_nav_event.dart';
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final bool isHome; // 🔥 Add this

  const CustomAppBar({
    super.key,
    required this.title,
    this.showBackButton = true,
    this.isHome = false, // default false
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      backgroundColor: Colors.transparent,
      clipBehavior: Clip.antiAlias,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(0.00, 0.50),
            end: Alignment(1.00, 0.50),
            colors: [Color(0xFF2E5FC0), Color(0xFF042C7A)],
          ),
        ),
      ),
      leading: showBackButton
          ? IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () {
          if (isHome) {
            context.read<BottomNavBloc>().add(const ChangeTabEvent(0));
          } else {
            Navigator.pop(context);
          }
        },
      )
          : const SizedBox(),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
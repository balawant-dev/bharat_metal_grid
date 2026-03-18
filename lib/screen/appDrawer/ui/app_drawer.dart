import 'package:bharat_metal_grid/app/router/app_router.dart';
import 'package:flutter/material.dart';

import '../../../app/router/navigation/nav.dart';
import '../../../app/router/navigation/routes.dart';
import '../../../app/theme/color_resource.dart';
import '../../../core/constants/api_constants.dart';
import '../../../core/services/secure_storage_service.dart';
import '../../settings/appSettings/appSettings.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  Color getProgressColor(double value) {
    if (value < 0.5) {
      return Colors.redAccent;
    } else if (value < 0.8) {
      return Colors.orangeAccent;
    } else {
      return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    print("🤷‍♀️🤷‍♀️🤷‍♀️${AppSettings.profileCompletionPercentage}");
    final double rawPercent =
        double.tryParse(AppSettings.profileCompletionPercentage ?? "0") ?? 0;

    final double percent = rawPercent.clamp(0, 100) / 100;
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            // ─── Header ─────────────────────────────
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(
                top: 50,
                bottom: 20,
              ),
              decoration: const ShapeDecoration(
                gradient: LinearGradient(
                  begin: Alignment(-0.00, 0.50),
                  end: Alignment(1.00, 0.50),
                  colors: [Color(0xFF2D5FC0), Color(0xFF062E7E)],
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(90),
                  ),
                ),
              ),
              child: Column(
                children:  [
                CircularPercentIndicator(
                radius: 52.0,
                lineWidth: 8.0,
                animation: true,
                animationDuration: 800,
                percent: percent,
                circularStrokeCap: CircularStrokeCap.round,
                backgroundColor: Colors.white.withOpacity(0.2),
                progressColor: getProgressColor(percent),
        
                center: Stack(
                  alignment: Alignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.network(
                        "${ApiConstants.baseUrl}${AppSettings.userProfileImage}",
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            "assets/icon/profileAvatar.png",
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
        
                    /// Optional percentage text overlay (top-right style)
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: getProgressColor(percent),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          "${rawPercent.toInt()}%",
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
                  // Container(
                  //   height: 75,
                  //   width: 75,
                  //   decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(100)
                  //   ),
                  //   child: ClipRRect(
                  //     borderRadius: BorderRadius.circular(100),
                  //     child: Image.network("${ApiConstants.baseUrl}${AppSettings.userProfileImage}", fit: BoxFit.fill,height: 55,errorBuilder: (context, error, stackTrace) {
                  //       return  Image.asset(
                  //         "assets/icon/profileAvatar.png",
                  //         height: 55,
                  //         fit: BoxFit.fill,
                  //         //       color: Colors.white,
                  //       );
                  //     },),
                  //   ),
                  // ),
                  SizedBox(height: 10),
                  Text(
                      "${AppSettings.userName}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "${AppSettings.userEmail}",
                    style: TextStyle(color: Colors.white70),
                  ),
                  SizedBox(height: 2),
                  Text(
                    "+91 ${AppSettings.userPhone}",
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
        
            // ─── Menu Items ─────────────────────────
            _drawerItem(
              icon: Icons.person_outline,
              title: "Profile",
              onTap: ()async {
            //    final token = await SecureStorageService.getToken();
                final userType = await SecureStorageService.getUserType();
        
        
        
                if (userType =="Association") {
        
                  print("UserType >>>>>>>>$userType");
                  Nav.push(
                    context,
                    Routes.profileAssociation,
                    //extra: widget.isAgent,
                  );
        
        
                  return;
                }else if(userType =="Member"){
                 Nav.push(context, Routes.profileMember);
        
                }
                //ProfileAssociationScreen
        
                // Nav.push(context, AppRouter.);
        
           //     Navigator.pop(context);
                // Navigator.push(...)
              },
            ),
            _drawerItem(
              icon:  Icons.card_membership,
              title: "Membership",
              onTap: () {

           //     Nav.push(context, Routes.memberShip);
           Nav.push(context, Routes.membershipAssignment);
              },
            ),
            _drawerItem(
              icon:  Icons.auto_awesome_outlined,
              title: "AI Agent",
              onTap: () {
                Nav.push(context, Routes.gemini);
              },
            ),    _drawerItem(
              icon:  Icons.pages,
              title: "Post",
              onTap: () {
                Nav.push(context, Routes.post);
              },
            ),
            _drawerItem(
              icon: Icons.lock_outline,
              title: "Privacy Policy",
              onTap: () {
                Nav.push(context, Routes.privacy2);
              },
            ),

            _drawerItem(
              icon: Icons.description_outlined,
              title: "Terms & Conditions",
              onTap: () {
                Nav.push(context, Routes.terms2);
              },
            ),

            _drawerItem(
              icon: Icons.description_outlined,
              title: "Refund Policy",
              onTap: () {
                Nav.push(context, Routes.refund2);
              },
            ),
            _drawerItem(
              icon: Icons.support_agent,
              title: "Complaint & Support",
              onTap: () {
                Nav.push(context, Routes.complaintSupport);
              },
            ),
            // const Spacer(),
            const Divider(),
        
            _drawerItem(
              icon: Icons.logout,
              title: "Logout",
              iconColor: Colors.red,
              textColor: Colors.red,
              onTap: () {
                _handleLogout(context);
             //   Navigator.pop(context);
                // logout logic
              },
        
            ),  const Text("Version 1.0.0",style: TextStyle(fontSize: 12,color: ColorResource.grey),),SizedBox(height: 10,)
          ],
        ),
      ),
    );
  }

  Future<void> _handleLogout(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text('Confirm Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              AppSettings.clearUserType();
              SecureStorageService.logout(context);
              Navigator.pop(context, true);
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );

    if (result ?? false) {
      SecureStorageService.logout(context);
    }
  }

  Widget _drawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color iconColor = Colors.black,
    Color textColor = Colors.black,
  }) {
    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(
        title,
        style: TextStyle(color: textColor),
      ),
      onTap: onTap,
    );
  }
}

import 'package:amsafe/components/my_drawer_tile.dart';
import 'package:amsafe/controller/auth_controller.dart';
import 'package:amsafe/main.dart';
import 'package:amsafe/pages/contact_page.dart';
import 'package:amsafe/pages/menu_page.dart';
import 'package:amsafe/services/auth/auth_gate.dart';
import 'package:amsafe/utils/sized_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  //! Logout method
  void logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');
    Get.find<AuthController>().user.value = null;
    Get.offAll(() => AuthGate());
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).lightWhiteText,
      child: Column(
        children: [
          // //! app logo
          Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: Text(
              "AmSafe",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 4.h,
                color: Theme.of(context).mainColor,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Divider(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          //! home list tile
          MyDrawerTile(
            text: "H O M E",
            icon: Icons.home,
            onTap: () {
              Navigator.pop(context);
              Get.offAll(
                () => MenuPage(),
              );
            },
          ),
          //! profile list tile
          MyDrawerTile(
            text: "P R O F I L E",
            icon: Icons.person,
            onTap: () {
              Navigator.pop(context);
              Get.offAll(
                () => MenuPage(),
              );
            },
          ),
          //! about list tile
          MyDrawerTile(
            text: "A B O U T",
            icon: Icons.info_outline,
            onTap: () {
              Navigator.pop(context);
            },
          ),
          //! contact us
          MyDrawerTile(
            text: "C O N T A C T",
            icon: Icons.contact_mail,
            onTap: () {
              Get.to(
                () => ContactPage(
                  onContactsSelected: (p0) {},
                ),
              );
            },
          ),
          Spacer(),
          //! logout list tile
          MyDrawerTile(
            text: "L O G O U T",
            icon: Icons.settings,
            onTap: () {
              logout();
            },
          ),
          sizedBoxHeight20,
        ],
      ),
    );
  }
}

import 'package:amsafe/components/my_drawer_tile.dart';
import 'package:amsafe/controller/auth_controller.dart';
import 'package:amsafe/main.dart';
import 'package:amsafe/pages/chat_page.dart';
import 'package:amsafe/pages/contact_page.dart';
import 'package:amsafe/pages/menu_page.dart';
import 'package:amsafe/pages/settings_page.dart';
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
              Get.to(
                () => MenuPage(),
              );
            },
          ),
          //! profile list tile
          MyDrawerTile(
            text: "C H A T",
            icon: Icons.chat,
            onTap: () {
              Get.to(
                () => ChatPage(),
              );
            },
          ),
          //! contact us
          MyDrawerTile(
            text: "C O N T A C T",
            icon: Icons.phone,
            onTap: () {
              Get.to(
                () => ContactPage(
                  onContactsSelected: (p0) {},
                ),
              );
            },
          ),
          //! about list tile
          MyDrawerTile(
            text: "S E T T I N G S",
            icon: Icons.settings,
            onTap: () {
              Get.to(
                () => SettingsPage(),
              );
            },
          ),

          Spacer(),
          //! logout list tile
          MyDrawerTile(
            text: "L O G O U T",
            icon: Icons.settings,
            onTap: () {
              // logout();
            },
          ),
          sizedBoxHeight20,
        ],
      ),
    );
  }
}

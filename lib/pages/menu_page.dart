import 'package:amsafe/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:amsafe/pages/chat_page.dart';
import 'package:amsafe/pages/contact_page.dart';
import 'package:amsafe/pages/home_page.dart';
import 'package:amsafe/pages/settings_page.dart';
import 'package:amsafe/components/my_bottom_nav.dart';
import 'package:amsafe/widget/app_drawer.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  int selectedIndex = 0;
  List<Contact> selectedContacts = [];

  void navigateBottomBar(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void updateSelectedContacts(List<Contact> contacts) {
    setState(() {
      selectedContacts = contacts;
      pages[0] = HomePage(selectedContacts: selectedContacts);
    });
  }

  final List<Widget> pages = [];

  @override
  void initState() {
    super.initState();
    pages.addAll([
      HomePage(selectedContacts: selectedContacts),
      ChatPage(),
      ContactPage(onContactsSelected: updateSelectedContacts),
      SettingsPage(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text(
          "AmSafe",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).mainColor,
          ),
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu_outlined),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              color: Colors.black,
            );
          },
        ),
      ),
      drawer: AppDrawer(),
      body: pages[selectedIndex],
      bottomNavigationBar: MyBottomNav(
        onTabChanges: navigateBottomBar,
      ),
    );
  }
}

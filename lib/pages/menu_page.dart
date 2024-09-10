import 'package:amsafe/components/my_bottom_nav.dart';
import 'package:amsafe/pages/chat_page.dart';
import 'package:amsafe/pages/contact_page.dart';
import 'package:amsafe/pages/home_page.dart';
import 'package:amsafe/pages/settings_page.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';

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
      // Rebuild HomePage with updated contacts
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
      ContactPage(
        onContactsSelected: updateSelectedContacts,
      ),
      SettingsPage(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: MyBottomNav(
        onTabChanges: (index) => navigateBottomBar(index),
      ),
    );
  }
}

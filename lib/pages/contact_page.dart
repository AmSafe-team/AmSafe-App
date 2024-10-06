import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:permission_handler/permission_handler.dart';

class ContactPage extends StatefulWidget {
  final Function(List<Contact>) onContactsSelected;

  const ContactPage({Key? key, required this.onContactsSelected})
      : super(key: key);

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  List<Contact> contacts = [];
  List<Contact> selectedContacts = [];
  final box = GetStorage();

  @override
  void initState() {
    super.initState();
    _loadContacts();
  }

  Future<void> _loadContacts() async {
    if (await Permission.contacts.request().isGranted) {
      final contactList =
          await FlutterContacts.getContacts(withProperties: true);
      setState(() {
        contacts = contactList;
      });

      //! Load saved selected contacts
      List<String>? savedContacts = box.read<List<String>>('selectedContacts');
      if (savedContacts != null) {
        selectedContacts = contacts.where((contact) {
          return savedContacts.contains(contact.id);
        }).toList();
      }
    }
  }

  void _saveSelectedContacts() {
    List<String> contactIds = selectedContacts.map((c) => c.id).toList();
    box.write('selectedContacts', contactIds); // Save selected contact IDs
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Contacts'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              if (selectedContacts.isNotEmpty) {
                widget.onContactsSelected(selectedContacts);
                _saveSelectedContacts(); // Save contacts when selected
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Contacts selected successfully!')),
                );
                Get.back();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('No contacts selected')),
                );
              }
            },
          )
        ],
      ),
      body: contacts.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                Contact contact = contacts[index];
                return ListTile(
                  title: Text(contact.displayName),
                  trailing: Checkbox(
                    value: selectedContacts.contains(contact),
                    onChanged: (bool? selected) {
                      setState(() {
                        if (selected == true) {
                          selectedContacts.add(contact);
                        } else {
                          selectedContacts.remove(contact);
                        }
                      });
                    },
                  ),
                );
              },
            ),
    );
  }
}

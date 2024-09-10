import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

  @override
  void initState() {
    super.initState();
    _loadContacts();
  }

  Future<void> _loadContacts() async {
    if (await Permission.contacts.request().isGranted) {
      final contactList = await ContactsService.getContacts();
      setState(() {
        contacts = contactList.toList();
      });
    }
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
                widget.onContactsSelected(
                    selectedContacts); // Pass selected contacts back
                // Show feedback and navigate back to the previous page
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Contacts selected successfully!')),
                );
                Get.back();
              } else {
                // Show feedback for empty selection
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
                  title: Text(contact.displayName ?? 'Unknown'),
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

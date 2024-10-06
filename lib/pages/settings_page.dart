import 'package:amsafe/main.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final box = GetStorage();
  bool isShakeEnabled = false;

  @override
  void initState() {
    super.initState();
    isShakeEnabled = box.read('shakeEnabled') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    String? encodeQueryParameters(Map<String, String> params) {
      return params.entries
          .map((MapEntry<String, String> e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
          .join('&');
    }

    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'anishhazra108@gmail.com',
      query: encodeQueryParameters(<String, String>{
        'subject': 'Please write your message',
      }),
    );
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(2.h),
        child: Column(
          children: [
            //! toggle switch
            SwitchListTile(
              activeColor: Theme.of(context).mainColor,
              title: Text('Enable Shake to SOS'),
              value: isShakeEnabled,
              onChanged: (value) {
                setState(() {
                  isShakeEnabled = value;
                  //! Save the toggle state
                  box.write('shakeEnabled', value);
                });
              },
            ),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    leading: Icon(Icons.star, color: Colors.black),
                    title: Text('Star'),
                    trailing: Icon(Icons.chevron_right),
                    onTap: () {
                      final websiteUri = Uri.parse(
                        'https://github.com/AmSafe-team/AmSafe-App',
                      );
                      launchUrl(
                        websiteUri,
                        mode: LaunchMode.externalApplication,
                      );
                    },
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.share, color: Colors.black),
                    title: Text('Share'),
                    trailing: Icon(Icons.chevron_right),
                    onTap: () {
                      final websiteUri = Uri.parse(
                        'https://drive.google.com/drive/folders/1HzzRbzGXWcVHKHhTKhkQOQdxcnxK1xPa?usp=sharing',
                      );
                      launchUrl(
                        websiteUri,
                        mode: LaunchMode.externalApplication,
                      );
                    },
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.apps, color: Colors.black),
                    title: Text('Devfolio'),
                    trailing: Icon(Icons.chevron_right),
                    onTap: () {
                      final websiteUri = Uri.parse(
                        'https://devfolio.co/projects/amsafe-9c9f',
                      );
                      launchUrl(
                        websiteUri,
                        mode: LaunchMode.externalApplication,
                      );
                    },
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.feedback, color: Colors.black),
                    title: Text('Give Feedback'),
                    trailing: Icon(Icons.chevron_right),
                    onTap: () {
                      launchUrl(emailLaunchUri);
                    },
                  ),
                  Divider(),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Developed by Team Minions'),
                SizedBox(width: 2),
                Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

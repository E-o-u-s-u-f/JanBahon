import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class settingsScreen extends StatefulWidget {
  //final bool darkModeEnabled;
  //final ValueChanged<bool> onDarkModeChanged;

  settingsScreen({
    // required this.darkModeEnabled,
    // required this.onDarkModeChanged,
    super.key
  });

  @override
  settingsScreenState createState() => settingsScreenState();
}

class settingsScreenState extends State<settingsScreen> {
  bool notificationEnabled = false;
  String preferredLanguage = 'English';

  @override
  void initState() {
    super.initState();
    loadSettings();
  }

  loadSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      notificationEnabled = prefs.getBool('notifications') ?? false;
      preferredLanguage = prefs.getString('preferredLanguage') ?? 'English';
    });
  }

  updateNotificationSetting(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      notificationEnabled = value;
      prefs.setBool('notifications', value);
    });
  }

  updateLanguageSetting(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      preferredLanguage = value;
      prefs.setString('preferredLanguage', value);
    });
  }

  @override
  Widget build(BuildContext context) {
    bool darkModeEnabled=false ;

    return Container(
        decoration:BoxDecoration(
        gradient:LinearGradient(begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.white,Colors.indigo] )),
    child:
    Scaffold(
    backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: Text('Enable Notifications'),
            value: notificationEnabled,
            onChanged: (bool value) {
              updateNotificationSetting(value);
            },
          ),
          // SwitchListTile(
          //  title: Text('Enable Dark Mode'),
          // value: widget.darkModeEnabled,
          //onChanged: (bool value) {
          // widget.onDarkModeChanged(value); // Notify parent widget (homeS)
          // },
          // ),
          ListTile(
            title: Text('Preferred Language'),
            subtitle: Text(preferredLanguage),
            onTap: () async {
              String? selectedLanguage = await showDialog<String>(
                context: context,
                builder: (BuildContext context) {
                  return SimpleDialog(
                    title: Text('Select Language'),
                    children: <Widget>[
                      SimpleDialogOption(
                        onPressed: () {
                          Navigator.pop(context, 'English');
                        },
                        child: Text('English'),
                      ),
                      SimpleDialogOption(
                        onPressed: () {
                          Navigator.pop(context, 'Spanish');
                        },
                        child: Text('Spanish'),
                      ),
                      SimpleDialogOption(
                        onPressed: () {
                          Navigator.pop(context, 'French');
                        },
                        child: Text('French'),
                      ),
                    ],
                  );
                },
              );
              if (selectedLanguage != null) {
                updateLanguageSetting(selectedLanguage);
              }
            },
          ),
        ],
      ),
    ));
  }
}


import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  //final bool darkModeEnabled;
  //final ValueChanged<bool> onDarkModeChanged;

  HelpPage({
    //required this.darkModeEnabled,
    // required this.onDarkModeChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    bool darkModeEnabled= false;
    return Container(
        decoration:BoxDecoration(
            gradient:LinearGradient(begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.white,Colors.indigo] )),
        child:
        Scaffold(
          backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text('Help'),
        backgroundColor: darkModeEnabled ? Colors.grey[900] : Colors.blueAccent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        color: darkModeEnabled ? Colors.black : Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.0),
            Text(
              'How to Use the App',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: darkModeEnabled ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Step 1: Open the app and log in with your credentials.',
              style: TextStyle(
                fontSize: 18.0,
                color: darkModeEnabled ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Step 2: Navigate through the app using the bottom navigation bar.',
              style: TextStyle(
                fontSize: 18.0,
                color: darkModeEnabled ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Step 3: Navigate through the vehicle icons and choose your desired ticket.',
              style: TextStyle(
                fontSize: 18.0,
                color: darkModeEnabled ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Step 4: Otherwise, find your desired ticket through the filter icon.',
              style: TextStyle(
                fontSize: 18.0,
                color: darkModeEnabled ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Step 5: Then, choose the desired number of seats and your digital payment method',
              style: TextStyle(
                fontSize: 18.0,
                color: darkModeEnabled ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Step 6: To access settings, tap on the menu icon and select "Settings".',
              style: TextStyle(
                fontSize: 18.0,
                color: darkModeEnabled ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Step 7: For help or support, tap on the menu icon and select "Help".',
              style: TextStyle(
                fontSize: 18.0,
                color: darkModeEnabled ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Step 8: For help or support, tap on the menu icon and select "Help".',
              style: TextStyle(
                fontSize: 18.0,
                color: darkModeEnabled ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'If you have any other questions, tap on the menu icon and select "Contact".',
              style: TextStyle(
                fontSize: 18.0,
                color: darkModeEnabled ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

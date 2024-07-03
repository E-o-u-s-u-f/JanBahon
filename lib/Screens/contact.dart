import 'package:flutter/material.dart';

class ContactPage extends StatelessWidget {
  final bool darkModeEnabled;
  final ValueChanged<bool> onDarkModeChanged;

  ContactPage({
    required this.darkModeEnabled,
    required this.onDarkModeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact'),
        backgroundColor: darkModeEnabled ? Colors.grey[900] : Colors.blueAccent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ContactCard(
                imageUrl: 'assets/santoPic.jpg',
                name: 'Asifuzzaman Shanto',
                phone: '01827384956',
                email: 'asif_santo@gmail.com',
                darkModeEnabled: darkModeEnabled,
              ),
              SizedBox(width: 20.0),
              ContactCard(
                imageUrl: 'assets/israt_Pic.jpg',
                name: 'Israt Jahan Eshita',
                phone: '01914121110',
                email: 'israt_jahan@gmail.com',
                darkModeEnabled: darkModeEnabled,
              ),
              SizedBox(width: 20.0),
              ContactCard(
                imageUrl: 'assets/eousufPic.jpg',
                name: 'Eousuf Abdullah',
                phone: '01518171614',
                email: 'eousuf_abd@gmail.com',
                darkModeEnabled: darkModeEnabled,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ContactCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String phone;
  final String email;
  final bool darkModeEnabled;


  ContactCard({
    required this.imageUrl,
    required this.name,
    required this.phone,
    required this.email,
    required this.darkModeEnabled,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.all(20.0),
      height: 650.0,
      width: screenWidth - 44.0,
      decoration: BoxDecoration(
        color: darkModeEnabled ? Colors.grey[800] : Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: darkModeEnabled ? Colors.black : Colors.white,
          width: 2.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
            child: Image.asset(
              imageUrl,
              width: screenWidth - 24.0,
              height: 320.0,
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                name,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Center(child: Text(phone,
              style: TextStyle(
                fontSize: 15.0,
                  ),
               ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: Text(email,
              style: TextStyle(
                fontSize: 15.0,
              ),
            )),
          ),
        ],
      ),
    );
  }
}

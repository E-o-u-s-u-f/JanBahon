import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:jan_bahon/HomePage/bus_seat_selection.dart';
import '../Screens/log_in.dart';

import 'package:jan_bahon/HomePage/lib/trainOption.dart';
import 'package:jan_bahon/Seat&BuyTicket/bus_seat_selection.dart';
import 'BusOptions.dart';

import 'filter.dart';
import 'lib/Screens/log_in.dart';
import 'lib/Seat&BuyTicket/bus_seat_selection.dart';

class homeS extends StatefulWidget {
  const homeS({super.key});

  @override
  State<homeS> createState() => _State();
}

class _State extends State<homeS> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _controller=TextEditingController(text: 'Filter');


  Color  textB1=Colors.cyan;
  Color textB2=Colors.pinkAccent;
  Color  textB3=Colors.orangeAccent;
  Color containerCol=Colors.cyan;
  Color containerCol2=Colors.pinkAccent;
  Color containerCol3=Colors.orangeAccent;
  int _selectedIndex=0;
  int selInd=0;
  String _imageUrl = 'https://images.unsplash.com/photo-1570125909517-53cb21c89ff2?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D';


  void changeColor(){
    setState(() {
      if(containerCol==textB1) {
        containerCol == Colors.white ? Colors.cyan : Colors.white;
      }else if(containerCol2==textB2){
        containerCol2== Colors.white ? Colors.pinkAccent : Colors.white;
      }else{
        containerCol3 == Colors.white ? Colors.orangeAccent : Colors.white;
      }
    });
  }
  static List<Widget> _widgetOptions = <Widget>[
    homeS(),
    //MapS(),
   // QrCode(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  void _onIconTapped(int index) {
    setState(() {
      selInd = index;
      switch (index) {
        case 0:
          _imageUrl = 'https://images.unsplash.com/photo-1570125909517-53cb21c89ff2?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D';
          break;
        case 1:
          _imageUrl = 'https://images.unsplash.com/photo-1644770633699-5129770e0404?q=80&w=2008&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D';
          break;
        case 2:
          _imageUrl = 'https://images.unsplash.com/photo-1716918269977-a35b2c51f08e?q=80&w=1932&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D';
          break;
        default:
          _imageUrl = 'https://images.unsplash.com/photo-1570125909517-53cb21c89ff2?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D';
      }

    });
  }

  @override
  Widget build(BuildContext context) {

    Widget shuttleContent = SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Image(
              image: NetworkImage(_imageUrl),
            ),
            Container(
              color: CupertinoColors.white,
              padding: const EdgeInsets.all(10),
              child: Center(
                /* child: CupertinoSearchTextField(
                //controller: _controller,
                prefixIcon: TextButton(onPressed: (){
                  Navigator.pushNamed(context, 'registration');
                }, child: const Text('Click here to',style: TextStyle(
                    fontSize: 18,color: Colors.grey
                ),)),
              ),*/

                child:
                TextButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Filter()));
                }, child: const Text('Click here to search',style: TextStyle(
                    fontSize: 18,color: Colors.grey
                ),
                )
                ),
              ),
            ),
            buildBoxB(context, "DHA", "Dhaka", "CHA", "Chittagong", "06-06-2024", "02:35 am", "BU1234"),
            buildBoxB(context, "RAN", "Rangpur", "RAJ", "Rajshahi", "06-06-2024", "04:35 am", "UB1234"),
            buildBoxB(context, "CHA", "Chittagong", "RAJ", "Rajshahi", "06-06-2024", "04:35 am", "UB1234"),
            buildBoxB(context, "MYN", "Mymensingh", "DHA", "Dhaka", "06-06-2024", "07:35 am", "UB1234"),
            buildBoxB(context, "MYN", "Mymensingh", "RAN", "Rangpur", "06-06-2024", "04:35 am", "UB1234"),
            buildBoxB(context, "SYL", "Sylhet", "DHA", "Dhaka", "06-06-2024", "07:35 am", "UB1234"),
          ],
        ),
      ),
    );

    Widget busContent = SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Image(
              image: NetworkImage(_imageUrl),
            ),
            Container(
              color: CupertinoColors.white,
              padding:const EdgeInsets.all(10),
              child: Center(
                /* child: CupertinoSearchTextField(
                //controller: _controller,
                prefixIcon: TextButton(onPressed: (){
                  Navigator.pushNamed(context, 'registration');
                }, child: const Text('Click here to',style: TextStyle(
                    fontSize: 18,color: Colors.grey
                ),)),
              ),*/

                child:
                TextButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Filter()));
                }, child: const Text('Click here to search',style: TextStyle(
                    fontSize: 18,color: Colors.grey
                ),
                )
                ),
              ),
            ),
            buildBoxTrain(context, "SYL", "Sylhet", "KHU", "Khulna", "23-05-2024", "06:35 am", "UL1234"),
            buildBoxTrain(context, "BAR", "Barisal", "MYM", "Mymensingh", "23-05-2024", "09:35", "KL0464"),
            buildBoxTrain(context, "DHA", "Dhaka", "MYM", "Mymensingh", "23-05-2024", "03:35", "FL0584"),
            buildBoxTrain(context, "CHA", "Chittagong", "MYM", "Mymensingh", "23-05-2024", "09:35", "KL0564"),
            buildBoxTrain(context, "RAN", "Rangpur", "MYM", "Mymensingh", "23-05-2024", "03:35", "TL0564"),
            buildBoxTrain(context, "DHA", "Dhaka", "RAJ", "Rajshahi", "23-05-2024", "09:35", "PL0964"),
          ],
        ),
      ),
    );

    Widget trainContent = SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Image(
              image: NetworkImage(_imageUrl),
            ),
            Container(
              color: CupertinoColors.white,
              padding: const EdgeInsets.all(10),
              child: Center(
                /* child: CupertinoSearchTextField(
                //controller: _controller,
                prefixIcon: TextButton(onPressed: (){
                  Navigator.pushNamed(context, 'registration');
                }, child: const Text('Click here to',style: TextStyle(
                    fontSize: 18,color: Colors.grey
                ),)),
              ),*/

                child:
                TextButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Filter()));
                }, child: const Text('Click here to search',style: TextStyle(
                    fontSize: 18,color: Colors.grey
                ),
                )
                ),
              ),
            ),
            buildBoxB(context, "FAR", "Faridpur", "MUN", "Munshiganj", "24-05-2024", "12:00 am", "NI4207"),
            buildBoxB(context, "RAJ", "Rajshahi", "DHA", "Dhaka", "24-05-2024", "02:35 am", "JO2454"),
          ],
        ),
      ),
    );
    List<Widget> _widgetOptions = <Widget>[
      shuttleContent,
      busContent,
      trainContent,
    ];

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          color: Colors.white,
          onPressed: () {
            _scaffoldKey.currentState!.openDrawer();
          },
        ),
        title: const Text('JanBahon',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Center(
       // mainAxisAlignment: MainAxisAlignment.start,
        child: Column(
          children: <Widget>[
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFF737171),
                          Color(0xFFFDF9FD),
                        ],
                      ),
                    ),
                    child: Column(
                      children: [
                        IconButton(
                          icon: Icon(Icons.airport_shuttle),
                          iconSize: 35.0,
                          onPressed: () => _onIconTapped(0),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 2,),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFF737171),
                          Color(0xFFFDF9FD),
                        ],
                      ),
                    ),
                    child: Column(
                      children: [
                        IconButton(
                          icon: Icon(Icons.train),
                          iconSize: 35.0,
                          onPressed: () => _onIconTapped(1),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 2,),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFF737171),
                          Color(0xFFFDF9FD),
                        ],
                      ),
                    ),
                    child: Column(
                      children: [
                        IconButton(
                          icon: Icon(Icons.airplane_ticket),
                          iconSize: 35.0,
                          onPressed: () => _onIconTapped(2),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: _widgetOptions.elementAt(_selectedIndex),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFF5EFF9),
                    Color(0x00000000),
                  ],
                ),
              ),
              child: Image(
                image: AssetImage('assets/JanBahon-removebg-preview.png'),
                fit: BoxFit.cover,
                height: 150,
                width: 150,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey,width: .9)),
              ),
              child: ListTile(
                title: Text('Settings'),
                onTap: (){

                },
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey,width: .8)),
              ),
              child: ListTile(
                title: Text('Help'),
                onTap: (){

                },
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey,width: .8)),
              ),
              child: ListTile(
                title: Text('Contact'),
                onTap: (){

                },
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey,width: .8)),
              ),
              child: ListTile(
                title: Text('Log out'),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => BottomBar()));
                },
              ),
            ),
          ],
        ),
      ),

           bottomNavigationBar: BottomNavigationBar(
             items: const <BottomNavigationBarItem>[
               BottomNavigationBarItem(
                 icon: Icon(Icons.home),
                 label: 'Home',
               ),
               BottomNavigationBarItem(
                 icon: Icon(Icons.qr_code_2),
                 label: 'QR code',
               ),
               BottomNavigationBarItem(
                 icon: Icon(Icons.camera),
                 label: 'Map',
               ),
             ],
             currentIndex: _selectedIndex,
             selectedItemColor: Colors.purple,
             onTap: _onItemTapped,
           ),
    );
  }
}
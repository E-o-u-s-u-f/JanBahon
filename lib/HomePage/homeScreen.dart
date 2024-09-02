import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jan_bahon/HomePage/Filter.dart';
import 'package:jan_bahon/HomePage/QRviewAuth.dart';
//import 'package:jan_bahon/HomePage/BusOptions.dart';
//import 'package:jan_bahon/HomePage/filter.dart';
//import 'package:jan_bahon/HomePage/help.dart';
import '../Screens/log_in.dart';
import 'BusOptions.dart';
import 'CarHiring.dart';
import 'Contact.dart';
import 'MapViewAuth.dart';
import 'Settings.dart';
import 'chat_screen.dart';
import 'help.dart';
import 'liveTrackMap.dart';

class homeS extends StatefulWidget {
  const homeS({super.key});

  @override
  State<homeS> createState() => _State();
}

class _State extends State<homeS> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _controller = TextEditingController(text: 'Filter');
  final PageController _pageController = PageController();

  String imageurl1 = 'https://images.unsplash.com/photo-1570125909517-53cb21c89ff2?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D';
  String imageurl2='https://images.unsplash.com/photo-1644770633699-5129770e0404?q=80&w=2008&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D';
  String imageurl3= 'https://images.unsplash.com/photo-1716918269977-a35b2c51f08e?q=80&w=1932&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D';

  int _selectedIndex = 0;
  int selInd = 0;
  // String _imageUrl = 'https://images.unsplash.com/photo-1570125909517-53cb21c89ff2?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D';

  Future<List<Map<String, dynamic>>> fetchBusData() async {
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestore.collection("Bus").get();
    return qn.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  }

  Future<List<Map<String, dynamic>>> fetchTrainData() async {
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestore.collection("Train").get();
    return qn.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  }

  Future<List<Map<String, dynamic>>> fetchAirplaneData() async {
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestore.collection("Airplane").get();
    return qn.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  }

  void _onIconTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.jumpToPage(index);
    });
  }

  @override
  Widget build(BuildContext context) {

    Widget busContent = FutureBuilder(
      future: fetchBusData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData ) {
          return Center(child: Text('No data found'));
        } else {
          var busData = snapshot.data as List<Map<String, dynamic>>;
          return SingleChildScrollView(
            child: Container(
              //padding: EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  Container(
                    height: 225,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(color: Colors.transparent, width: 2.0),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image(
                        image: NetworkImage(imageurl1),
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                  ),
                  for (var bus in busData)
                    buildBoxB(
                      context,
                      bus['FROM'] ?? 'Unknown',
                      bus['FROM1'] ?? 'Unknown',
                      bus['TO'] ?? 'Unknown',
                      bus['TO1'] ?? 'Unknown',
                      bus['Date'] ?? 'Unknown',
                      bus['time'] ?? 'Unknown',
                      bus['no'] ?? 'Unknown',
                      0,
                      bus['Fair']??'Unknown',
                    ),
                ],
              ),
            ),
          );
        }
      },
    );

    Widget trainContent = FutureBuilder(
      future: fetchTrainData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData ) {
          return Center(child: Text('No data found'));
        } else {
          var trainData = snapshot.data as List<Map<String, dynamic>>;
          return SingleChildScrollView(
            child: Container(
              //padding: EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  Container(
                    height: 225,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(color: Colors.transparent, width: 2.0),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image(
                        image: NetworkImage(imageurl2),
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                  ),
                  for (var train in trainData)
                    buildBoxB(
                      context,
                      train['FROM'],
                      train['FROM1'],
                      train['TO'],
                      train['TO1'],
                      train['Date'],
                      train['time'],
                      train['no'],
                      1,
                      train['Fair'],
                    ),
                ],
              ),
            ),
          );
        }
      },
    );

    Widget airplaneContent = FutureBuilder(
      future: fetchAirplaneData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData ) {
          return Center(child: Text('No data found'));
        } else {
          var airplaneData = snapshot.data as List<Map<String, dynamic>>;
          return SingleChildScrollView(
            child: Container(
              //padding: EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  Container(
                    height: 225,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(color: Colors.transparent, width: 2.0),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image(
                        image: NetworkImage(imageurl3),
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                  ),
                  for (var airplane in airplaneData)
                    buildBoxB(
                      context,
                      airplane['FROM'],
                      airplane['FROM1'],
                      airplane['TO'],
                      airplane['TO1'],
                      airplane['Date'],
                      airplane['time'],
                      airplane['no'],
                      2,
                      airplane['Fair'],
                    ),
                ],
              ),
            ),
          );
        }
      },
    );

    List<Widget> _widgetOptions = <Widget>[
      busContent,
      trainContent,
      airplaneContent,
    ];

    return Container(
        decoration:BoxDecoration(
            gradient:LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.white,Colors.indigo]
            )
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          key: _scaffoldKey,
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.menu),
              color: Colors.black,
              onPressed: () {
                _scaffoldKey.currentState!.openDrawer();
              },
            ),
            title:Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'JanBah',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
                ),
                Transform.rotate(
                  angle: 0.01,
                  child: Image.asset('assets/new.png', height: 20),
                ),
                Text(
                  'n',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
                ),
              ],
            ),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            actions: [
              IconButton(
                icon: Icon(Icons.filter_list),
                color: Colors.black,
                onPressed: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) => BusOption(cur: _selectedIndex),
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        const begin = Offset(1.0, 0.0);
                        const end = Offset.zero;
                        const curve = Curves.easeInOut;
                        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                        var offsetAnimation = animation.drive(tween);
                        return SlideTransition(position: offsetAnimation, child: child);
                      },
                    ),
                  );
                },
              ),
            ],
          ),
          body: Center(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.white,
                              Colors.transparent
                            ],
                          ),
                        ),
                        child: IconButton(
                          icon: Icon(Icons.qr_code),
                          onPressed: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (context, animation, secondaryAnimation) => QRviewAccessPage(),
                                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                  const begin = Offset(1.0, 0.0);
                                  const end = Offset.zero;
                                  const curve = Curves.easeInOut;
                                  var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                                  var offsetAnimation = animation.drive(tween);
                                  return SlideTransition(position: offsetAnimation, child: child);
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 2),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.white,
                              Colors.transparent
                            ],
                          ),
                        ),
                        child: IconButton(
                          icon: Icon(Icons.map),
                          onPressed: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (context, animation, secondaryAnimation) => MapviewAccessPage(),
                                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                  const begin = Offset(1.0, 0.0);
                                  const end = Offset.zero;
                                  const curve = Curves.easeInOut;
                                  var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                                  var offsetAnimation = animation.drive(tween);
                                  return SlideTransition(position: offsetAnimation, child: child);
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                    children: _widgetOptions,
                  ),
                ),
              ],
            ),
          ),

          floatingActionButton: FloatingActionButton(
            splashColor: Colors.white,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChatScreen()),
              );
            },
            child: Icon(Icons.message),
            tooltip: 'Go to Chat',
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
                  /*decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey, width: .8)),
              ),*/
                  color: Colors.transparent,
                  child: ListTile(
                    leading: Icon(Icons.home),
                    title: Text('Home'),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => homeS()));
                    },
                  ),
                ),
                Container(
                  color: Colors.transparent,
                  child: ListTile(
                    leading: Icon(Icons.contacts),
                    title: Text('Contact'),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ContactPage()));
                    },
                  ),
                ),
                Container(
                  color: Colors.transparent,
                  child: ListTile(
                    leading: Icon(Icons.directions_car),
                    title: Text('Car Hiring'),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => HiringCars()));
                    },
                  ),
                ),
                Container(
                  color: Colors.transparent,
                  child: ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Settings'),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>  settingsScreen()));
                    },
                  ),
                ),
                Container(
                  child: ListTile(
                    leading: Icon(Icons.help),
                    title: Text('Help'),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => HelpPage()));
                    },
                  ),
                ),
                Container(
                  color: Colors.transparent,
                  child: ListTile(
                    leading: Icon(Icons.logout),
                    title: Text('Log out'),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => BottomBar()));
                    },
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            elevation: 10,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.directions_bus),
                label: 'Bus',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.train),
                label: 'Train',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.airplanemode_active),
                label: 'Airplane',
              ),
            ],
            selectedItemColor: Colors.indigoAccent,
            selectedIconTheme: IconThemeData(color: Colors.indigoAccent),
            unselectedLabelStyle:TextStyle(fontWeight: FontWeight.bold) ,
            selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
            currentIndex: _selectedIndex,
            onTap: _onIconTapped,
            /*onTap: (index) {
          setState(() {
            selInd = index;
          });
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => _widgetOptions1[index]),
          );
        },*/
          ),
        ));
  }

}

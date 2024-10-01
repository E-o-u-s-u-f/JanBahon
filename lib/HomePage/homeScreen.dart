import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:animate_gradient/animate_gradient.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import '../Screens/log_in.dart';
import 'BusOptions.dart';
import 'CarHiring.dart';
import 'Contact.dart';
import 'Filter.dart';
import 'MapViewAuth.dart';
import 'Settings.dart';
import 'chat_screen.dart';
import 'help.dart';
//import 'liveTrackMap.dart';
import 'QRviewAuth.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

class homeS extends StatefulWidget {
  const homeS({super.key});

  @override
  State<homeS> createState() => _State();
}

class _State extends State<homeS> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  // URLs for images
  String imageurl1 = 'https://images.unsplash.com/photo-1570125909517-53cb21c89ff2?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D';
  String imageurl4='https://images.unsplash.com/photo-1644770633699-5129770e0404?q=80&w=2008&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D';
  String imageurl7= 'https://images.unsplash.com/photo-1716918269977-a35b2c51f08e?q=80&w=1932&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D';
  String imageurl8='https://www.observerbd.com/2022/07/26/observerbd.com_1658848028.jpg';
  String imageurl6='https://dhz-coxb-railway.com/wp-content/uploads/2022/08/Rail-2204120639.jpg';
  String imageurl5='https://upload.wikimedia.org/wikipedia/commons/4/46/%E0%A6%B2%E0%A6%BE%E0%A6%89%E0%A6%AF%E0%A6%BC%E0%A6%BE%E0%A6%9B%E0%A6%A1%E0%A6%BC%E0%A6%BE_%E0%A6%9C%E0%A6%BE%E0%A6%A4%E0%A7%80%E0%A6%AF%E0%A6%BC_%E0%A6%89%E0%A6%A6%E0%A7%8D%E0%A6%AF%E0%A6%BE%E0%A6%A8%E0%A7%87%E0%A6%B0_%E0%A6%AE%E0%A6%BE%E0%A6%9D_%E0%A6%A6%E0%A6%BF%E0%A6%AF%E0%A6%BC%E0%A7%87_%E0%A6%AF%E0%A6%BE%E0%A6%9A%E0%A7%8D%E0%A6%9B%E0%A7%87_%E0%A6%9F%E0%A7%8D%E0%A6%B0%E0%A7%87%E0%A6%A8.jpg';
  String imageurl2= 'https://www.travelmate.com.bd/wp-content/uploads/2022/09/rent-a-bus.jpg.webp';
  String imageurl3='https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRZUdZ26VA-3PeiRykkn2BMNYKlon76XFf1Fg&s';
  String imageurl9='https://static1.simpleflyingimages.com/wordpress/wp-content/uploads/2022/09/Biman-1.jpg';
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
      _pageController.jumpToPage(index); // Move the PageView to the selected page
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
              child: Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(color: Colors.transparent, width: 2.0),
                    ),
                    child: ImageSlideshow(
                      width: double.infinity,
                      height: 200,
                      initialPage: 0,
                      indicatorColor: Colors.indigo,
                      indicatorBackgroundColor: Colors.grey,
                      autoPlayInterval: 2000,
                      isLoop: true,
                      disableUserScrolling:false,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Image.network(
                            imageurl1,
                            fit: BoxFit.cover,
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Image.network(
                            imageurl2,
                            fit: BoxFit.cover,
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Image.network(
                            imageurl3,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
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
                      bus['Fair'] ?? 'Unknown',
                    ),
                  SizedBox(height: 58,)
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
              child: Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(color: Colors.transparent, width: 2.0),
                    ),
                    child: ImageSlideshow(
                      width: double.infinity,
                      height: 200,
                      initialPage: 0,
                      indicatorColor: Colors.indigo,
                      indicatorBackgroundColor: Colors.grey,
                      autoPlayInterval: 2000,
                      isLoop: true,
                      disableUserScrolling:false,

                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Image.network(
                            imageurl4,
                            fit: BoxFit.cover,
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Image.network(
                            imageurl5,
                            fit: BoxFit.cover,
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Image.network(
                            imageurl6,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
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
                  SizedBox(height: 58,)
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
              child: Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(color: Colors.transparent, width: 2.0),
                    ),
                    child: ImageSlideshow(
                      width: double.infinity,
                      height: 200,
                      initialPage: 0,
                      indicatorColor: Colors.indigo,
                      indicatorBackgroundColor: Colors.grey,
                      autoPlayInterval: 2000,
                      isLoop: true,
                      disableUserScrolling:false,

                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Image.network(
                            imageurl7,
                            fit: BoxFit.cover,
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Image.network(
                            imageurl8,
                            fit: BoxFit.cover,
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Image.network(
                            imageurl9,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
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
                  SizedBox(height: 58,)
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
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.white, Colors.indigo],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBody: true,
        key: _scaffoldKey,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.menu),
            color: Colors.black,
            onPressed: () {
              _scaffoldKey.currentState!.openDrawer();
            },
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                'JanBah',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
              ),
              Transform.rotate(
                angle: 0.01,
                child: Image.asset('assets/new.png', height: 20,),
              ),
              const Text(
                'n',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
              ),
            ],
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          actions: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.map),
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
                SizedBox(width: 1),
                IconButton(
                  icon: const Icon(Icons.qr_code),
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
                SizedBox(width: 1),
                IconButton(
                  icon: Icon(Icons.search),
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
          ],
        ),
        body: AnimateGradient(
          primaryBegin: Alignment.topLeft,
          primaryEnd: Alignment.bottomLeft,
          secondaryBegin: Alignment.bottomLeft,
          secondaryEnd: Alignment.topRight,
          primaryColors: const[
            Colors.indigo,
            Colors.indigoAccent,
            Colors.white,
          ],
          secondaryColors: const[
            Colors.white,
            Colors.blueAccent,
            Colors.blue,
          ],
          child: Column(
            children: [
              SizedBox(height: 20,),
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
          tooltip: 'Go to Chat',
          child: const Icon(Icons.message),
          mini: true,
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const DrawerHeader(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFF5EFF9), Color(0x00000000)],
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
                color: Colors.transparent,
                child: ListTile(
                  leading: Icon(Icons.home),
                  title: Text('Home'),
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => homeS())
                    );
                  },
                ),
              ),
              Container(
                color: Colors.transparent,
                child: ListTile(
                  leading: Icon(Icons.contacts),
                  title: Text('Contact'),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ContactPage())
                    );
                  },
                ),
              ),
              Container(
                color: Colors.transparent,
                child: ListTile(
                  leading: Icon(Icons.directions_car),
                  title: Text('Car Hiring'),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HiringCars())
                    );
                  },
                ),
              ),
              Container(
                color: Colors.transparent,
                child: ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Settings'),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => settingsScreen())
                    );
                  },
                ),
              ),
              Container(
                color: Colors.transparent,
                child: ListTile(
                  leading: Icon(Icons.help),
                  title: Text('Help'),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HelpPage())
                    );
                  },
                ),
              ),
              Container(
                color: Colors.transparent,
                child: ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('Logout'),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const BottomBar())
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          margin: const EdgeInsets.all(12),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.indigo[800],
            borderRadius: BorderRadius.circular(30),

            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.3),
                spreadRadius: 10,
                blurRadius: 10,
                offset: const Offset(0, 3), // changes the position of the shadow
              ),
            ],
          ),
          child: SalomonBottomBar(
            currentIndex: _selectedIndex,
            onTap: _onIconTapped,
            itemPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            items: [
              SalomonBottomBarItem(
                icon: Icon(Icons.directions_bus),
                title: Text("Bus"),
                selectedColor: Colors.white,
                unselectedColor: Colors.white,
              ),
              SalomonBottomBarItem(
                icon: Icon(Icons.train),
                title: Text("Train"),
                selectedColor: Colors.white,
                unselectedColor: Colors.white,
              ),
              SalomonBottomBarItem(
                icon: Icon(Icons.airplane_ticket),
                title: Text("Airplane"),
                selectedColor: Colors.white,
                unselectedColor: Colors.white,
              ),
            ],
          ),
        ),
      ),

    );
  }
}

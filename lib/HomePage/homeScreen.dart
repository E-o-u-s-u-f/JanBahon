import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:jan_bahon/Seat&BuyTicket/bus_seat_selection.dart';
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
  @override
  Widget build(BuildContext context) {
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
        child:SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
              Image(
                image: NetworkImage('https://images.unsplash.com/photo-1570125909517-53cb21c89ff2?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
              ),
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
                              ])
                      ),
                      child: Column(
                        children:[ IconButton(
                          icon: Icon(Icons.airport_shuttle),
                          iconSize: 35.0,
                          onPressed: changeColor,
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
                            ]),
                      ),
                      child: Column(
                        children:[ IconButton(
                          icon: Icon(Icons.train),
                          iconSize: 35.0,
                          onPressed: changeColor,
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
                              ])
                      ),
                      child: Column(
                        children:[ IconButton(
                          icon: Icon(Icons.airplane_ticket),
                          iconSize: 35.0,
                          onPressed: changeColor,
                        ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                color: CupertinoColors.white,
                padding:const EdgeInsets.all(10),
                child: Center(
                  child: CupertinoSearchTextField(
                    controller: _controller,
                  ),
                ),
              ),
                buildBox("DHA","Dhaka","CHA","Chittagong","23-05-2024","02:35 am","BU1234"),
                buildBox("RAN","Rangpur","RAJ","Rajshahi","23-05-2024","04:35 am","UB1234"),
                buildBox("SYL","Sylhet","KHU","Khulna","23-05-2024","06:35 am","UL1234"),
                buildBox("BAR","Barisal","MYM","Mymensingh","23-05-2024","09:35","KL0564"),
                buildBox("FAR","Faridpur","MUN","Munshiganj","24-05-2024","12:00 am","NI4207"),
                buildBox("RAJ","Rajshahi","DHA","Dhaka","24-05-2024","02:35 am","JO2454"),
                buildBox("KHU","Khulna","BAR","Barisal","24-05-2024","01:35 am","ro3024"),
            ],
            ),
          ),
        )

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
                 // Navigator.push(context, MaterialPageRoute(builder: (context) => BottomAppBar()));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget buildBox(String FROM,String FROM1,String TO,String TO1,String date,String time,String no) {
    return InkWell(
        onTap: () {
      // Handle tap event here
          Navigator.push(context, MaterialPageRoute(builder: (context) => BusSeatSelection()));

        },

      child:Container(

      margin: EdgeInsets.all(16.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      FROM,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(FROM1),
                  ],
                ),
              ),
              Icon(
                Icons.airport_shuttle,
                size: 32,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      TO,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(TO1),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.0),
          Divider(thickness: 1, color: Colors.grey),
          SizedBox(height: 16.0),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Date', style: TextStyle(color: Colors.grey)),
                    Text(date),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Bus', style: TextStyle(color: Colors.grey)),
                    Text(no),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('Time', style: TextStyle(color: Colors.grey)),
                    Text(time),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      )
    );
  }
}
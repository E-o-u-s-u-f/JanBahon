/*import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class  BusSeatSelection extends StatefulWidget {
  const  BusSeatSelection({super.key});

  @override
  State<BusSeatSelection> createState() => _BusSeatSelectionState();
}

class _BusSeatSelectionState extends State<BusSeatSelection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text("Select seat"),
          leading: IconButton(
            icon:Icon(Icons.arrow_back),
            onPressed:(){
              Navigator.pop(context);
            },
            color: Colors.black,
          ),
          backgroundColor: Colors.grey[200],
          elevation: 0,
          foregroundColor: Colors.black

      ),
      body: Column(
        children: [
          Padding(padding: const EdgeInsets.all(8.0),
            child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 40, width: 40,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                Text("Booked"),
                Container(
                  height: 40, width: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.add,
                    ),
                  ),
                ),
                Text("Vacant"),
              ],
            ),
          ),
          Expanded(child: Stack(
            children: [
              Positioned(
                  top: 70,
                  left: 95,
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child:
                    InkWell(
                      onTap:(){
                        _Selected_Seat();
                      },
                      child: Column(
                        children: [
                          Row(
                            children: [

                              SizedBox(
                                width: 150,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 100,
                          ),
                          Row(
                            children: [
                              _Vacant_seatLayout(),

                              _Vacant_seatLayout(),
                              SizedBox(
                                width: 40,
                              ),
                              _Vacant_seatLayout(),
                              _Vacant_seatLayout(),
                            ],
                          ),
                          Row(
                            children: [
                              _Vacant_seatLayout(),
                              _Vacant_seatLayout(),
                              SizedBox(
                                width: 40,
                              ),
                              _Vacant_seatLayout(),
                              _Vacant_seatLayout(),
                            ],
                          ),
                          Row(
                            children: [
                              _Vacant_seatLayout(),
                              _Vacant_seatLayout(),
                              SizedBox(
                                width: 40,
                              ),
                              _Vacant_seatLayout(),
                              _Vacant_seatLayout(),
                            ],
                          ),
                          Row(
                            children: [
                              _Vacant_seatLayout(),
                              _Vacant_seatLayout(),
                              SizedBox(
                                width: 40,
                              ),
                              _Selected_Seat(),
                              _Vacant_seatLayout()
                            ],
                          ),
                          Row(
                            children: [
                              _Vacant_seatLayout(),
                              _Vacant_seatLayout(),
                              SizedBox(
                                width: 40,
                              ),
                              _Selected_Seat(),
                              _Selected_Seat(),
                            ],
                          ),
                          Row(
                            children: [
                              _Selected_Seat(),
                              _Vacant_seatLayout(),
                              SizedBox(
                                width: 40,
                              ),
                              _Vacant_seatLayout(),
                              _Vacant_seatLayout()
                            ],
                          ),
                          Row(
                            children: [
                              _Vacant_seatLayout(),
                              _Vacant_seatLayout(),
                              SizedBox(
                                width: 40,
                              ),
                              _Vacant_seatLayout(),
                              _Vacant_seatLayout()
                            ],
                          ),
                          Row(
                            children: [
                              _Vacant_seatLayout(),
                              _Vacant_seatLayout(),
                              SizedBox(
                                width: 40,
                              ),
                              _Vacant_seatLayout(),
                              _Vacant_seatLayout()
                            ],
                          ),
                          Row(
                            children: [
                              _Vacant_seatLayout(),
                              _Vacant_seatLayout(),
                              _Vacant_seatLayout(),
                              _Vacant_seatLayout(),
                              _Vacant_seatLayout()
                            ],
                          )
                        ],
                      ),
                    ),
                  )),

            ],
          ),
          ),
        ],
      ),
      bottomNavigationBar: SizedBox(
          height: 84,
          child: BottomAppBar(
              elevation: 64,
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                  child: Row(
                    children: [
                      const Text("Seat:1/1"),
                      const SizedBox(
                        width:24,
                      ),
                      Expanded(
                        child: Container(
                          height: 54,
                          decoration:  BoxDecoration(
                              color: Colors.amberAccent,
                              borderRadius: BorderRadius.circular(32)
                          ),
                          child: Center(
                            child: Text("Confirm", style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white)),

                          ),
                        ),
                      )
                    ],
                  )
              )
          )
      ),
    );
  }


  Widget _Vacant_seatLayout() {
    return Container(

      width: 40,
      height: 40,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width:1,),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 5,
            bottom: 5,
            left: 5,
            right: 5,
            child: SizedBox(
              child: DecoratedBox(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white
                ),
              ),
            ),),
          Positioned(
            top: 29,
            bottom: 5,
            left: 5,
            right: 5,
            child: SizedBox(
              child: DecoratedBox(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white
                ),
              ),
            ),),
          Positioned(
            top: 15,
            bottom: 5,
            left: 4,
            right: 30,
            child: SizedBox(
              child: DecoratedBox(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white
                ),
              ),
            ),),
          Positioned(
            top: 15,
            bottom: 5,
            left: 30,
            right: 4,
            child: SizedBox(
              child: DecoratedBox(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white
                ),
              ),
            ),)

        ],
      ),
    );
  }
  Widget _Selected_Seat() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width:1,),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 5,
            bottom: 5,
            left: 5,
            right: 5,
            child: SizedBox(
              child: DecoratedBox(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.lightGreenAccent
                ),
              ),
            ),),
          Positioned(
            top: 29,
            bottom: 5,
            left: 5,
            right: 5,
            child: SizedBox(
              child: DecoratedBox(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.lightGreenAccent
                ),
              ),
            ),),
          Positioned(
            top: 15,
            bottom: 5,
            left: 4,
            right: 30,
            child: SizedBox(
              child: DecoratedBox(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.lightGreenAccent
                ),
              ),
            ),),
          Positioned(
            top: 15,
            bottom: 5,
            left: 30,
            right: 4,
            child: SizedBox(
              child: DecoratedBox(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.lightGreenAccent
                ),
              ),
            ),)

        ],
      ),
    );
  }
}*/

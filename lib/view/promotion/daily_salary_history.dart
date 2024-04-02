import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';




class DailySalaryHistory extends StatefulWidget {
  const DailySalaryHistory({Key ?key}) : super(key: key);

  @override
  State<DailySalaryHistory> createState() => _DailySalaryHistoryState();
}

class _DailySalaryHistoryState extends State<DailySalaryHistory> {
  @override
  void dispose() {
    // DailySalaryHistory;
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading:
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back,)),
          backgroundColor: Colors.red,
          title: const Text("Daily Salary History"),
          centerTitle: true,),

        body:  ListView.builder(
            itemCount: 1,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: height*0.08,

                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color: Colors.grey.withOpacity(0.3))
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Salary",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16)
                            ),
                            Text("Date",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16)
                            ),

                          ],
                        ),
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text("₹0",style: TextStyle(
                              color: Colors.grey,
                                fontWeight: FontWeight.w500,
                                fontSize: 16)),
                            Text("31-01-2024",style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                                fontSize: 16)),
                          ],
                        )

                      ],
                    ),
                  ),
                ),
              );
            })
        // FutureBuilder<List<DailySalaryHistory>>(
        //     future: acd(),
        //     builder: (context, snapshot) {
        //       if (snapshot.connectionState == ConnectionState.waiting) {
        //         return Center(
        //           child: CircularProgressIndicator(),
        //         );
        //       }
        //       else if (snapshot.hasError) {
        //         return Center(
        //           child: Text('Error: ${snapshot.error}'),
        //         );
        //       }
        //       else if (!snapshot.hasData || snapshot.data.isEmpty) {
        //         return Center(
        //           child: Column(
        //             mainAxisAlignment: MainAxisAlignment.center,
        //             children: [
        //               Container(
        //                 height: 200,
        //                 width: 700,
        //                 decoration: BoxDecoration(
        //                     image: DecorationImage(
        //                       fit: BoxFit.fill,
        //                       image: AssetImage('assets/images/NO_Data.png'),
        //                     )
        //                 ),
        //               ),
        //               Text(
        //                 "No Game History",
        //                 style: TextStyle(
        //                   fontWeight: FontWeight.bold,
        //                   fontSize: 30,
        //                 ),
        //               ),
        //
        //             ],
        //           ),
        //         );
        //       }
        //       else {
        //         return ListView.builder(
        //             itemCount: snapshot.data.length,
        //             scrollDirection: Axis.vertical,
        //             itemBuilder: (BuildContext context, int index) {
        //               return Padding(
        //                 padding: const EdgeInsets.all(8.0),
        //                 child: Container(
        //                   height: height * 0.1,
        //                   decoration: BoxDecoration(
        //                       borderRadius: BorderRadius.all(
        //                         Radius.circular(10),
        //                       ),
        //                       color: snapshot.data[index].type.toLowerCase()=='credit'?Colors.green:Colors.red,
        //                       // snapshot.data[index].status=='1'?Colors.orangeAccent:Colors.green,
        //                       boxShadow: [
        //                         BoxShadow(
        //                             offset: Offset(0, 2),
        //                             spreadRadius: 0,
        //                             blurRadius: 3,
        //                             // color: snapshot.data[index].type.toLowerCase()=='credit'?Colors.green:Colors.red,
        //                             color: Colors.grey.withOpacity(0.2))
        //                       ]),
        //                   // color: Color(0xfffe4d6a),
        //                   child: Padding(
        //                     padding: const EdgeInsets.fromLTRB(8, 0, 15, 0),
        //                     child: Container(
        //                       color: Colors.white,
        //                       child: Column(
        //                         children: [
        //                           Row(crossAxisAlignment: CrossAxisAlignment.center,
        //                             mainAxisAlignment:
        //                             MainAxisAlignment.spaceEvenly,
        //                             children: [
        //                               Wrap(
        //                                 direction: Axis.horizontal,
        //                                 children: [
        //                                   Image.asset("assets/images/coine.png",scale: 10,),
        //                                   Text("${snapshot.data[index].amount}",
        //                                       style: TextStyle(
        //                                           color: Colors.black,
        //                                           fontWeight: FontWeight.w500,
        //                                           fontSize: 40)),
        //                                   // Text(
        //                                   //   "Deposit",
        //                                   //   style: TextStyle(
        //                                   //       fontFeatures: [
        //                                   //         FontFeature.superscripts()
        //                                   //       ],
        //                                   //       color: Colors.black,
        //                                   //       fontWeight: FontWeight.w500,
        //                                   //       fontSize: 12),
        //                                   // ),
        //                                 ],
        //                               ),
        //                               Wrap(
        //                                 direction: Axis.horizontal,
        //                                 children: [
        //                                   Text(
        //                                       DateFormat("dd-MM-yyyy, hh:mm a").format(
        //                                           DateTime.parse(snapshot.data[index].datetime.toString())),
        //
        //                                       // snapshot.data[index].status=='0'?'Pending':"Success",
        //                                       style: TextStyle(
        //
        //                                           color: Colors.black.withOpacity(0.7),
        //                                           fontWeight: FontWeight.w600,
        //                                           fontSize: 12)),
        //                                   Text(
        //                                     "Date/Time",
        //                                     style: TextStyle(
        //                                         fontFeatures: [
        //                                           FontFeature.superscripts()
        //                                         ],
        //                                         color: Colors.black.withOpacity(0.8),
        //                                         fontWeight: FontWeight.w600,
        //                                         fontSize: 10),
        //                                   ),
        //                                 ],
        //                               ),
        //
        //                             ],
        //                           ),
        //                           Row(mainAxisAlignment: MainAxisAlignment.center,
        //                             children: [
        //                               Wrap(
        //                                 direction: Axis.horizontal,
        //                                 children: [
        //                                   Text(
        //                                     // "24/03/2002",
        //                                       "${snapshot.data[index].type}",
        //                                       style: TextStyle(
        //                                           color: snapshot.data[index].type.toLowerCase()=='credit'?Colors.green.withOpacity(0.8):Colors.red.withOpacity(0.8),
        //                                           // color: Colors.black.withOpacity(0.5),
        //                                           fontWeight: FontWeight.w700,
        //                                           fontSize: 15)),
        //                                   Text(
        //                                     "Type",
        //                                     style: TextStyle(
        //                                         fontFeatures: [
        //                                           FontFeature.superscripts()
        //                                         ],
        //                                         color: Colors.black.withOpacity(0.8),
        //                                         fontWeight: FontWeight.w500,
        //                                         fontSize: 10),
        //                                   ),
        //                                 ],
        //                               ),
        //                             ],
        //                           )
        //                         ],
        //                       ),
        //                     ),
        //                   ),
        //                 ),
        //               );
        //             });
        //       }
        //     }),
      ),
    );
  }
  // Future<List<DailySalaryHistory>> acd() async{
  //   final prefs = await SharedPreferences.getInstance();
  //   final userid=prefs.getString("userId");
  //
  //   print('gkgotkhoktoh');
  //
  //   final response = await http.get(
  //     Uri.parse(Apiconst.DailySalaryHistory+"userid=$userid&type="),
  //     // Uri.parse("https://apponrent.co.in/chess/api/DailySalaryHistory.php?userid=$userid&type=credit"),
  //   );
  //   print(response);
  //   print("😂😂😂😂😂");
  //   var jsond = json.decode(response.body)["data"];
  //   print('wwwwwwwwwwwwwwwwwwww');
  //   print(jsond);
  //   List<DailySalaryHistory> allround = [];
  //   for (var o in jsond)  {
  //     DailySalaryHistory al = DailySalaryHistory(
  //       o["amount"],
  //       o["type"],
  //       o["discription"],
  //       o["id"],
  //       o["status"],
  //       o["datetime"],
  //       //  o["date"]+' '+o['time'],
  //
  //
  //     );
  //
  //     allround.add(al);
  //   }
  //   return allround;
  // }
}
// class DailySalaryHistory {
//   String amount;
//   String type;
//   String discription;
//   String id;
//   String status;
//   String datetime;
//
//
//
//
//
//   DailySalaryHistory(
//       this.amount,
//       this.type,
//       this.discription,
//       this.id,
//       this.status,
//       this.datetime,
//
//       );
//
// }
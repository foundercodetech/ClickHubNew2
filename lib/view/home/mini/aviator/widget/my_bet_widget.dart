import 'package:flutter/material.dart';

class MyBetPage extends StatefulWidget {
  const MyBetPage({Key? key}) : super(key: key);

  @override
  State<MyBetPage> createState() => _MyBetPageState();
}

class _MyBetPageState extends State<MyBetPage> {
  List<MyBetsModel> bets = [
    MyBetsModel(
      "10:10",
      "800.00",
      "",
    ),
    MyBetsModel(
      "10:11",
      "800.00",
      "",
    ),
    MyBetsModel(
      "10:16",
      "800.00",
      "",
    ),
    MyBetsModel(
      "02:10",
      "800.00",
      "",
    ),
    MyBetsModel(
      "05:10",
      "800.00",
      "",
    ),
  ];
  double height = 150;
  double width = 300;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  width: width * 0.3,
                  child: Text("Date",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold)),
                ),
                Container(
                  alignment: Alignment.center,
                  width: width * 0.3,
                  child: Text("Bet, INR X",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold)),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  width: width * 0.3,
                  child: Text("Win, INR",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
          ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: bets.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5.0, vertical: 2),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.1),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            alignment: Alignment.centerLeft,
                            width: width * 0.3,
                            child: Text(bets[index].username.toString(),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10))),
                        Container(
                            alignment: Alignment.center,
                            width: width * 0.3,
                            child: Text(bets[index].bet.toString(),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10))),
                        Container(
                            alignment: Alignment.centerRight,
                            width: width * 0.3,
                            child: Text(bets[index].win.toString(),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10))),
                      ],
                    ),
                  ),
                );
              })
        ],
      ),
    );
  }
}

class MyBetsModel {
  String? username;
  String? bet;
  String? win;
  MyBetsModel(this.username, this.bet, this.win);
}

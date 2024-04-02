import 'package:flutter/material.dart';

class AllBetPage extends StatefulWidget {
  const AllBetPage({super.key});

  @override
  State<AllBetPage> createState() => _AllBetPageState();
}

class _AllBetPageState extends State<AllBetPage> {
  List<AllBetsModel> bets = [
    AllBetsModel(
      "Aman",
      "800.00",
      "500",
    ),
    AllBetsModel(
      "Swati",
      "800.00",
      "500",
    ),
    AllBetsModel(
      "Manu",
      "800.00",
      "100",
    ),
    AllBetsModel(
      "Tanu",
      "800.00",
      "477",
    ),
    AllBetsModel(
      "Chaman",
      "800.00",
      "7541",
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
                  child: const Text("User",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold)),
                ),
                Container(
                  alignment: Alignment.center,
                  width: width * 0.3,
                  child: const Text("Bet, INR X",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold)),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  width: width * 0.3,
                  child: const Text("Win, INR",
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
              physics: const NeverScrollableScrollPhysics(),
              itemCount: bets.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5.0, vertical: 2),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.1),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            alignment: Alignment.centerLeft,
                            width: width * 0.3,
                            child: Text(bets[index].username.toString(),
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 10))),
                        Container(
                            alignment: Alignment.center,
                            width: width * 0.3,
                            child: Text(bets[index].bet.toString(),
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 10))),
                        Container(
                            alignment: Alignment.centerRight,
                            width: width * 0.3,
                            child: Text(bets[index].win.toString(),
                                style: const TextStyle(
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

class AllBetsModel {
  String? username;
  String? bet;
  String? win;
  AllBetsModel(this.username, this.bet, this.win);
}

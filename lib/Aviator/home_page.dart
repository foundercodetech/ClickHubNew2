// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ClickHub/Aviator/AviatorProvider.dart';
import 'package:ClickHub/Aviator/progressbar.dart';
import 'package:ClickHub/model/user_model.dart';
import 'package:ClickHub/res/api_urls.dart';
import 'package:ClickHub/res/components/app_btn.dart';

import 'package:ClickHub/res/provider/user_view_provider.dart';
import 'package:ClickHub/utils/utils.dart';
import 'package:ClickHub/Aviator/aviator_constant/aviator_assets.dart';
import 'package:ClickHub/Aviator/aviator_model/result_history_model.dart';
import 'package:ClickHub/Aviator/my_bet.dart';
import 'package:ClickHub/Aviator/widget/Marquee/marquee.dart';
import 'package:ClickHub/Aviator/widget/rendom_color.dart';
import 'package:ClickHub/Aviator/widget/small_toggel_switch.dart';
import 'package:ClickHub/Aviator/widget/switch.dart';
import 'package:ClickHub/Aviator/widget/toggel_switch.dart';
import 'dart:math' as math;
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class GameAviator extends StatefulWidget {
  const GameAviator({super.key});

  @override
  State<GameAviator> createState() => _GameAviatorState();
}

class AllBets {
  String? image;
  String? username;
  String? bet;
  String? win;
  AllBets(this.image, this.username, this.bet, this.win);
}

class _GameAviatorState extends State<GameAviator>
    with TickerProviderStateMixin {
  late final AnimationController _controllers =
      AnimationController(vsync: this, duration: const Duration(seconds: 1500))
        ..repeat();

  late final AnimationController _controllerfan = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 1500))
    ..repeat();


  ximeValue() async {
    if(planetype==2)
      for (var i = 0; i < 200; i++) {
        await Future.delayed(const Duration(milliseconds: 100));
        setState(() {
          xtime = xtime + 2 * 0.01;
        });
         if(planetype==2){
           AvitorDirectResultMatch();

         }
        if( autoaCas == true){
          if(double.parse(autovalue.text)<=xtime){
            if(cashCollect==false){
              if(process==false)
                cashout(amount.text,xtime.toStringAsFixed(2));
            }
          }
        }
      }
  }
  late AnimationController _linearProgressController;
  late Animation<double> _linearProgressAnimation;
  @override
  void initState() {

    super.initState();
    _linearProgressController = AnimationController(
      duration: Duration(seconds: 12),
      vsync: this,
    );

    _linearProgressAnimation = Tween<double>(begin: 0, end: 100).animate(_linearProgressController)
      ..addListener(() {
        setState(() {}); // Redraw the UI on each animation tick
      });
    startCountdown();
    context.read<AviatorWallet>().wallet();
    _controller = AnimationController(
      duration: const Duration(seconds: 5), // Set the animation duration
      vsync: this,
    );

    resultHistory();
  }
  void _startLinearProgressAnimation() {

      _linearProgressController.forward(); // Start the animation


  }

  late AnimationController _controllerflew;
  late Animation<Offset> _animationflew;
  planFlew() {
    _controllerflew = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animationflew = Tween<Offset>(
      begin: const Offset(0.0, 0.0),
      end: const Offset(1.0, -1.0),
    ).animate(CurvedAnimation(
      parent: _controllerflew,
      curve: Curves.easeInOut,
    ));
    _controllerflew.forward();
  }
  animationControl() async {
    _controller = AnimationController(
      duration: const Duration(seconds: 5), // Set the animation duration
      vsync: this,
    );
    _animation =
        Tween<double>(begin: 0, end: height * 0.55).animate(_controller);
    print(height * 0.60);
    print("end hight");
    _animation.addListener(() {
      setState(() {});
      if (_controller.status == AnimationStatus.completed) {
        setState(() {
          first = false;
          widths = _animation.value;
        });
        _animation = Tween<double>(begin: height * 0.40, end: height * 0.55)
            .animate(_controller);

        Future.delayed(const Duration(seconds: 10));
        animation();
      }
    });
    _controller.forward();
  }
  animation() async {
    if (planetype == 2) {
      await Future.delayed(const Duration(milliseconds: 500));
      if (_controller.status == AnimationStatus.completed) {
        _controller.reverse();
      } else if (_controller.status == AnimationStatus.dismissed) {
        _controller.forward();
      }
      animation();
    }
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height * 0.53;
    width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: const Color(0xff101011),
        appBar: AppBar(
          backgroundColor: Colors.white12,
          leading:const AppBackBtn(),
          title: const Image(
            image: AssetImage(AviatorAssets.aviatorText),
            fit: BoxFit.fitHeight,
            width: 100,
          ),
          actions: [
            Container(
              width: 150,
              decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.white12,
                    width: 4.0,
                    style: BorderStyle.solid), //Border.all
                borderRadius: const BorderRadius.all(
                  Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      '  ₹',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 15),
                    ),
                    Text(
                      context.read<AviatorWallet>().balance.toStringAsFixed(2),
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 15),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
        body:  Center(
          child: ListView(
            shrinkWrap: true,
            children: [
              const SizedBox(
                height: 10,
              ),
              expension(),
              Center(
                child: Container(
                  height: height * 0.69,
                  width: width,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.white12,
                        width: 4.0,
                        style: BorderStyle.solid), //Border.all
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: planetype == 1
                      ? Column(
                          children: [
                            SizedBox(
                              height: height * 0.60,
                              width: width * 0.98,
                              child: Row(
                                children: [
                                  Container(
                                      color: Colors.black,
                                      width: width * 0.05,
                                      height: height * 0.82,
                                      child: _rowMarquee()),
                                  Container(
                                    height: height * 0.82,
                                    width: width * 0.92,
                                    color: Colors.white,
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          bottom: -width * 1.25,
                                          left: -width * 1.25,
                                          child: Container(
                                              height: width * 2.5,
                                              width: width * 2.5,
                                              color: Colors.black.withOpacity(0.9),
                                              child: imageBg()),
                                        ),
                                        Center(
                                          child: Padding(
                                            padding:
                                                EdgeInsets.only(top: width * 0.09),
                                            child: Column(
                                              children: [
                                                AnimatedBuilder(
                                                    animation: _controllerfan,
                                                    builder: (_, child) {
                                                      return Transform.rotate(
                                                        angle:
                                                            _controllerfan.value *
                                                                1 *
                                                                math.pi,
                                                        child: Container(
                                                            height: 80,
                                                            width: 60,
                                                            decoration: const BoxDecoration(
                                                                image: DecorationImage(
                                                                    image: AssetImage(
                                                                        AviatorAssets
                                                                            .aviatorFanAviator)))),
                                                      );
                                                    }),
                                                const Center(
                                                  child: Text(
                                                    'Waiting next Round',
                                                    style: TextStyle(
                                                        fontSize: 25,
                                                        fontWeight: FontWeight.w900,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                const Center(
                                                  child: Text(
                                                    'Place Your Bet',
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight: FontWeight.w900,
                                                        color: Colors.yellow),
                                                  ),
                                                ),

                                                Container(
                                                  width: 200,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10), // Adjust the border radius as needed
                                                    border: Border.all(color: Colors.red), // Add border properties if desired
                                                  ),
                                                  child: LinearProgressIndicator(
                                                    value: _linearProgressAnimation.value / 100,
                                                    backgroundColor: Colors.grey,
                                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                                                  ),
                                                ),

                                                Text('Progress: ${_linearProgressAnimation.value.toStringAsFixed(2)}%'),

                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: height * 0.06,
                              width: width * 0.98,
                              color: Colors.black,
                              child: _buildMarquee(),
                            ),
                          ],
                        )
                      : planetype == 2
                          ? Column(
                              children: [
                                SizedBox(
                                  height: height * 0.60,
                                  width: width * 0.98,
                                  child: Row(
                                    children: [
                                      Container(
                                          color: Colors.black,
                                          width: width * 0.05,
                                          height: height * 0.82,
                                          child: _rowMarquee()),
                                      Container(
                                        height: height * 0.82,
                                        width: width * 0.92,
                                        color: Colors.white,
                                        child: Stack(
                                          children: [
                                            Positioned(
                                              bottom: -width * 1.25,
                                              left: -width * 1.25,
                                              child: Container(
                                                  height: width * 2.5,
                                                  width: width * 2.5,
                                                  color:
                                                      Colors.black.withOpacity(0.9),
                                                  child: imageBg()),
                                            ),
                                            Container(
                                              height: height * 0.92,
                                              width: width * 0.94,
                                              child: Aviator(
                                                height * 0.92,
                                                width * 0.92,
                                              ),
                                            ),
                                            Center(
                                              child: Text(
                                                '${xtime.toStringAsFixed(2)}X',
                                                style: const TextStyle(
                                                    fontSize: 50,
                                                    fontWeight: FontWeight.w900,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: height * 0.06,
                                  width: width * 0.98,
                                  color: Colors.black,
                                  child: _buildMarquee(),
                                ),
                              ],
                            )
                          : Column(
                              children: [
                                SizedBox(
                                  height: height * 0.60,
                                  width: width * 0.98,
                                  child: Row(
                                    children: [
                                      Container(
                                          color: Colors.black,
                                          width: width * 0.05,
                                          height: height * 0.82,
                                          child: _rowMarquee()),
                                      Stack(
                                        children: [
                                          Center(
                                            child: Container(
                                              height: height * 0.80,
                                              width: width * 0.89,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SlideTransition(
                                                    position: _animationflew,
                                                    child: const Center(
                                                      child: Image(
                                                        image: AssetImage(
                                                            AviatorAssets
                                                                .aviatorPlane),
                                                        height: 30,
                                                      ),
                                                    ),
                                                  ),
                                                  // Center(
                                                  //   child: ListView.builder(
                                                  //       shrinkWrap: true,
                                                  //       itemCount: number1.length,
                                                  //       itemBuilder:
                                                  //           (BuildContext context,
                                                  //               int index) {
                                                  //             // PlanCrashTimeEnd(gsm:number1[index].gamesno.toString());
                                                  //         return ;
                                                  //       }),
                                                  // ),
                                                  Center(
                                                    child: Text(
                                                      '${Result}X'
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 50,
                                                          fontWeight:
                                                          FontWeight
                                                              .w900,
                                                          color: RandomColor()
                                                              .getColor()),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: height * 0.06,
                                  width: width * 0.98,
                                  color: Colors.black,
                                  child: _buildMarquee(),
                                ),
                              ],
                            ),
                ),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              fristcome==false? Container(
                height:height*0.4,
                width: width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    buildTime5sec(countdownSeconds),
                    const Center(
                      child: Text('Wait for Previous Round End',
                          style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: Colors.yellow)

                      ),
                    ),
                  ],
                ),
              ):
              Center(
                child: betButton(),
              ),
              SizedBox(
                height: height * 0.05,
              ),
              Container(
                  width: width,
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.3),
                      borderRadius: const BorderRadius.all(Radius.circular(10))),
                  child: Column(
                    children: [
                      betHistory(),
                      _isSecondPage ? const MyBetPage() :  Padding(
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
                                reverse: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: damibet.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding:
                                    const EdgeInsets.symmetric(horizontal: 5.0, vertical: 2),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                      decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.1),
                                          border: Border.all(
                                              color: damibet[index].color ==0?Colors.white12:Colors.orangeAccent,
                                              width: 1.0,
                                              style: BorderStyle.solid),
                                          borderRadius:
                                          const BorderRadius.all(Radius.circular(10))),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                              alignment: Alignment.centerLeft,

                                              width: width * 0.3,
                                              child: Text(damibet[index].name.toString(),
                                                  style: const TextStyle(
                                                      color: Colors.white, fontSize: 10))),
                                          Container(

                                              alignment: Alignment.center,
                                              width: width * 0.2,
                                              child: Text(damibet[index].amount.toString(),
                                                  style: const TextStyle(
                                                      color: Colors.white, fontSize: 10))),
                                          Container(

                                              alignment: Alignment.center,
                                              width: width * 0.1,
                                              child: Text(damibet[index].x.toString(),
                                                  style: const TextStyle(
                                                      color: Colors.white, fontSize: 10))),
                                          Container(
                                              alignment: Alignment.centerRight,

                                              width: width * 0.2,
                                              child: Text(damibet[index].winrs.toString(),
                                                  style: const TextStyle(
                                                      color: Colors.white, fontSize: 10))),
                                        ],
                                      ),
                                    ),
                                  );
                                })
                          ],
                        ),
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }

  bool _isToggled = false;
  bool bet = false;
  bool autoBet = false;
  bool autoaCas = false;
  bool betsubmit = false;
  bool cashCollect=false;
  bool process=false;
  bool fristcome=false;


  TextEditingController amount = TextEditingController();
  final autovalue = TextEditingController(text: '1.01');

  final bool _useRtlText = false;
  double height = 150;
  double width = 300;
  double xtime = 1.0;
  bool isStart = false;
  bool isExpanded = false;
  bool _isSecondPage = false;
  List<BetList> betList = [];
  int value = 1;
  int selectedAmount = 0;

  late AnimationController _controller;
  late Animation<double> _animation;
  bool first = true;
  int planetype = 1;

  void increment() {
    setState(() {
      value = value + 1;
      deductAmount();
    });
  }

  void decrement() {
    setState(() {
      if (value > 0) {
        value = value - 1;
        deductAmount();
      }
    });
  }

  void selectam(int amount) {
    setState(() {
      selectedAmount = amount;
      value = 1;
    });
    deductAmount();
  }

  void deductAmount() {

    int amountToDeduct = selectedAmount * value;
    if (context.read<AviatorWallet>().balance >= amountToDeduct) {
      setState(() {
        amount.text = (selectedAmount * value).toString();
      });
      context.read<AviatorWallet>().updateBal(double.parse(amount.text));
    } else {
      Utils.flushBarErrorMessage('Insufficient funds', context, Colors.white);
    }
  }

  List<int> list = [
    10,
    20,
    50,
    100,
    200,
    500,
    1000
  ];

  void _toggleSwitch(bool value) {
    setState(() {
      _isSecondPage = value;
    });
  }

  void _smallToggleSwitch(bool smallValue) {
    setState(() {
      _isToggled = smallValue;
    });
  }


  Widget buildTime5sec(int time) {
    Duration myDuration =  Duration(seconds: time);
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final seconds = strDigits(myDuration.inSeconds.remainder(60));
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [

      buildTimeCard5sec(time: seconds[0].toString(), header: 'SECONDS'),
      const SizedBox(
        width: 15,
      ),
      buildTimeCard5sec(time: seconds[1].toString(), header: 'SECONDS'),
    ]);
  }
  Widget buildTimeCard5sec({required String time, required String header}) =>
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
            child:  Text(
              time,
              style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  fontSize: 40),
            ),)
        ],
      );





  int countdownSeconds = 30; // Change the initial countdown seconds to 30
  Timer? countdownTimer;
  DateTime now = DateTime.now().toUtc();
  Future<void> startCountdown() async {
    int initialSeconds = 30 - now.second; // Calculate initial remaining seconds for 30 seconds
    setState(() {

      countdownSeconds = initialSeconds;
    });

    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      updateUI(timer);
    });
  }

  void updateUI(Timer timer) {
    setState(() {

      print(countdownSeconds);
      if (countdownSeconds == 29) {
        resultHistory();

        planetype = 1;
        fristcome=true;
        Demobet();
        if(planetype==1){
          _startLinearProgressAnimation();
        }

        print('betting start animation');
        //betting start animation
      } else if (countdownSeconds == 20) {
        print('betting stop');
        betView(amount.text);
        setState(() {
          first = true;
          widths = 0;
        });
//  betting stop
      } else if (countdownSeconds == 16) {

       // resultHistory1();
        planetype = 2;
        xtime = 1.0;
        cashCollect=false;
        print('fly plane');
        Demoremove();
        crashCheck();
        animationControl();
        ximeValue();
        if(planetype==2){
          _linearProgressController.reset();
        }

        //_linearProgressController.clear();
      }

      else if (countdownSeconds == 1) {
        context.read<AviatorWallet>().wallet();
        betsubmit=false;
        if(autoBet==true){
          amount.text=amount.text;
        }else{
          betsubmit=false;
          bet=false;
          amount.text='';
        }
      }
      countdownSeconds = (countdownSeconds - 1) % 30;
    });
  }


  Widget betHistory() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Center(
        child: SlidingSwitch(
          value: _isSecondPage,
          width: width * 0.82,
          onChanged: _toggleSwitch,
          height: height * 0.075,
          animationDuration: const Duration(milliseconds: 400),
          onTap: () {},
          onDoubleTap: () {},
          onSwipe: () {},
          textOff: "All Bet",
          textOn: "My Bet",
          colorOn: Colors.white,
          colorOff: Colors.white,
          background: Colors.black,
          buttonColor: Colors.grey.withOpacity(0.5),
          inactiveColor: Colors.white,
        ),
      ),
    );
  }

  Widget expension() {
    return ExpansionTile(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      title: isExpanded
          ? const Text("Round History",
              style: TextStyle(fontSize: 12, color: Colors.white))
          : SizedBox(
              height: height * 0.05,
              width: width,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: number.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        padding: const EdgeInsets.all(3.0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.2),
                          border:
                              Border.all(color: Colors.grey.withOpacity(0.2)),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Center(
                          child: Text(
                            '${number[index].result} X',
                            style: const TextStyle(
                                fontSize: 8, color: Colors.white),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
      onExpansionChanged: (value) {
        setState(() {
          isExpanded = value;
        });
      },
      trailing: Container(
        alignment: Alignment.center,
        height: height * 0.065,
        width: width * 0.15,
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.1),
          border: Border.all(color: Colors.grey.withOpacity(0.2)),
          borderRadius: const BorderRadius.all(Radius.circular(25)),
        ),
        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.center, // Align icons in the center
          children: [
            const Icon(
              Icons.history,
              size: 16,
              color: Colors.pink,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Icon(
                isExpanded
                    ? Icons.arrow_drop_up_rounded
                    : Icons.arrow_drop_down_rounded,
                size: 28,
                color: Colors.pink,
              ),
            ),
          ],
        ),
      ),
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.3),
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10))),
          child: GridView.builder(
            shrinkWrap: true,
            itemCount: number.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 8,
              crossAxisSpacing: 2,
              childAspectRatio: 2,
              mainAxisSpacing: 2,
            ),
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(2.0),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    border: Border.all(color: Colors.grey.withOpacity(0.2)),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Text(
                    '${number[index].result} x',
                    style: TextStyle(
                        fontSize: 10, color: RandomColor().getColor()),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget betButton() {
    return Container(
      width: width ,
      // height: height * 0.6,
      decoration: BoxDecoration(
          border: Border.all(
              color: autoBet == true ? Colors.red : Colors.white12, width: 1),
          color: Colors.grey.withOpacity(0.3),
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Center(
              child: SmallSlidingSwitch(
                value: _isToggled,
                width: width * 0.50,
                onChanged: _smallToggleSwitch,
                contentSize: 20,
                height: height * 0.08,
                animationDuration: const Duration(milliseconds: 400),
                onTap: () {},
                onDoubleTap: () {},
                onSwipe: () {},
                textOff: "Bet",
                textOn: "Auto",
                colorOn: Colors.white,
                colorOff: Colors.white,
                background: Colors.black,
                buttonColor: Colors.grey.withOpacity(0.5),
                inactiveColor: Colors.white,
              ),
            ),
            const Divider(
              color: Colors.transparent,
              height: 10,
            ),
            SizedBox(
              height: height * 0.06,
              width: width * 0.60,
              child: TextFormField(
                controller: amount,
                readOnly: true,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, color: Colors.white),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(0),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: InkWell(
                        onTap: decrement,
                        child: const Image(
                          image: AssetImage(AviatorAssets.aviatorMinus),
                        )),
                  ),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: InkWell(
                        onTap: increment,
                        child: const Image(
                          image: AssetImage(AviatorAssets.aviatorPlus),
                        )),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    borderSide: BorderSide(color: Colors.grey, width: 1),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    borderSide: BorderSide(color: Colors.grey, width: 1),
                  ),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.all(
                      Radius.circular(12.0),
                    ),
                  ),
                  focusedErrorBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    borderSide: BorderSide(color: Color(0xFFF65054)),
                  ),
                  errorBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    borderSide: BorderSide(color: Color(0xFFF65054)),
                  ),
                  hintText: "Enter ",
                  hintStyle: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w400),
                  fillColor: Colors.black,
                  filled: true,
                ),
              ),
            ),
            const Divider(
              color: Colors.transparent,
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: height * 0.18,
                  width: width * 0.60,
                  child: GridView.builder(
                    shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5,
                        childAspectRatio: 2.5,
                      ),
                      itemCount: 6,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            selectam(list[index]);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.4),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(30.0)),
                              border: Border.all(
                                  color: Colors.grey.withOpacity(0.3)),
                            ),
                            child: Center(
                              child: Text(
                                '${list[index]} ₹',
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
                if (bet == false )
                  InkWell(
                    onTap: () {
                      setState(() {
                        if (amount.text.isEmpty) {
                          Utils.flushBarErrorMessage(
                              'Select Amount First..!', context, Colors.white);
                        } else if (amount.text == '0') {
                          Utils.flushBarErrorMessage(
                              'Select Amount First..!', context, Colors.white);
                        } else {
                          bet = true;

                        }
                      });
                    },
                    child: Image(
                      image: const AssetImage(AviatorAssets.aviatorBet),
                      width: width * 0.30,

                    ),
                  )
                else if (planetype == 2 && bet == true && betsubmit==true && cashCollect==false)
                  InkWell(
                    onTap: (){
                      if(process==false) {
                        cashout(amount.text,xtime.toStringAsFixed(2));
                      }

                    },
                    child: Container(
                      height: 40,
                       width: width * 0.30,
                      decoration:  BoxDecoration(
                          borderRadius:
                          const BorderRadius.all(Radius.circular(10.0)),
                          border: Border.all(
                            width: 2,
                              color: Colors.white),
                        color: Colors.orange
                      ),
                      child:  Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                                 const Text('Cash Out',style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
                        Text((int.parse(amount.text)*xtime).toStringAsFixed(2),style: const TextStyle(fontSize: 10,fontWeight: FontWeight.w700)),
                        ],
                      ),
                    )

                  )
                else if (planetype == 1 && bet == true )
                  InkWell(
                    onTap: () {
                      setState(() {
                        amount.clear();
                        bet = false;
                      });
                    },
                    child: Image(
                      image: const AssetImage(AviatorAssets.aviatorCancel),
                      width: width * 0.30,
                    ),
                  )
                else InkWell(
                      onTap: () {
                        setState(() {
                          if (amount.text.isEmpty) {
                            Utils.flushBarErrorMessage(
                                'Select Amount First..!', context, Colors.white);
                          } else if (amount.text == '0') {
                            Utils.flushBarErrorMessage(
                                'Select Amount First..!', context, Colors.white);
                          } else {
                            bet = true;
                          }
                        });
                      },
                      child: Image(
                        image: const AssetImage(AviatorAssets.aviatorBet),
                        width: width * 0.30,
                      ),
                    )
              ],
            ),
            const Divider(
              color: Colors.transparent,
              height: 10,
            ),
            !_isToggled
                ? Container()
                : Padding(
                    padding: const EdgeInsets.only(left: 3, right: 2),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Text(
                              "Auto Bet  ",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            CustomSwitch(
                              width: width * 0.12,
                              height: height * 0.05,
                              toggleSize: height * 0.04,
                              value: autoBet,
                              borderRadius: 20.0,
                              padding: 2.0,
                              toggleColor: Colors.white,
                              switchBorder: Border.all(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                              toggleBorder: Border.all(
                                color: Colors.white,
                                width: 20.0,
                              ),
                              activeColor: Colors.green,
                              inactiveColor: Colors.grey.withOpacity(0.2),
                              onToggle: (val) {
                                setState(() {
                                  autoBet = val;
                                });
                              },
                            ),
                            const Text(
                              "  Cashout  ",
                              style:
                              TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            CustomSwitch(
                              width: width * 0.12,
                              height: height * 0.05,
                              toggleSize: height * 0.04,
                              value: autoaCas,
                              borderRadius: 20.0,
                              padding: 2.0,
                              toggleColor: Colors.white,
                              switchBorder: Border.all(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                              toggleBorder: Border.all(
                                color: Colors.white,
                                width: 20.0,
                              ),
                              activeColor: Colors.green,
                              inactiveColor: Colors.grey.withOpacity(0.2),
                              onToggle: (val) {
                                setState(() {
                                  autoaCas = val;
                                });
                              },
                            ),
                            SizedBox(
                              width: width * 0.03,
                            ),
                            SizedBox(
                              height: height * 0.055,
                              width: width * 0.2,
                              child: TextFormField(
                                enabled: autoaCas,
                                controller: autovalue,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 15, color: Colors.white),
                                textAlignVertical: TextAlignVertical.top,
                                keyboardType: TextInputType.number,
                                // style: RighteousMedium.copyWith(fontSize: heights * 0.019, color: Colors.white),
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(0),
                                  suffix: InkWell(
                                      onTap: () {
                                        setState(() {
                                          autovalue.clear();
                                        });
                                      },
                                      child: const Icon(
                                        Icons.cancel,
                                        size: 22,
                                      )),
                                  enabledBorder: const OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(30.0)),
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 1),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(12.0)),
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 1),
                                  ),
                                  border: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(12.0),
                                    ),
                                  ),
                                  focusedErrorBorder: const OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(15.0)),
                                    borderSide:
                                    BorderSide(color: Color(0xFFF65054)),
                                  ),
                                  errorBorder: const OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(12.0)),
                                    borderSide:
                                    BorderSide(color: Color(0xFFF65054)),
                                  ),
                                  hintStyle: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                  fillColor: Colors.grey.withOpacity(0.3),
                                  filled: true,
                                ),
                              ),
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildMarquee() {
    return CustomMarquee(
      key: Key("$_useRtlText"),
      text: '🏐',
      style: const TextStyle(
          fontWeight: FontWeight.w900, fontSize: 4, color: Colors.white),
      velocity: 30.0,
      blankSpace: width * 0.15,
    );
  }

  Widget imageBg() {
    return AnimatedBuilder(
        animation: _controllers,
        builder: (_, child) {
          return Transform.rotate(
            angle: _controllers.value * 170 * math.pi,
            child: const Image(
              image: AssetImage(AviatorAssets.aviatorChakra),
            ),
          );
        });
  }

  Widget _rowMarquee() {
    return CustomMarquee(
      key: Key("$_useRtlText"),
      text: '          🏐          ',
      style: TextStyle(
          fontWeight: FontWeight.w900,
          fontSize: 4,
          color: Colors.blueAccent.shade700),
      velocity: 30.0,
      textDirection: TextDirection.rtl,
      scrollAxis: Axis.vertical,
      blankSpace: height * 0.1,
    );
  }

  double widths = 0;

  Aviator(double height, double width) {
    return SizedBox(
      height: height,
      width: width,
      child: Container(
        alignment: Alignment.bottomLeft,
        height: _animation.value,
        width: _animation.value,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            first == true
                ? CustomPaint(
                    painter: MyPainter(_animation.value),
                    size: Size(_animation.value, _animation.value / 1.5),
                  )
                : CustomPaint(
                    painter: MyPainter(_animation.value),
                    size: Size(widths + (widths - _animation.value),
                        _animation.value / 1.5),
                  ),
            Positioned(
                right: -width * 0.2,
                top: -height * 0.10,
                child: const Image(
                    image: AssetImage(AviatorAssets.aviatorPlane),
                    height: 40,
                    width: 100)),
          ],
        ),
      ),
    );
  }
  var rnd= new Random();

  List <Demo>damibet=[];
  // Demoremove()async{
  //   for(var i=0; i<40; i++) {
  //     int amount = rnd.nextInt(40);
  //     int memid = rnd.nextInt(2000);
  //
  //     int amount1 = rnd.nextInt(40);
  //     int memid1 = rnd.nextInt(2000);
  //
  //     int amount2 = rnd.nextInt(40);
  //     int memid2 = rnd.nextInt(2000);
  //
  //     int amount3 = rnd.nextInt(40);
  //     int memid3 = rnd.nextInt(2000);
  //
  //     int amount4 = rnd.nextInt(40);
  //     int memid4 = rnd.nextInt(2000);
  //     await Future.delayed(const Duration(milliseconds: 200));
  //     int indexToUpdate = rnd.nextInt(70); // Index of the element to update
  //     int indexToUpdate1 = rnd.nextInt(70); // Index of the element to update
  //     int indexToUpdate2 = rnd.nextInt(70); // Index of the element to update
  //     int indexToUpdate3 = rnd.nextInt(70); // Index of the element to update
  //     int indexToUpdate4 = rnd.nextInt(70); // Index of the element to update
  //
  //     damibet[indexToUpdate] = Demo(name: 'Memberid$memid',
  //       amount: double.parse((amount * 10).toString()),
  //       x: xtime.toStringAsFixed(2),
  //       winrs: (double.parse((amount * 10).toString()) * xtime)
  //           .toStringAsFixed(2), color: 1);
  //    damibet[indexToUpdate1] = Demo(name: 'Memberid$memid1',
  //       amount: double.parse((amount1 * 10).toString()),
  //       x: xtime.toStringAsFixed(2),
  //       winrs: (double.parse((amount1 * 10).toString()) * xtime)
  //           .toStringAsFixed(2), color: 1);
  //
  //     damibet[indexToUpdate2] = Demo(name: 'Memberid$memid2',
  //       amount: double.parse((amount2 * 10).toString()),
  //       x: xtime.toStringAsFixed(2),
  //       winrs: (double.parse((amount2 * 10).toString()) * xtime)
  //           .toStringAsFixed(2), color: 1);
  //
  //     damibet[indexToUpdate3] = Demo(name: 'Memberid$memid3',
  //       amount: double.parse((amount3 * 10).toString()),
  //       x: xtime.toStringAsFixed(2),
  //       winrs: (double.parse((amount3 * 10).toString()) * xtime)
  //           .toStringAsFixed(2), color: 1);
  //     damibet[indexToUpdate4] = Demo(name: 'Memberid$memid4',
  //       amount: double.parse((amount4 * 10).toString()),
  //       x: xtime.toStringAsFixed(2),
  //       winrs: (double.parse((amount4 * 10).toString()) * xtime)
  //           .toStringAsFixed(2), color: 1);
  //     setState(() {});
  //
  //     await Future.delayed(const Duration(milliseconds: 300));
  //
  //     // Removing the element after the delay
  //     damibet.removeAt(indexToUpdate);
  //     damibet.removeAt(indexToUpdate1);
  //     damibet.removeAt(indexToUpdate2);
  //     damibet.removeAt(indexToUpdate3);
  //     damibet.removeAt(indexToUpdate4);
  //   setState(() {});
  //   }
  //   }
  void Demoremove() async {
    for (var i = 0; i < 40; i++) {
      int amount = rnd.nextInt(40);
      int memid = rnd.nextInt(2000);

      await Future.delayed(const Duration(milliseconds: 200));

      int indexToUpdate = rnd.nextInt(damibet.length);

      if (indexToUpdate < damibet.length) {
        damibet[indexToUpdate] = Demo(
          name: 'Memberid$memid',
          amount: double.parse((amount * 10).toString()),
          x: xtime.toStringAsFixed(2),
          winrs: (double.parse((amount * 10).toString()) * xtime).toStringAsFixed(2),
          color: 1,
        );
      }

      setState(() {});

      await Future.delayed(const Duration(milliseconds: 300));

      if (indexToUpdate < damibet.length) {
        damibet.removeAt(indexToUpdate);
      }

      setState(() {});
    }
  }

  Demobet()async{
    if(planetype == 1){
  for(var i=0; i<80; i++){
    int memid=rnd.nextInt(2000);
    int amount=rnd.nextInt(9);
    await Future.delayed(const Duration(milliseconds: 500));
    damibet.add(Demo(name: 'Memberid$memid', amount: double.parse((amount*10).toString()), x: '', winrs: '', color: 0));
    setState(() {});
  }
}
  }

  AvitorResultMatch(String time)async{
    if(time=='wait'){
      await Future.delayed(const Duration(seconds: 1));
      crashCheck();
    }}

    AvitorDirectResultMatch()async {
   final times= res =='wait'?'7.0':res;
   print('panm');
   print(times);
   if(planetype==2)
    if (double.parse(xtime.toStringAsFixed(2)) >= double.parse(times)) {
      print('ttttttttt');
      damibet.clear();
        setState(() {
          Result=res.toString();

          planetype = 3;
        });
      planFlew();
      resultHistory();
    }
  }



  @override
  void dispose() {
    _controller.dispose();
    _linearProgressController.dispose();
    _controllerflew.dispose();
    countdownTimer?.cancel();
    super.dispose();
  }
  Future<bool> _onWillPop() async {

    countdownTimer?.cancel();
    Navigator.of(context, rootNavigator: true).pop(context);
    return true;
  }

String gmaesno='';
  String Result='';
  List<ResultHistoryModel> number = [];
  Future<void> resultHistory() async {
    const url = '${ApiUrl.resultHistory}16';
    print(url);
    final response = await http.get(Uri.parse(url));
    if (kDebugMode) {
      print(url);
    }
    if (response.statusCode == 200) {

      final List<dynamic> responseData = json.decode(response.body)['data'];
      print(responseData);
      setState(() {
        gmaesno=  (int.parse(responseData[0]['gamesno'].toString())+1).toString();
        number = responseData
            .map((item) => ResultHistoryModel.fromJson(item))
            .toList();
      });
    } else if (response.statusCode == 400) {
      if (kDebugMode) {
        print('Data not found');
      }
    } else {
      setState(() {
        number = [];
      });
      throw Exception('Failed to load data');
    }
  }

  // List<ResultHistoryModel> number1 = [];
  // Future<void> resultHistory1() async {
  //   const url = '${ApiUrl.resultHistory}1';
  //   final response = await http.get(Uri.parse(url));
  //   if (kDebugMode) {
  //     print(url);
  //   }
  //   if (response.statusCode == 200) {
  //     final List<dynamic> responseData = json.decode(response.body)['data'];
  //     setState(() {
  //
  //       number1 = responseData
  //           .map((item) => ResultHistoryModel.fromJson(item))
  //           .toList();
  //     });
  //   } else if (response.statusCode == 400) {
  //     if (kDebugMode) {
  //       print('Data not found');
  //     }
  //   } else {
  //     setState(() {
  //       number1 = [];
  //     });
  //     throw Exception('Failed to load data');
  //   }
  // }




  /// cashout
  cashout(String amount,String times) async {
    setState(() {
      process=true;
    });
    UserModel user = await userProvider.getUser();
    String userid = user.id.toString();
    setState(() {
      // loadingGreen = true;
    });
    print('ggggggggggggggggg');
    print("${ApiUrl.aviatorCashout}userid=$userid&amount=$amount&multiplier=$times&gamesno=$gmaesno");
    final response = await http.get(
      Uri.parse("${ApiUrl.aviatorCashout}userid=$userid&amount=$amount&multiplier=$times&gamesno=$gmaesno"));
    var data = jsonDecode(response.body);
    print(data);

    if (data["error"] == "200") {
      setState(() {
        cashCollect=true;
        betsubmit=false;
        process=false;
      });
      Utils.flushBarSuccessMessage(data['msg'], context, Colors.black);

    }
    else {
      setState(() {
        // loadingGreen = false;
      });
      Utils.flushBarErrorMessage(data['msg'], context, Colors.black);
    }

  }
String res='';
  crashCheck() async {
    int games=int.parse(gmaesno);
    print("${ApiUrl.crashCheckApi}gamesno=$games&multiplier=$xtime");
    final response = await http.get(
      Uri.parse("${ApiUrl.crashCheckApi}gamesno=$games&multiplier=$xtime"),
    );
    var data = jsonDecode(response.body);
    print(data);
    print('rrrrrrrrr');
    if (response.statusCode == 200) {
      setState(() {
        res=data['message'].toString();
      });
      if(data['message'].toString()!="1.0") {
        AvitorResultMatch(data['message'].toString());
      }
    }
  }

  UserViewProvider userProvider = UserViewProvider();

  betView(String amount) async {

    UserModel user = await userProvider.getUser();
    String userid = user.id.toString();

    print("${ApiUrl.betPlaced}userid=$userid&amount=$amount");
    setState(() {
      // loadingGreen = true;
    });
    final response = await http.get(
      Uri.parse("${ApiUrl.betPlaced}userid=$userid&amount=$amount"));

    var data = jsonDecode(response.body);
    print(data);
    print('data');
    if (data["error"] == "200") {
      setState(() {
        betsubmit=true;
      });
      print('rrrrrrrr');
      Utils.flushBarSuccessMessage(data['msg'], context, Colors.black);


    } else {
      setState(() {
        // loadingGreen = false;
      });
      Utils.flushBarErrorMessage(data['msg'], context, Colors.black);
    }
  }
}

class Demo {
  String name;
  double amount;
  String x;
  String winrs;
  int color;
Demo({required this.name,required this.amount,required this.x,required this.winrs,required this.color});
}

class MyPainter extends CustomPainter {
  final double animationValue;

  MyPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final path = drawPath(size.width, size.height, animationValue);

    final paint = Paint()
      ..color = Colors.redAccent.withOpacity(0.7)
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = Colors.red.shade900 // Change border color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0; // Change border width

    canvas.drawPath(path, paint);
    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

Path drawPath(double canvasWidth, double chartHeight, double animationValue) {
  final path = Path();
  final segmentWidth = canvasWidth / 2 / 2;
  path.moveTo(0, chartHeight);
  path.cubicTo(
    segmentWidth,
    chartHeight,
    4 * segmentWidth,
    80,
    canvasWidth,
    0,
  );
  path.lineTo(canvasWidth, chartHeight);
  path.close();

  return path;
}

class BetList {
  final String name;
  final int amount;
  final double cashout;
  BetList({required this.name, required this.amount, required this.cashout});
}




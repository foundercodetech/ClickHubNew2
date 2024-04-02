// ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously, camel_case_types

import 'dart:async';
import 'dart:convert';
import 'package:ClickHub/model/bettingHistory_Model.dart';
import 'package:ClickHub/model/user_model.dart';
import 'package:ClickHub/res/api_urls.dart';
import 'package:ClickHub/res/app_constant.dart';
import 'package:ClickHub/res/components/clipboard.dart';
import 'package:ClickHub/res/helper/api_helper.dart';
import 'package:ClickHub/res/provider/user_view_provider.dart';
import 'package:ClickHub/res/provider/wallet_provider.dart';
import 'package:ClickHub/view/DummyGrid.dart';
import 'package:ClickHub/view/bottom/bottom_nav_bar.dart';
import 'package:ClickHub/view/test.dart';
import 'package:ClickHub/view/wallet/deposit_screen.dart';
import 'package:ClickHub/view/wallet/withdraw_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:ClickHub/generated/assets.dart';
import 'package:ClickHub/res/aap_colors.dart';
import 'package:ClickHub/res/components/app_bar.dart';
import 'package:ClickHub/res/components/app_btn.dart';
import 'package:ClickHub/res/components/commonbottomsheet.dart';
import 'package:ClickHub/res/components/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class WinGoScreen extends StatefulWidget {
  const WinGoScreen({super.key});

  @override
  _WinGoScreenState createState() => _WinGoScreenState();
}

class _WinGoScreenState extends State<WinGoScreen>
    with SingleTickerProviderStateMixin {
  late int selectedCatIndex;

  @override
  void initState() {
    startCountdown();
    walletfetch();
    parityRecord(1);
    parityRecords(1);
    bettingHistory();
    super.initState();
    selectedCatIndex = 0;
  }

  int selectedContainerIndex = -1;

  List<BetNumbers> betNumbers = [
    BetNumbers(Assets.images0, Colors.red, Colors.purple, "0"),
    BetNumbers(Assets.images1, Colors.green, Colors.green, "1"),
    BetNumbers(Assets.images2, Colors.red, Colors.red, "2"),
    BetNumbers(Assets.images3, Colors.green, Colors.green, "3"),
    BetNumbers(Assets.images4, Colors.red, Colors.red, "4"),
    BetNumbers(Assets.images5, Colors.red, Colors.purple, "5"),
    BetNumbers(Assets.images6, Colors.red, Colors.red, "6"),
    BetNumbers(Assets.images7, Colors.green, Colors.green, "7"),
    BetNumbers(Assets.images8, Colors.red, Colors.red, "8"),
    BetNumbers(Assets.images9, Colors.green, Colors.green, "9"),
  ];

  List<Winlist> list = [
    Winlist(1, "Win Go", "1 Min", 60),
    Winlist(2, "Win Go", "3 Min", 180),
    Winlist(3, "Win Go", "5 Min", 300),
    Winlist(4, "Win Go", "10 Min", 600),
  ];

  int countdownSeconds = 60;
  int gameSeconds = 60;
  String gameTitle = 'Wingo';
  String subtitle = '1 Min';
  Timer? countdownTimer;

  Future<void> startCountdown() async {
    DateTime now = DateTime.now().toUtc();
    int minutes = now.minute;
    int minsec = minutes * 60;
    int initialSeconds = 60;
    if (gameSeconds == 60) {
      initialSeconds =
          gameSeconds - now.second; // Calculate initial remaining seconds
    } else if (gameSeconds == 180) {
      for (var i = 0; i < 20; i++) {
        if (minsec >= 180) {
          minsec = minsec - 180;
        } else {
          initialSeconds = gameSeconds -
              minsec -
              now.second; // Calculate initial remaining seconds
        }
        print(initialSeconds);
      }
    } else if (gameSeconds == 300) {
      for (var i = 0; i < 12; i++) {
        if (minsec >= 300) {
          minsec = minsec - 300;
        } else {
          initialSeconds = gameSeconds -
              minsec -
              now.second; // Calculate initial remaining seconds
        }
      }
    } else if (gameSeconds == 600) {
      for (var i = 0; i < 6; i++) {
        if (minsec >= 600) {
          minsec = minsec - 600;
        } else {
          initialSeconds = gameSeconds -
              minsec -
              now.second; // Calculate initial remaining seconds
        }
      }
    }
    setState(() {
      countdownSeconds = initialSeconds;
    });
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      gameconcept(countdownSeconds);
      updateUI(timer);
    });
  }

  void updateUI(Timer timer) {
    setState(() {
      if (countdownSeconds == 5) {
      } else if (countdownSeconds == 0) {
        countdownSeconds = gameSeconds;
        walletfetch();
        parityRecord(1);
        parityRecords(1);
        bettingHistory();
        gameWinPopup();
      }
      countdownSeconds = (countdownSeconds - 1);
    });
  }

  int? responseStatusCode;

  @override
  void dispose() {
    countdownSeconds.toString();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final walletdetails = Provider.of<WalletProvider>(context).walletlist;
    final widths = MediaQuery.of(context).size.width;
    final heights = MediaQuery.of(context).size.height;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: GradientAppBar(
          leading: Padding(
            padding: const EdgeInsets.fromLTRB(15, 5, 5, 5),
            child: GestureDetector(
                onTap: () {
                  countdownTimer!.cancel();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BottomNavBar()));
                },
                child: SvgPicture.asset(Assets.iconsArrowBack)),
          ),
          title: SvgPicture.asset(
            Assets.imagesAppBarSecond,
            height: 40,
          ),
          gradient: AppColors.primaryGradient,
        ),
        body: Container(
          height: heights,
          width: widths,
          child: SingleChildScrollView(
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  height: heights / 2.8,
                  decoration: const BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(50),
                          bottomRight: Radius.circular(50))),
                ),
                Column(
                  children: [
                    const SizedBox(height: 20),
                    Container(
                      margin: const EdgeInsets.only(right: 10, left: 10),
                      decoration: BoxDecoration(
                          color: AppColors.primaryContColor,
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.currency_rupee_outlined, size: 20),
                              textWidget(
                                  text: walletdetails == null
                                      ? ""
                                      : walletdetails.wallet.toString(),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                              const SizedBox(
                                width: 10,
                              ),
                              SvgPicture.asset(Assets.iconsTotalBal, height: 30)
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(Assets.iconsRedWallet, height: 30),
                              textWidget(
                                  text: '  Wallet Balance',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18)
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              AppBtn(
                                width: widths * 0.4,
                                height: 38,
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const WithdrawScreen()));
                                },
                                title: 'Withdraw',
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                                gradient: AppColors.containerGreenGradient,
                                hideBorder: true,
                              ),
                              AppBtn(
                                width: widths * 0.4,
                                height: 38,
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const DepositScreen()));
                                },
                                title: 'Deposit',
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                                hideBorder: true,
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 70,
                      margin: const EdgeInsets.only(right: 10, left: 10),
                      color: AppColors.primaryContColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Icon(Icons.volume_up,
                              color: AppColors.gradientFirstColor),
                          textWidget(
                            text: 'Welcome to ${AppConstants.appName}',
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                          AppBtn(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RandomList()));
                            },
                            height: 25,
                            width: widths * 0.30,
                            title: '🔥 Details',
                            titleColor: AppColors.primaryTextColor,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: heights * 0.18,
                      margin: const EdgeInsets.only(left: 10, right: 10),
                      decoration: BoxDecoration(
                        color: AppColors.primaryContColor,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.grey.withOpacity(0.2)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(list.length, (index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedCatIndex = index;
                                subtitle = list[index].subtitle;
                                gameSeconds = list[index].time;
                                gameId = list[index].gameid;
                              });
                              countdownTimer!.cancel();
                              startCountdown();
                              offsetResult = 0;
                              parityRecord(list[index].gameid);
                              parityRecords(list[index].gameid);
                            },
                            child: Container(
                              height: heights * 0.28,
                              width: widths * 0.23,
                              decoration: BoxDecoration(
                                gradient: selectedCatIndex == index
                                    ? const LinearGradient(
                                        colors: [Colors.red, Colors.white],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      )
                                    : const LinearGradient(
                                        colors: [
                                          Colors.transparent,
                                          Colors.transparent
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                children: [
                                  selectedCatIndex == index
                                      ? SvgPicture.asset(Assets.iconsTimeColor,
                                          height: 70)
                                      : SvgPicture.asset(Assets.iconsTime,
                                          height: 70),
                                  textWidget(
                                      text: list[index].title,
                                      color: selectedCatIndex == index
                                          ? AppColors.gradientFirstColor
                                          : AppColors.textBlack,
                                      fontSize: 14),
                                  textWidget(
                                      text: list[index].subtitle,
                                      color: selectedCatIndex == index
                                          ? AppColors.gradientFirstColor
                                          : AppColors.textBlack,
                                      fontSize: 14),
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10, right: 10),
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(Assets.imagesBgCut),
                              fit: BoxFit.fill)),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  // Navigator.push(context, MaterialPageRoute(builder: (context)=>const HowtoplayScreen()));
                                },
                                child: Container(
                                    padding:
                                        const EdgeInsets.symmetric(horizontal: 8),
                                    height: 26,
                                    width: widths * 0.35,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        border: Border.all(
                                            color:
                                                AppColors.containerBorderWhite)),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          Assets.iconsHowtoplay,
                                          height: 16,
                                        ),
                                        const Text(
                                          ' How to Play',
                                          style: TextStyle(
                                              color: AppColors.primaryTextColor),
                                        ),
                                      ],
                                    )),
                              ),
                              Text(
                                'Win Go $subtitle',
                                style: const TextStyle(
                                    color: AppColors.primaryTextColor),
                              ),
                              listData.isEmpty
                                  ? Container()
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: List.generate(
                                        5,
                                        (index) => Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Image(
                                            image: AssetImage(betNumbers[
                                                    int.parse(
                                                        listData[index].number)]
                                                .photo),
                                            height: 25,
                                          ),
                                        ),
                                      ))
                            ],
                          ),
                          const Spacer(),
                          Column(
                            children: [
                              const Text(
                                'Time Remaining',
                                style: TextStyle(
                                    color: AppColors.primaryTextColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              buildTime1(countdownSeconds),
                              Text(
                                period.toString(),
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.primaryTextColor),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    create == false
                        ? Container(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        showModalBottomSheet(
                                            isScrollControlled: true,
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                    topRight: Radius.circular(25),
                                                    topLeft:
                                                        Radius.circular(25))),
                                            context: (context),
                                            builder: (BuildContext context) {
                                              return CommonBottomSheet(
                                                  colors: const [
                                                    Colors.green,
                                                    Colors.green
                                                  ],
                                                  colorName: "Green",
                                                  predictionType: "10",
                                                  gameid: gameId);
                                            });
                                        await Future.delayed(
                                            const Duration(seconds: 5));
                                        bettingHistory();
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: 40,
                                        width: widths * 0.28,
                                        decoration: const BoxDecoration(
                                            color: Colors.green,
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(10),
                                                bottomLeft: Radius.circular(10))),
                                        child: textWidget(
                                            text: 'Green',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.primaryTextColor),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        showModalBottomSheet(
                                            isScrollControlled: true,
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                    topRight: Radius.circular(25),
                                                    topLeft:
                                                        Radius.circular(25))),
                                            context: (context),
                                            builder: (context) {
                                              return CommonBottomSheet(
                                                colors: const [
                                                  Colors.purple,
                                                  Colors.purple
                                                ],
                                                colorName: "Violet",
                                                predictionType: "20",
                                                gameid: gameId,
                                              );
                                            });
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: 40,
                                        width: widths * 0.28,
                                        decoration: const BoxDecoration(
                                            color: Colors.purple,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                        child: textWidget(
                                            text: 'Violet',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.primaryTextColor),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        showModalBottomSheet(
                                            isScrollControlled: true,
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                    topRight: Radius.circular(25),
                                                    topLeft:
                                                        Radius.circular(25))),
                                            context: (context),
                                            builder: (context) {
                                              return CommonBottomSheet(
                                                colors: const [
                                                  Colors.red,
                                                  Colors.red
                                                ],
                                                colorName: "Red",
                                                predictionType: "30",
                                                gameid: gameId,
                                              );
                                            });
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: 40,
                                        width: widths * 0.28,
                                        decoration: const BoxDecoration(
                                            color: Colors.red,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10))),
                                        child: textWidget(
                                            text: 'Red',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.primaryTextColor),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.only(left: 10, right: 10),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 3, horizontal: 3),
                                  decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.2),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10))),
                                  child: GridView.builder(
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 5,
                                      crossAxisSpacing: 8.0,
                                      mainAxisSpacing: 8.0,
                                    ),
                                    shrinkWrap: true,
                                    itemCount: 10,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return InkWell(
                                        onTap: () {
                                          showModalBottomSheet(
                                              isScrollControlled: true,
                                              shape: const RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.only(
                                                      topRight:
                                                          Radius.circular(25),
                                                      topLeft:
                                                          Radius.circular(25))),
                                              context: (context),
                                              builder: (context) {
                                                return CommonBottomSheet(
                                                  colors: [
                                                    betNumbers[index].colorone,
                                                    betNumbers[index].colortwo
                                                  ],
                                                  colorName: betNumbers[index]
                                                      .number
                                                      .toString(),
                                                  predictionType:
                                                      betNumbers[index]
                                                          .number
                                                          .toString(),
                                                  gameid: gameId,
                                                );
                                              });
                                        },
                                        child: Image(
                                          image: AssetImage(
                                              betNumbers[index].photo.toString()),
                                          height: heights / 15,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        showModalBottomSheet(
                                            isScrollControlled: true,
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                    topRight: Radius.circular(25),
                                                    topLeft:
                                                        Radius.circular(25))),
                                            context: (context),
                                            builder: (context) {
                                              return CommonBottomSheet(
                                                colors: const [
                                                  Color(0xFF15CEA2),
                                                  Color(0xFFB6FFE0)
                                                ],
                                                colorName: "Big",
                                                predictionType: "40",
                                                gameid: gameId,
                                              );
                                            });
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: 40,
                                        width: widths * 0.35,
                                        decoration: const BoxDecoration(
                                            gradient:
                                                AppColors.containerGreenGradient,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(50),
                                                bottomLeft: Radius.circular(50))),
                                        child: textWidget(
                                            text: 'Big',
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.primaryTextColor),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        showModalBottomSheet(
                                            isScrollControlled: true,
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                    topRight: Radius.circular(25),
                                                    topLeft:
                                                        Radius.circular(25))),
                                            context: (context),
                                            builder: (context) {
                                              return CommonBottomSheet(
                                                colors: const [
                                                  Color(0xFF6da7f4),
                                                  Color(0xFF6da7f4)
                                                ],
                                                colorName: "Small",
                                                predictionType: "50",
                                                gameid: gameId,
                                              );
                                            });
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: 40,
                                        width: widths * 0.35,
                                        decoration: const BoxDecoration(
                                            gradient: AppColors.btnBlueGradient,
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(50),
                                                bottomRight:
                                                    Radius.circular(50))),
                                        child: textWidget(
                                            text: 'Small',
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.primaryTextColor),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        : Stack(
                            children: [
                              const DummyGrid(),
                              Container(
                                height: 250,
                                color: Colors.black26,
                                child: buildTime5sec(countdownSeconds),
                              ),
                            ],
                          ),
                    const SizedBox(height: 15),
                    winGoResult()
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  bool create = false;
  int period = 0;
  int gameId = 1;
  List<parityrecord> listData = [];
  parityRecord(int gameId) async {
    print("${ApiUrl.colorresult}limit=5&offset=0&gameid=$gameId");
    final response = await http
        .get(Uri.parse("${ApiUrl.colorresult}limit=0&offset=0&gameid=$gameId"));
    print(jsonDecode(response.body));
    if (response.statusCode == 200) {
      listData.clear();
      final jsonData = json.decode(response.body)['data'];
      setState(() {
        period = int.parse(jsonData[0]['gamesno'].toString()) + 1;
      });
      for (var i = 0; i < jsonData.length; i++) {
        var period = jsonData[i]['gamesno'];
        var number = jsonData[i]['number'];
        listData.add(parityrecord(period, number));
      }

      // return jsonData.map((item) => partlyrecord.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  int pageNumber = 1;
  int selectedTabIndex = 0;

  Widget winGoResult() {
    setState(() {});
    final widths = MediaQuery.of(context).size.width;
    final heights = MediaQuery.of(context).size.width;

    return listDataResult != []
        ? Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildTabContainer(
                    'Game History',
                    0,
                    widths,
                    Colors.red,
                  ),
                  buildTabContainer('Chart', 1, widths, Colors.red),
                  buildTabContainer('My History', 2, widths, Colors.red),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              selectedTabIndex == 0
                  ? Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          margin: const EdgeInsets.only(left: 10, right: 10),
                          decoration: const BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  topLeft: Radius.circular(10))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                width: widths * 0.3,
                                child: textWidget(
                                    text: 'Period',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w900,
                                    color: AppColors.primaryTextColor),
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: widths * 0.21,
                                child: textWidget(
                                    text: 'Number',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w900,
                                    color: AppColors.primaryTextColor),
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: widths * 0.21,
                                child: textWidget(
                                    text: 'Big Small',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w900,
                                    color: AppColors.primaryTextColor),
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: widths * 0.21,
                                child: textWidget(
                                    text: 'Color',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w900,
                                    color: AppColors.primaryTextColor),
                              ),
                            ],
                          ),
                        ),
                        ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: listDataResult.length,
                          itemBuilder: (context, index) {
                            List<Color> colors;

                            if (listDataResult[index].number == '0') {
                              colors = [
                                const Color(0xFFfd565c),
                                const Color(0xFFb659fe),
                              ];
                            } else if (listDataResult[index].number == '5') {
                              colors = [
                                const Color(0xFF40ad72),
                                const Color(0xFFb659fe),
                              ];
                            } else {
                              int number = int.parse(
                                  listDataResult[index].number.toString());
                              colors = number.isOdd
                                  ? [
                                      const Color(0xFF40ad72),
                                      const Color(0xFF40ad72),
                                    ]
                                  : [
                                      const Color(0xFFfd565c),
                                      const Color(0xFFfd565c),
                                    ];
                            }

                            Color getCircleAvatarColor(int number) {
                              return number.isOdd
                                  ? const Color(0xFF40ad72)
                                  : const Color(0xFFfd565c);
                            }

                            return Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      width: widths * 0.3,
                                      child: textWidget(
                                        text: listDataResult[index].period,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        maxLines: 1,
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: widths * 0.21,
                                      child: GradientTextview(
                                        listDataResult[index].number.toString(),
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w900,
                                        ),
                                        gradient: LinearGradient(
                                          colors: colors,
                                          stops: const [0.5, 0.5],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          tileMode: TileMode.mirror,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: widths * 0.21,
                                      child: GradientTextview(
                                        int.parse(listDataResult[index]
                                                    .number
                                                    .toString()) <
                                                5
                                            ? 'Small'
                                            : 'Big',
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w900),
                                        gradient: LinearGradient(
                                          colors: int.parse(
                                                      listDataResult[index]
                                                          .number
                                                          .toString()) <
                                                  5
                                              ? [
                                                  const Color(0xFF6da7f4),
                                                  const Color(0xFF6da7f4)
                                                ]
                                              : [
                                                  const Color(0xFF40ad72),
                                                  const Color(0xFF40ad72),
                                                ],
                                          stops: const [0.5, 0.5],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          tileMode: TileMode.mirror,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: widths * 0.21,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CircleAvatar(
                                            radius: 6,
                                            backgroundColor:
                                                getCircleAvatarColor(int.parse(
                                                    listData[index].number)),
                                          ),
                                          if (int.parse(listDataResult[index]
                                                      .number
                                                      .toString()) ==
                                                  5 ||
                                              int.parse(listDataResult[index]
                                                      .number
                                                      .toString()) ==
                                                  0)
                                            const CircleAvatar(
                                              radius: 6,
                                              backgroundColor:
                                                  Color(0xFFb659fe),
                                            )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                    width: widths,
                                    color: Colors.grey,
                                    height: 0.5),
                              ],
                            );
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: limitResult == 0
                                  ? () {}
                                  : () {
                                      setState(() {
                                        pageNumber--;
                                        limitResult = limitResult - 10;
                                        offsetResult = offsetResult - 10;
                                      });
                                      parityRecords(gameId);
                                      setState(() {});
                                    },
                              child: Container(
                                height: heights / 10,
                                width: widths / 10,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(
                                  Icons.navigate_before,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            textWidget(
                              text: '$pageNumber',
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: AppColors.secondaryTextColor,
                              maxLines: 1,
                            ),
                            const SizedBox(width: 16),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  limitResult = limitResult + 10;
                                  offsetResult = offsetResult + 10;
                                  pageNumber++;
                                });
                                parityRecords(gameId);
                                setState(() {});
                              },
                              child: Container(
                                height: heights / 10,
                                width: widths / 10,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(Icons.navigate_next,
                                    color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10)
                      ],
                    )
                  : selectedTabIndex == 1
                      ? chartScreen()
                      : responseStatusCode == 400
                          ? const NotFoundData()
                          : items.isEmpty
                              ? const Center(child: CircularProgressIndicator())
                              : Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListView.builder(
                                      itemCount: items.length,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        List<Color> colors;

                                        if (items[index].number == '0') {
                                          colors = [
                                            const Color(0xFFfd565c),
                                            const Color(0xFFb659fe),
                                          ];
                                        } else if (items[index].number == '5') {
                                          colors = [
                                            const Color(0xFF40ad72),
                                            const Color(0xFFb659fe),
                                          ];
                                        } else if (items[index].number ==
                                            '10') {
                                          colors = [
                                            const Color(0xFF40ad72),
                                            const Color(0xFF40ad72),
                                          ];
                                        } else if (items[index].number ==
                                            '20') {
                                          colors = [
                                            const Color(0xFFb659fe),
                                            const Color(0xFFb659fe),
                                          ];
                                        } else if (items[index].number ==
                                            '30') {
                                          colors = [
                                            const Color(0xFFfd565c),
                                            const Color(0xFFfd565c),
                                          ];
                                        } else if (items[index].number ==
                                            '40') {
                                          colors = [
                                            const Color(0xFF40ad72),
                                            const Color(0xFF40ad72),
                                          ];
                                        } else if (items[index].number ==
                                            '50') {
                                          colors = [
                                            //blue
                                            const Color(0xFF6da7f4),
                                            const Color(0xFF6da7f4)
                                          ];
                                        } else {
                                          int number = int.parse(
                                              items[index].number.toString());
                                          colors = number.isOdd
                                              ? [
                                                  const Color(0xFF40ad72),
                                                  const Color(0xFF40ad72),
                                                ]
                                              : [
                                                  const Color(0xFFfd565c),
                                                  const Color(0xFFfd565c),
                                                ];
                                        }

                                        return Card(
                                          elevation: 3,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 5.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      InkWell(
                                                        onTap: () {},
                                                        child: Container(
                                                          alignment:
                                                              Alignment.center,
                                                          height: 25,
                                                          width: widths * 0.40,
                                                          decoration: BoxDecoration(
                                                              color: Colors.red,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8)),
                                                          child: textWidget(
                                                              text: 'Bet',
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: AppColors
                                                                  .primaryTextColor),
                                                        ),
                                                      ),
                                                      textWidget(
                                                          text: items[index]
                                                                      .status ==
                                                                  "0"
                                                              ? "Pending"
                                                              : items[index]
                                                                          .status ==
                                                                      "1"
                                                                  ? "Win"
                                                                  : "Loss",
                                                          fontSize:
                                                              widths * 0.05,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: items[index]
                                                                      .status ==
                                                                  "1"
                                                              ? AppColors
                                                                  .methodBlue
                                                              : AppColors
                                                                  .gradientFirstColor),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 4,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 5.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      textWidget(
                                                          text: "Balance",
                                                          fontSize:
                                                              widths * 0.03,
                                                          fontWeight:
                                                              FontWeight.w800,
                                                          color: AppColors
                                                              .secondaryTextColor),
                                                      textWidget(
                                                          text:
                                                              "₹${items[index].amount}",
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w800,
                                                          color: AppColors
                                                              .secondaryTextColor),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 5.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      textWidget(
                                                          text: "Bet Type",
                                                          fontSize:
                                                              widths * 0.03,
                                                          fontWeight:
                                                              FontWeight.w800,
                                                          color: AppColors
                                                              .secondaryTextColor),
                                                      int.parse(items[index]
                                                                  .number
                                                                  .toString()) <=
                                                              9
                                                          ? Container(
                                                              alignment: Alignment
                                                                  .centerRight,
                                                              width:
                                                                  widths * 0.20,
                                                              child:
                                                                  GradientTextview(
                                                                items[index]
                                                                    .number
                                                                    .toString(),
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        20,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w900),
                                                                gradient:
                                                                    LinearGradient(
                                                                        colors:
                                                                            colors,
                                                                        stops: const [
                                                                          0.5,
                                                                          0.5,
                                                                        ],
                                                                        begin: Alignment
                                                                            .topCenter,
                                                                        end: Alignment
                                                                            .bottomCenter,
                                                                        tileMode:
                                                                            TileMode.mirror),
                                                              ),
                                                            )
                                                          : GradientTextview(
                                                              items[index]
                                                                          .number
                                                                          .toString() ==
                                                                      '10'
                                                                  ? 'Green'
                                                                  : items[index]
                                                                              .number
                                                                              .toString() ==
                                                                          '20'
                                                                      ? 'Voilet'
                                                                      : items[index].number.toString() ==
                                                                              '30'
                                                                          ? 'Red'
                                                                          : items[index].number.toString() == '40'
                                                                              ? 'Big'
                                                                              : items[index].number.toString() == '50'
                                                                                  ? 'Small'
                                                                                  : '',
                                                              style: const TextStyle(
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w900),
                                                              gradient:
                                                                  LinearGradient(
                                                                      colors:
                                                                          colors,
                                                                      stops: const [
                                                                        0.5,
                                                                        0.5,
                                                                      ],
                                                                      begin: Alignment
                                                                          .topCenter,
                                                                      end: Alignment
                                                                          .bottomCenter,
                                                                      tileMode:
                                                                          TileMode
                                                                              .mirror),
                                                            ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 5.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      textWidget(
                                                          text: "Type",
                                                          fontSize:
                                                              widths * 0.03,
                                                          fontWeight:
                                                              FontWeight.w800,
                                                          color: AppColors
                                                              .secondaryTextColor),
                                                      textWidget(
                                                          text: items[index]
                                                                      .gameid ==
                                                                  "1"
                                                              ? "1 min"
                                                              : items[index]
                                                                          .gameid ==
                                                                      "2"
                                                                  ? "3 min"
                                                                  : items[index]
                                                                              .gameid ==
                                                                          "4"
                                                                      ? "5 min"
                                                                      : "10 min",
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w800,
                                                          color: AppColors
                                                              .secondaryTextColor),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 5.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      textWidget(
                                                          text: "Win Amount",
                                                          fontSize:
                                                              widths * 0.03,
                                                          fontWeight:
                                                              FontWeight.w800,
                                                          color: AppColors
                                                              .secondaryTextColor),
                                                      textWidget(
                                                          text: items[index]
                                                                      .win ==
                                                                  null
                                                              ? '₹ 0.0'
                                                              : '₹ ${items[index].win}',
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: items[
                                                                          index]
                                                                      .win !=
                                                                  null
                                                              ? AppColors
                                                                  .methodBlue
                                                              : AppColors
                                                                  .gradientFirstColor),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 5.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      textWidget(
                                                          text: "Time",
                                                          fontSize:
                                                              widths * 0.03,
                                                          fontWeight:
                                                              FontWeight.w800,
                                                          color: AppColors
                                                              .secondaryTextColor),
                                                      textWidget(
                                                          text: DateFormat(
                                                                  "dd-MMM-yyyy, hh:mm a")
                                                              .format(DateTime
                                                                  .parse(items[
                                                                          index]
                                                                      .datetime
                                                                      .toString())),
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w800,
                                                          color: AppColors
                                                              .secondaryTextColor)
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 5.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      textWidget(
                                                          text: "Order number",
                                                          fontSize:
                                                              widths * 0.03,
                                                          fontWeight:
                                                              FontWeight.w800,
                                                          color: AppColors
                                                              .secondaryTextColor),
                                                      Row(
                                                        children: [
                                                          textWidget(
                                                              text: items[index]
                                                                  .gamesno
                                                                  .toString(),
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w800,
                                                              color: AppColors
                                                                  .secondaryTextColor),
                                                          SizedBox(
                                                            width:
                                                                widths * 0.01,
                                                          ),
                                                          InkWell(
                                                              onTap: () {
                                                                copyToClipboard(
                                                                    items[index]
                                                                        .gamesno
                                                                        .toString(),
                                                                    context);
                                                              },
                                                              child:
                                                                  Image.asset(
                                                                Assets
                                                                    .iconsCopy,
                                                                color:
                                                                    Colors.grey,
                                                                height:
                                                                    heights *
                                                                        0.027,
                                                              )),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                ),
            ],
          )
        : Container();
  }

  int limitResult = 0;
  int offsetResult = 0;

  gameWinPopup() async {
    UserModel user = await userProvider.getUser();
    String userid = user.id.toString();
    final response = await http.get(
        Uri.parse('${ApiUrl.game_win}$userid&gamesno=$period&gameid=$gameId'));

    var data = jsonDecode(response.body);
    print('${ApiUrl.game_win}$userid&gamesno=$period&gameid=$gameId');
    print('nbnbnbnbn');
    print(data);
    print(data);
    print('data');
    if (data["status"] == "200") {
      var totalAmount = data["totalamount"];
      var win = data["win"];
      var gamesno = data["gamesno"];
      var gameid = data["gameid"];
      print('rrrrrrrr');
      showPopup(context, totalAmount, win, gamesno, gameid);
      Future.delayed(const Duration(seconds: 5), () {
        Navigator.of(context).pop();
      });
    } else {
      setState(() {
        // loadingGreen = false;
      });
      // Utils.flushBarErrorMessage(data['msg'], context, Colors.black);
    }
  }

  void showPopup(
    BuildContext context,
    String totalAmount,
    String win,
    String gamesno,
    String gameIds,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(14))),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              textWidget(
                text: "Win Go :",
                fontSize: 12,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              textWidget(
                text: gameIds == '1'
                    ? '1 Min'
                    : gameIds == '2'
                        ? '3 Min'
                        : gameIds == '3'
                            ? '5 Min'
                            : '10 Min',
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
          content: SizedBox(
            height: 180,
            child: Column(
              children: [
                ListTile(
                  leading: textWidget(
                    text: "Game S.No.:",
                    fontSize: 12,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  trailing: textWidget(
                    text: gamesno,
                    fontSize: 12,
                    color: AppColors.secondaryTextColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ListTile(
                  leading: textWidget(
                    text: "Total Bet Amount:",
                    fontSize: 12,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  trailing: textWidget(
                    text: totalAmount,
                    fontSize: 12,
                    color: AppColors.secondaryTextColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ListTile(
                  leading: textWidget(
                    text: "Total Win Amount:",
                    fontSize: 12,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  trailing: textWidget(
                    text: win,
                    fontSize: 12,
                    color: AppColors.secondaryTextColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  ///chart page
  Widget chartScreen() {
    setState(() {});
    final widths = MediaQuery.of(context).size.width;
    final width = MediaQuery.of(context).size.width;
    final heights = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Column(
          children: List.generate(
            listDataResult.length,
            (index) {
              return SizedBox(
                height: 30,
                width: width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    textWidget(text: listDataResult[index].period),
                    Row(
                        children: generateNumberWidgets(
                            int.parse(listDataResult[index].number))),
                    Container(
                      height: 20,
                      width: 20,
                      margin: const EdgeInsets.all(2),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: int.parse(listDataResult[index].number) < 5
                            ? AppColors.btnBlueGradient
                            : AppColors.btnYellowGradient,
                      ),
                      child: textWidget(
                        text: int.parse(listDataResult[index].number) < 5
                            ? 'S'
                            : 'B',
                        color: AppColors.primaryTextColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: limitResult == 0
                  ? () {}
                  : () {
                      setState(() {
                        pageNumber--;
                        limitResult = limitResult - 10;
                        offsetResult = offsetResult - 10;
                      });
                      parityRecords(gameId);
                      setState(() {});
                    },
              child: Container(
                height: heights / 10,
                width: widths / 10,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.navigate_before,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 16),
            textWidget(
              text: '$pageNumber',
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.secondaryTextColor,
              maxLines: 1,
            ),
            const SizedBox(width: 16),
            GestureDetector(
              onTap: () {
                setState(() {
                  limitResult = limitResult + 10;
                  offsetResult = offsetResult + 10;
                  pageNumber++;
                });
                parityRecords(gameId);
                setState(() {});
              },
              child: Container(
                height: heights / 10,
                width: widths / 10,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.navigate_next, color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // int selectedTabIndex=-5;

  Widget buildTabContainer(
      String label, int index, double widths, Color selectedTextColor) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedTabIndex = index;
        });
      },
      child: Container(
        height: 40,
        width: widths / 3.3,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: selectedTabIndex == index
                ? Colors.red
                : Colors.black.withOpacity(0.05),
            borderRadius: BorderRadius.circular(8)),
        child: Text(
          label,
          style: TextStyle(
            fontSize: widths / 24,
            fontWeight:
                selectedTabIndex == index ? FontWeight.bold : FontWeight.w500,
            color: selectedTabIndex == index ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  UserViewProvider userProvider = UserViewProvider();

  List<BettingHistoryModel> items = [];
  Future<void> bettingHistory() async {
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();

    final response = await http.get(
      Uri.parse(ApiUrl.betHistory + token),
    );
    print(ApiUrl.betHistory + token);
    print('betHistory+token');

    setState(() {
      responseStatusCode = response.statusCode;
    });

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body)['data'];
      setState(() {
        items = responseData
            .map((item) => BettingHistoryModel.fromJson(item))
            .toList();
      });
    } else if (response.statusCode == 400) {
      if (kDebugMode) {
        print('Data not found');
      }
    } else {
      setState(() {
        items = [];
      });
      throw Exception('Failed to load data');
    }
  }

  BaseApiHelper baseApiHelper = BaseApiHelper();

  Future<void> walletfetch() async {
    try {
      if (kDebugMode) {
        print("qwerfghj");
      }
      final walletData = await baseApiHelper.fetchWalletData();
      if (kDebugMode) {
        print(walletData);
        print("wallet_data");
      }
      Provider.of<WalletProvider>(context, listen: false)
          .setWalletList(walletData!);
    } catch (error) {
      // Handle error here
      if (kDebugMode) {
        print("hiiii $error");
      }
    }
  }

  gameconcept(int countdownSeconds) {
    if (countdownSeconds == 6) {
      setState(() {
        create = true;
      });
      print('5 sec left');
    } else if (countdownSeconds == 0) {
      setState(() {
        create = false;
      });

      print('0 sec left');
    } else {}
  }

  List<GameHistoryModel> listDataResult = [];
  parityRecords(int gameId) async {
    // final gameid=widget.gameid;
    print(
        "${ApiUrl.colorresult}limit=$limitResult&gameid=$gameId&offset=$offsetResult");
    final response = await http.get(Uri.parse(
      "${ApiUrl.colorresult}limit=$limitResult&gameid=$gameId&offset=$offsetResult",
    ));
    print('pankaj');
    print(jsonDecode(response.body));
    if (response.statusCode == 200) {
      listDataResult.clear();
      final jsonData = json.decode(response.body)['data'];
      for (var i = 0; i < jsonData.length; i++) {
        var period = jsonData[i]['gamesno'];
        var number = jsonData[i]['number'];
        print(period);
        listDataResult.add(GameHistoryModel(
            period: period.toString(), number: number.toString()));
      }
      setState(() {});
      // return jsonData.map((item) => partlyrecord.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
}

Widget buildTime1(int time) {
  Duration myDuration = Duration(seconds: time);
  String strDigits(int n) => n.toString().padLeft(2, '0');
  final minutes = strDigits(myDuration.inMinutes.remainder(11));
  final seconds = strDigits(myDuration.inSeconds.remainder(60));
  return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
    buildTimeCard(time: minutes[0].toString(), header: 'MINUTES'),
    const SizedBox(
      width: 3,
    ),
    buildTimeCard(time: minutes[1].toString(), header: 'MINUTES'),
    const SizedBox(
      width: 3,
    ),
    buildTimeCard(time: ':', header: 'MINUTES'),
    const SizedBox(
      width: 3,
    ),
    buildTimeCard(time: seconds[0].toString(), header: 'SECONDS'),
    const SizedBox(
      width: 3,
    ),
    buildTimeCard(time: seconds[1].toString(), header: 'SECONDS'),
  ]);
}

Widget buildTimeCard({required String time, required String header}) => Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Text(
            time,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black, fontSize: 15),
          ),
        ),
      ],
    );

Widget buildTime5sec(int time) {
  Duration myDuration = Duration(seconds: time);
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
              color: Colors.red, borderRadius: BorderRadius.circular(10)),
          child: Text(
            time,
            style: const TextStyle(
                fontWeight: FontWeight.w800,
                color: Colors.white,
                fontSize: 100),
          ),
        )
      ],
    );

class TimeDigit extends StatelessWidget {
  final int value;
  const TimeDigit({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(5),
      child: Text(
        value.toString(),
        style: const TextStyle(
          color: Colors.red,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class Winlist {
  int gameid;
  String title;
  String subtitle;
  int time;

  Winlist(this.gameid, this.title, this.subtitle, this.time);
}

class BetNumbers {
  String photo;
  final Color colorone;
  final Color colortwo;
  String number;
  BetNumbers(this.photo, this.colorone, this.colortwo, this.number);
}

class parityrecord {
  final String period;
  final String number;
  parityrecord(this.period, this.number);
}

class NotFoundData extends StatelessWidget {
  const NotFoundData({super.key});

  @override
  Widget build(BuildContext context) {
    final heights = MediaQuery.of(context).size.height;
    final widths = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image(
          image: const AssetImage(Assets.imagesNoDataAvailable),
          height: heights / 3,
          width: widths / 2,
        ),
        SizedBox(height: heights * 0.07),
        const Text(
          "Data not found",
        )
      ],
    );
  }
}

List<Widget> generateNumberWidgets(int parse) {
  return List.generate(10, (index) {
    List<Color> colors = [
      const Color(0xFFFFFFFF),
      const Color(0xFFFFFFFF),
    ];

    if (index == parse) {
      if (parse == 0) {
        colors = [
          const Color(0xFFfd565c),
          const Color(0xFFb659fe),
        ];
      } else if (parse == 5) {
        colors = [
          const Color(0xFF40ad72),
          const Color(0xFFb659fe),
        ];
      } else {
        colors = parse % 2 == 0
            ? [
                const Color(0xFFfd565c),
                const Color(0xFFfd565c),
              ]
            : [
                const Color(0xFF40ad72),
                const Color(0xFF40ad72),
              ];
      }
    }

    return Container(
      height: 20,
      width: 20,
      margin: const EdgeInsets.all(2),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(),
        gradient: LinearGradient(
            colors: colors,
            stops: const [
              0.5,
              0.5,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            tileMode: TileMode.mirror),
      ),
      child: textWidget(
        text: '$index',
        fontWeight: FontWeight.w600,
        color: index == parse ? AppColors.primaryTextColor : Colors.black,
      ),
    );
  });
}

class GradientTextview extends StatelessWidget {
  const GradientTextview(
    this.text, {
    super.key,
    required this.gradient,
    this.style,
  });

  final String text;
  final TextStyle? style;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(text, style: style),
    );
  }
}

class GameHistoryModel {
  final String period;
  final String number;

  GameHistoryModel({
    required this.period,
    required this.number,
  });
}

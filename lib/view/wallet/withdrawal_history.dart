import 'dart:convert';

import 'package:ClickHub/generated/assets.dart';
import 'package:ClickHub/model/user_model.dart';
import 'package:ClickHub/model/withdrawhistory_model.dart';
import 'package:ClickHub/res/aap_colors.dart';
import 'package:ClickHub/res/api_urls.dart';
import 'package:ClickHub/res/components/app_bar.dart';
import 'package:ClickHub/res/components/app_btn.dart';
import 'package:ClickHub/res/components/text_widget.dart';
import 'package:ClickHub/res/helper/api_helper.dart';
import 'package:ClickHub/res/provider/user_view_provider.dart';
import 'package:ClickHub/res/provider/withdrawhistory_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;



class WithdrawHistory extends StatefulWidget {
  const WithdrawHistory({super.key});

  @override
  State<WithdrawHistory> createState() => _WithdrawHistoryState();
}

class _WithdrawHistoryState extends State<WithdrawHistory> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    WithdrawHistoryyy();
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    selectedCatIndex = 0;
    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_controller);
  }



  late int selectedCatIndex;

  int ?responseStatuscode;


  List<History> historylist = [
    History("Processing", "₹100.00", "7Days - App", "P202389678"),
    History("Complete", "₹100.00", "7Days - App", "P202389678"),
    History("Processing", "₹100.00", "7Days - App", "P202389678"),
    History("Complete", "₹100.00", "7Days - App", "P202389678"),
  ];

  BaseApiHelper baseApiHelper = BaseApiHelper();


  @override
  Widget build(BuildContext context) {

    final withdrawdeposit = Provider.of<WithdrawHistoryProvider>(context).withdrawlist;

    final heights = MediaQuery.of(context).size.height;
    final widths = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: GradientAppBar(
        leading: AppBackBtn(),
          title: textWidget(
              text: 'Withdraw History',
              fontSize: 25,
              color: AppColors.primaryTextColor),
          gradient: AppColors.primaryGradient),
      body: ScrollConfiguration(
        behavior: ScrollBehavior().copyWith(overscroll: false),
        child: ListView(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          children: [
            responseStatuscode== 400 ?
            const Notfounddata(): WithdrawItems.isEmpty? const Center(child: CircularProgressIndicator()):
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                    itemCount: WithdrawItems.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                    onTap: () {},
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 35,
                                      width: widths * 0.30,
                                      decoration: BoxDecoration(
                                          color: WithdrawItems[index].status=="0"?Colors.orange: WithdrawItems[index].status=="1"?AppColors.depositButton:Colors.red,
                                          borderRadius:
                                          BorderRadius.circular(10)),
                                      child: textWidget(
                                          text: WithdrawItems[index].status=="0"?"Pending":WithdrawItems[index].status=="1"?"Complete":"Failed",
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.primaryTextColor
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  textWidget(
                                      text: "Balance",
                                      fontSize: widths * 0.04,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.secondaryTextColor),
                                  textWidget(
                                      text: WithdrawItems[index].amount.toString(),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.secondaryTextColor),
                                ],
                              ),
                            ),
                            Padding(
                              padding:  const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  textWidget(
                                      text: "Account No.",
                                      fontSize: widths * 0.04,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.secondaryTextColor),
                                  textWidget(
                                      text: WithdrawItems[index].accountno.toString(),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.secondaryTextColor),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  textWidget(
                                      text: "Time",
                                      fontSize: widths * 0.04,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.secondaryTextColor),

                                  Text(DateFormat("dd-MMM-yyyy, hh:mm a").format(
                                      DateTime.parse(WithdrawItems[index].date.toString())),
                                    style: const TextStyle(
                                        fontSize: 13,
                                        color: Colors.black,),),
                                ],
                              ),
                            ),


                          ],
                        ),
                      );
                    })

            ),
          ],
        ),
      ),
      bottomSheet: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return _buildBottomSheet();
        },
      ),
    );
  }

  Widget _buildBottomSheet() {
    return Container(
      height: _animation.value * 300,
      width: 400,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 5,
            ),
            _buildBottomSheetHeader(),
            SizedBox(height: 200, child: _buildMonthPicker()),
          ],
        ),
      ),
    );
  }

  Future<void> fetchDataWithdrawHistory() async {
    try {
      if (kDebugMode) {
        print("qwerfghj");
      }
      final datawithdraw = await baseApiHelper.fetchWithdrawHistoryData();
      if (kDebugMode) {
        print(datawithdraw);
        print("datawithdraw");
      }
      Provider.of<WithdrawHistoryProvider>(context, listen: false).setwithdrawList(datawithdraw!);
    } catch (error) {
      if (kDebugMode) {
        print("hiiii $error");
      }
    }
  }

  UserViewProvider userProvider = UserViewProvider();

  List<WithdrawModel> WithdrawItems = [];

  Future<void> WithdrawHistoryyy() async {
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();

    final response = await http.get(Uri.parse(ApiUrl.withdrawHistory+token),);
    print(ApiUrl.withdrawHistory+token);
    print('withdrawHistory');

    setState(() {
      responseStatuscode = response.statusCode;
    });

    if (response.statusCode==200) {
      final List<dynamic> responseData = json.decode(response.body)['data'];
      setState(() {

        WithdrawItems = responseData.map((item) => WithdrawModel.fromJson(item)).toList();
        // selectedIndex = items.isNotEmpty ? 0:-1; //
      });

    }
    else if(response.statusCode==400){
      if (kDebugMode) {
        print('Data not found');
      }
    }
    else {
      setState(() {
        WithdrawItems = [];
      });
      throw Exception('Failed to load data');
    }
  }



  Widget _buildBottomSheetHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(onPressed: (){}, child: const Text('Cancel',style: TextStyle(color: AppColors.secondaryTextColor,fontSize: 14),),),
        TextButton(onPressed: (){}, child: const Text('Choose a date',style: TextStyle(color: Colors.black,fontSize: 14),),),
        TextButton(onPressed: (){}, child:  const Text('Confirm',style: TextStyle(color: AppColors.secondaryTextColor,fontSize: 14),),),
      ],
    );
  }

  static const kButtonTextStyle =
  TextStyle(fontSize: 12, color: AppColors.secondaryTextColor);
  DateTime _selectedDate = DateTime.now();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildMonthPicker() {
    return Row(
      children: [
        Expanded(
          child: CupertinoPicker(
            scrollController: FixedExtentScrollController(
              initialItem: _selectedDate.day - 1,
            ),
            itemExtent: 35,
            onSelectedItemChanged: (dayIndex) {
              setState(() {
                _selectedDate = DateTime(
                    _selectedDate.year, _selectedDate.month, dayIndex + 1);
              });
            },
            children: List.generate(
              _getMaxDaysInMonth(_selectedDate.year, _selectedDate.month),
                  (dayIndex) {
                return Center(
                  child: Text(
                    (dayIndex + 1).toString(),
                    style: const TextStyle(fontSize: 18),
                  ),
                );
              },
            ),
          ),
        ),
        Expanded(
          child: CupertinoPicker(
            scrollController: FixedExtentScrollController(
              initialItem: _selectedDate.month - 1,
            ),
            itemExtent: 40,
            onSelectedItemChanged: (monthIndex) {
              setState(() {
                _selectedDate = DateTime(_selectedDate.year, monthIndex + 1, 1);
              });
            },
            children: List.generate(12, (monthIndex) {
              return Center(
                child: Text(
                  DateFormat('M')
                      .format(DateTime(_selectedDate.year, monthIndex + 1, 1)),
                  style: const TextStyle(fontSize: 18),
                ),
              );
            }),
          ),
        ),
        Expanded(
          child: CupertinoPicker(
            scrollController: FixedExtentScrollController(
              initialItem: _selectedDate.year - 2003, // Adjust the initial year
            ),
            itemExtent: 40,
            onSelectedItemChanged: (yearIndex) {
              setState(() {
                _selectedDate = DateTime(
                    2023 + yearIndex, _selectedDate.month, _selectedDate.day);
              });
            },
            children: List.generate(2024 + 1 - 2003, (yearIndex) {
              final year = 2003 + yearIndex;
              return Center(
                child: Text(
                  year.toString(),
                  style: const TextStyle(fontSize: 18),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  int _getMaxDaysInMonth(int year, int month) {
    if (month == 2) {
      // February
      return DateTime(year, month + 1, 0).day;
    } else {
      // Other months
      const List<int> daysInMonth = [
        0,
        31,
        28,
        31,
        30,
        31,
        30,
        31,
        31,
        30,
        31,
        30,
        31
      ];
      return daysInMonth[month];
    }
  }
}

class BetIconModel {
  final String title;
  final String? image;
  BetIconModel({required this.title, this.image});
}

class History{
  String method;
  String balance;
  String type;
  String orderno;
  History(this.method,this.balance,this.type,this.orderno);
}

class Notfounddata extends StatelessWidget {
  const Notfounddata({super.key});

  @override
  Widget build(BuildContext context){
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
        SizedBox(height: heights*0.07),
        const Text("Data not found",)
      ],
    );
  }

}

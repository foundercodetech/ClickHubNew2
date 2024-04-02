// ignore_for_file: library_private_types_in_public_api

import 'package:ClickHub/res/aap_colors.dart';
import 'package:ClickHub/view/promotion/daily_salary_history.dart';
import 'package:flutter/material.dart';

class DailySalaryScale extends StatefulWidget {
  final int count;
  const DailySalaryScale({super.key, required this.count});

  @override
  _DailySalaryScaleState createState() => _DailySalaryScaleState();
}

class ScaleData {
  final String value;
  final String indicatorValue;

  ScaleData({required this.value, required this.indicatorValue});
}

class _DailySalaryScaleState extends State<DailySalaryScale> {
  static const double containerHeight = 25.0;
  static const double containerWidth = 78.5;
  static const EdgeInsets containerMargin = EdgeInsets.all(0);

  List<ScaleData> scaleData = [
    ScaleData(
      value: '300',
      indicatorValue: '5',
    ),
    ScaleData(value: '500', indicatorValue: '10'),
    ScaleData(value: '1000', indicatorValue: '20'),
    ScaleData(value: '2500', indicatorValue: '40'),
    ScaleData(value: '4000', indicatorValue: '60'),
    ScaleData(value: '6000', indicatorValue: '80'),
    ScaleData(value: '8000', indicatorValue: '100'),
    ScaleData(value: '10000', indicatorValue: '130'),
    ScaleData(value: '12000', indicatorValue: '150'),
  ];

  int rowFilledPosition = 0;

  void _updateScale() {
    setState(() {
      filledPositionIndex++;
      rowFilledPosition++;
      if (filledPositionIndex >= scaleData.length ||
          rowFilledPosition >= scaleData.length) {
        filledPositionIndex = 0;
        rowFilledPosition = 0;
      } else {
        currentData = scaleData[filledPositionIndex];
      }
    });
  }

  // updateScale(){
  //   setState(() {
  //     if(widget.count<int.parse(scaleData[0].indicatorValue)){
  //       rowFilledPosition=-1;
  //     }else if(widget.count<int.parse(scaleData[1].indicatorValue)){
  //       rowFilledPosition=0;
  //     }else if(widget.count<int.parse(scaleData[2].indicatorValue)){
  //       rowFilledPosition=1;
  //     }else if(widget.count<int.parse(scaleData[3].indicatorValue)){
  //       rowFilledPosition=2;
  //     }else{
  //       rowFilledPosition=3;
  //     }
  //   });
  //
  // }
  @override
  void initState() {
    // updateScale();
    // _updateScale();
    // TODO: implement initState
    super.initState();
  }

  bool isContainerFilled = false;

  int filledPositionIndex = 0;

  ScaleData currentData = ScaleData(value: '0', indicatorValue: '0');

  Widget _buildValueIndicator(int index) {
    if (index >= scaleData.length) {
      return Container();
    }

    ScaleData data = scaleData[index];

    return Positioned(
      top: Constants.valueIndicatorTop,
      left: Constants.valueIndicatorLeft +
          (index * Constants.valueIndicatorSpacing),
      child: _buildValueIndicatorWidget(
        data,
        index,
      ),
    );
  }

  Widget _buildValueIndicatorWidget(ScaleData data, int index) {
    bool isCurrentValue = index <= filledPositionIndex;

    return Column(
      children: [
        Text(
          data.value,
          style: TextStyle(
            fontWeight: isCurrentValue ? FontWeight.bold : FontWeight.normal,
            color: isCurrentValue ? Colors.white : Colors.white,
            fontSize: 10,
          ),
        ),
        Row(
          children: [
            Container(
              height: containerHeight,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(
                  color: isCurrentValue ? Colors.white : Colors.white,
                ),
              ),
            ),
          ],
        ),
        Text(
          data.indicatorValue,
          style: TextStyle(
            fontWeight: isCurrentValue ? FontWeight.bold : FontWeight.normal,
            color: isCurrentValue ? Colors.white : Colors.white,
            fontSize: 10,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final heights = MediaQuery.of(context).size.height;
    final widths = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 3, 10, 0),
        child: Container(
          width: widths,
          decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [
                AppColors.gradientFirstColor,
                AppColors.gradientSecondColor,
              ]),
              borderRadius: BorderRadius.circular(15)),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // SvgPicture.asset(color: Colors.white,Assets.iconsTotalBal,height: 30,),
                      const Text(
                        'Daily Salary',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w700),
                      ),
                      // const Text(''',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w700 ),),
                      const SizedBox(
                        width: 50,
                      ),
                      const Text(
                        'Today Salary ',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w700),
                      ),
                      const Text(
                        '0.0 ',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                      // TweenAnimationBuilder(
                      //     tween: IntTween(
                      //         begin: 0, end: int.parse(currentData.value)),
                      //     duration: const Duration(seconds: 2),
                      //     builder: (context, value, child) {
                      //       return Positioned(
                      //         top: Constants.arrowTop,
                      //         right: Constants.arrowRight,
                      //         child: Text(
                      //           // '$value/day',
                      //           '0.0/day',
                      //           style: TextStyle(
                      //             color: isContainerFilled
                      //                 ? Colors.green
                      //                 : Colors.white,
                      //             fontSize: 16,
                      //             fontWeight: FontWeight.bold,
                      //           ),
                      //         ),
                      //       );
                      //     }),
                      InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const DailySalaryHistory()));
                          },
                          child: const Icon(
                            Icons.arrow_drop_down_rounded,
                            color: Colors.white,
                          ))
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.do_not_disturb_on_total_silence,
                        color: isContainerFilled ? Colors.green : Colors.white,
                      ),
                      Row(
                        children: List.generate(
                          4,
                          (index) => Container(
                            margin: containerMargin,
                            width: containerWidth,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: rowFilledPosition >= index
                                    ? Colors.white
                                    : Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: heights * 0.01,
                  ),
                  // const Text('User  ',style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.w700 ),),
                ],
              ),
              // Positioned(
              //   top:Constants.arrowTop,
              //   right:Constants.arrowRight,
              //   child: Icon(Icons.arrow_forward_ios_sharp,
              //     color: isContainerFilled ? Colors.green : Colors.white,
              //   ),
              // ),
              for (int i = 0; i < scaleData.length; i++)
                _buildValueIndicator(i),
            ],
          ),
        ),
      ),
    );
  }
}

class Constants {
  static const double borderWidth = 1.5;
  static const double containerHeight = 1.0;
  static const double containerWidth = 380.0;
  static const double arrowTop = 60;
  static const double arrowRight = 14.5;

  static const double valueIndicatorTop = 55.5;
  static const double valueIndicatorLeft = 30.0;
  static const double valueIndicatorSpacing = 34.0;
  static const double fontSize = 12.0;
}

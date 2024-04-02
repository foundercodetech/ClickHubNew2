//
//
// import 'package:ClickHub/generated/assets.dart';
// import 'package:ClickHub/model/rendom_color_model.dart';
// import 'package:ClickHub/res/components/custom_switch.dart';
// import 'package:ClickHub/res/components/sliding_switch.dart';
// import 'package:ClickHub/res/marquee/marquee.dart';
// import 'package:flutter/material.dart';
// import 'dart:math' as math;
//
// import '../../../../res/components/small_sliding_switch.dart';
// import 'widget/all_bet_widget.dart';
// import 'widget/my_bet_widget.dart';
//
// class GameAviator extends StatefulWidget {
//   const GameAviator({super.key});
//
//   @override
//   State<GameAviator> createState() => _GameAviatorState();
// }
//
// class _GameAviatorState extends State<GameAviator>
//     with SingleTickerProviderStateMixin {
//   late final AnimationController _controller =
//       AnimationController(vsync: this, duration: const Duration(seconds: 1500))
//         ..repeat();
//
//   xMaxValue() async {
//     for (var i = 0; i < 10000000; i++) {
//       await Future.delayed(const Duration(milliseconds: 200));
//       setState(() {
//         xtime = xtime + 5 * 0.001;
//       });
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     xMaxValue();
//   }
//
//   final List<String> number = [
//     "1.23x",
//     "2.23x",
//     "1.2x",
//     "2.56x",
//     "3.45x",
//     "8.5x",
//     "1.25x",
//     "21.2x",
//     "1.45x",
//     "8.7x",
//     "21.1x",
//     "1.23x",
//     "9.21x",
//     "1.63x",
//   ];
//   @override
//   void dispose() {
//    _controller.dispose();
//     super.dispose();
//   }
//   @override
//   Widget build(BuildContext context) {
//     height = MediaQuery.of(context).size.height * 0.53;
//     width = MediaQuery.of(context).size.width;
//     return Scaffold(
//       backgroundColor: const Color(0xff101011),
//       appBar: AppBar(
//         backgroundColor: Colors.white12,
//         leading: const Padding(
//           padding: EdgeInsets.all(15.0),
//           child: CircleAvatar(
//             radius: 100,
//             child: Icon(
//               Icons.help,
//               color: Colors.red,
//             ),
//           ),
//         ),
//         title: Image.asset(
//           Assets.imagesAviatorText,
//           fit: BoxFit.fitHeight,
//           width: 100,
//         ),
//         actions: [
//           Container(
//             width: 150,
//             decoration: BoxDecoration(
//               border: Border.all(
//                   color: Colors.white12,
//                   width: 4.0,
//                   style: BorderStyle.solid), //Border.all
//               borderRadius: const BorderRadius.all(
//                 Radius.circular(30),
//               ),
//             ),
//             child: const Padding(
//               padding: EdgeInsets.all(5.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     '  ₹',
//                     style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.w900,
//                         fontSize: 15),
//                   ),
//                   Text(
//                     '0 /-',
//                     style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.w900,
//                         fontSize: 15),
//                   ),
//                 ],
//               ),
//             ),
//           )
//         ],
//       ),
//       body: ListView(
//         shrinkWrap: true,
//         children: [
//           const SizedBox(
//             height: 10,
//           ),
//           expendWidget(),
//           Center(
//             child: Container(
//               height: height * 0.69,
//               width: width,
//               decoration: BoxDecoration(
//                 border: Border.all(
//                     color: Colors.white12,
//                     width: 4.0,
//                     style: BorderStyle.solid), //Border.all
//                 borderRadius: const BorderRadius.all(
//                   Radius.circular(10),
//                 ),
//               ),
//               child: Column(
//                 children: [
//                   SizedBox(
//                     height: height * 0.60,
//                     width: width * 0.98,
//                     child: Row(
//                       children: [
//                         Container(
//                             color: Colors.black,
//                             width: width * 0.05,
//                             height: height * 0.82,
//                             child: rowMarquee()),
//                         Container(
//                           height: height * 0.82,
//                           width: width * 0.92,
//                           color: Colors.white,
//                           child: Stack(
//                             // clipBehavior: Clip.none,
//                             children: [
//                               Positioned(
//                                 bottom: -width * 1.25,
//                                 left: -width * 1.25,
//                                 child: Container(
//                                     height: width * 2.5,
//                                     width: width * 2.5,
//                                     color: Colors.black.withOpacity(0.9),
//                                     child: imageBg()),
//                               ),
//                               SizedBox(
//                                 height: height * 0.92,
//                                 width: width * 0.94,
//                                 child: Aviator(
//                                   height: height * 0.92,
//                                   width: width * 0.92,
//                                 ),
//                               ),
//                               Center(
//                                 child: Text(
//                                   '${xtime.toStringAsFixed(2)}X',
//                                   style: const TextStyle(
//                                       fontSize: 50,
//                                       fontWeight: FontWeight.w900,
//                                       color: Colors.white),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     height: height * 0.06,
//                     width: width * 0.98,
//                     color: Colors.black,
//                     child: buildMarquee(),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           SizedBox(
//             height: height * 0.01,
//           ),
//           Center(
//             child: SizedBox(
//               height: height * 0.45,
//               width: width,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   betButton(),
//                   betButtonTwo(),
//                 ],
//               ),
//             ),
//           ),
//           SizedBox(
//             height: height * 0.05,
//           ),
//           Container(
//               width: width,
//               decoration: BoxDecoration(
//                   color: Colors.grey.withOpacity(0.3),
//                   borderRadius: const BorderRadius.all(Radius.circular(10))),
//               child: Column(
//                 children: [
//                   bethistory(),
//                   _isSecondPage ? const MyBetPage() : const AllBetPage()
//                 ],
//               ))
//         ],
//       ),
//     );
//   }
//
//   bool _isToggled = true;
//   bool _isToggle2 = true;
//   bool autoBet = false;
//   bool autoBet2 = false;
//   bool autoaCas = false;
//   bool autoaCas2 = false;
//   final amounts = TextEditingController(text: '10.00');
//   final amounts2 = TextEditingController(text: '15.00');
//   final autovalue = TextEditingController(text: '1.01');
//   final autovalue2 = TextEditingController(text: '2.01');
//   int multiplier = 1;
//   String multiam = '10.00';
//   bool useRtlText = false;
//   double height = 150;
//   double width = 300;
//   double xtime = 1.0;
//   bool isStart = false;
//   // bool isFinished=false;
//   bool isBet = false;
//   double bettingAmount = 0.0;
//   bool isExpanded = false;
//   bool _isSecondPage = false;
//
//   void _toggleSwitch(bool value) {
//     setState(() {
//       _isSecondPage = value;
//     });
//   }
//
//   void _smallToggleSwitch(bool value) {
//     setState(() {
//       _isToggled = value;
//     });
//   }
//
//   void _smallToggleSwitchTwo(bool value) {
//     setState(() {
//       _isToggle2 = value;
//     });
//   }
//
//   Widget bethistory() {
//     return Padding(
//       padding: const EdgeInsets.only(top: 8.0),
//       child: Center(
//         child: SlidingSwitch(
//           value: _isSecondPage,
//           width: width * 0.82,
//           onChanged: _toggleSwitch,
//           height: height * 0.075,
//           animationDuration: const Duration(milliseconds: 400),
//           onTap: () {},
//           onDoubleTap: () {},
//           onSwipe: () {},
//           textOff: "All Bet",
//           textOn: "My Bet",
//           colorOn: Colors.white,
//           colorOff: Colors.white,
//           background: Colors.black,
//           buttonColor: Colors.grey.withOpacity(0.5),
//           inactiveColor: Colors.white,
//         ),
//       ),
//     );
//   }
//
//   Widget expendWidget() {
//     return ExpansionTile(
//       shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.all(Radius.circular(10))),
//       title: isExpanded
//           ? const Text("Round History",
//               style: TextStyle(fontSize: 12, color: Colors.white))
//           : SizedBox(
//               height: height * 0.05,
//               width: width,
//               child: ListView.builder(
//                   shrinkWrap: true,
//                   itemCount: 8,
//                   scrollDirection: Axis.horizontal,
//                   itemBuilder: (BuildContext context, int index) {
//                     return Padding(
//                       padding: const EdgeInsets.all(2.0),
//                       child: Container(
//                         alignment: Alignment.center,
//                         decoration: BoxDecoration(
//                           color: Colors.grey.withOpacity(0.2),
//                           border:
//                               Border.all(color: Colors.grey.withOpacity(0.2)),
//                           borderRadius: const BorderRadius.all(Radius.circular(10)),
//                         ),
//                         child: Text(
//                           number[index],
//                           style: const TextStyle(fontSize: 10, color: Colors.white),
//                         ),
//                       ),
//                     );
//                   }),
//             ),
//       onExpansionChanged: (value) {
//         setState(() {
//           isExpanded = value;
//         });
//       },
//       trailing: Container(
//         alignment: Alignment.center,
//         height: height * 0.065,
//         width: width * 0.15,
//         decoration: BoxDecoration(
//           color: Colors.grey.withOpacity(0.1),
//           border: Border.all(color: Colors.grey.withOpacity(0.2)),
//           borderRadius: const BorderRadius.all(Radius.circular(25)),
//         ),
//         child: Row(
//           mainAxisAlignment:
//               MainAxisAlignment.center, // Align icons in the center
//           children: [
//             const Icon(
//               Icons.history,
//               size: 16,
//               color: Colors.pink,
//             ),
//             Padding(
//               padding: const EdgeInsets.only(bottom: 8.0),
//               child: Icon(
//                 isExpanded
//                     ? Icons.arrow_drop_up_rounded
//                     : Icons.arrow_drop_down_rounded,
//                 size: 28,
//                 color: Colors.pink,
//               ),
//             ),
//           ],
//         ),
//       ),
//       children: [
//         Container(
//           decoration: BoxDecoration(
//               color: Colors.grey.withOpacity(0.3),
//               borderRadius: const BorderRadius.only(
//                   bottomLeft: Radius.circular(10),
//                   bottomRight: Radius.circular(10))),
//           child: GridView.builder(
//             shrinkWrap: true,
//             itemCount: number.length,
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 8,
//               crossAxisSpacing: 2,
//               childAspectRatio: 2,
//               mainAxisSpacing: 2,
//             ),
//             itemBuilder: (BuildContext context, int index) {
//               return Padding(
//                 padding: const EdgeInsets.all(2.0),
//                 child: Container(
//                   alignment: Alignment.center,
//                   decoration: BoxDecoration(
//                     color: Colors.grey.withOpacity(0.1),
//                     border: Border.all(color: Colors.grey.withOpacity(0.2)),
//                     borderRadius: const BorderRadius.all(Radius.circular(10)),
//                   ),
//                   child: Text(
//                     number[index],
//                     style: TextStyle(
//                         fontSize: 10, color: RandomColorModel().getColor()),
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget betButton() {
//     return Container(
//       width: width * 0.48,
//       height: height * 0.45,
//       decoration: BoxDecoration(
//           border: Border.all(
//               color: autoBet == true ? Colors.red : Colors.white12, width: 1),
//           color: Colors.grey.withOpacity(0.3),
//           borderRadius: const BorderRadius.all(Radius.circular(10))),
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             Center(
//               child: SmallSlidingSwitch(
//                 value: _isToggled,
//                 width: width * 0.29,
//                 onChanged: _smallToggleSwitch,
//                 height: height * 0.06,
//                 animationDuration: const Duration(milliseconds: 400),
//                 onTap: () {},
//                 onDoubleTap: () {},
//                 onSwipe: () {},
//                 textOff: "Bet",
//                 textOn: "Auto",
//                 colorOn: Colors.white,
//                 colorOff: Colors.white,
//                 background: Colors.black,
//                 buttonColor: Colors.grey.withOpacity(0.5),
//                 inactiveColor: Colors.white,
//               ),
//             ),
//             const Divider(
//               color: Colors.transparent,
//               height: 10,
//             ),
//             SizedBox(
//               height: height * 0.05,
//               width: width * 0.4,
//               // color: Colors.red,
//               child: TextFormField(
//                 controller: amounts,
//                 textAlign: TextAlign.center,
//
//                 style: const TextStyle(fontSize: 16, color: Colors.white),
//
//                 keyboardType: TextInputType.number,
//                 // style: RighteousMedium.copyWith(fontSize: heights * 0.019, color: Colors.white),
//                 decoration: InputDecoration(
//                   contentPadding: const EdgeInsets.all(0),
//                   prefixIcon: Padding(
//                     padding: const EdgeInsets.all(5.0),
//                     child: InkWell(
//                         onTap: () {
//                           if (multiplier > 1) {
//                             setState(() {
//                               multiplier = multiplier - 1;
//                               amounts.text =
//                                   '${multiplier * double.parse(multiam)}.00';
//                             });
//                           }
//                         },
//                         child: Image.asset(Assets.imagesMinus)),
//                   ),
//                   suffixIcon: Padding(
//                     padding: const EdgeInsets.all(5.0),
//                     child: InkWell(
//                         onTap: () {
//                           if (multiplier >= 1) {
//                             setState(() {
//                               multiplier = multiplier + 1;
//                               amounts.text =
//                                   '${multiplier * double.parse(multiam)}.00';
//                             });
//                           }
//                         },
//                         child: Image.asset(Assets.imagesPlus)),
//                   ),
//                   // contentPadding: EdgeInsets.symmetric(vertical: height*0.1,horizontal: width*0.1), // Adjust padding as needed
//                   // counter: Offstage(),
//                   enabledBorder: const OutlineInputBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(30.0)),
//                     borderSide: BorderSide(color: Colors.grey, width: 1),
//                   ),
//                   focusedBorder: const OutlineInputBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(12.0)),
//                     borderSide: BorderSide(color: Colors.grey, width: 1),
//                   ),
//                   border: const OutlineInputBorder(
//                     borderSide: BorderSide(color: Colors.grey),
//                     borderRadius: BorderRadius.all(
//                       Radius.circular(12.0),
//                     ),
//                   ),
//                   focusedErrorBorder: const OutlineInputBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(12.0)),
//                     borderSide: BorderSide(color: Color(0xFFF65054)),
//                   ),
//                   errorBorder: const OutlineInputBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(12.0)),
//                     borderSide: BorderSide(color: Color(0xFFF65054)),
//                   ),
//                   hintText: "Enter ",
//                   hintStyle:
//                       const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
//                   fillColor: Colors.black,
//                   filled: true,
//                 ),
//               ),
//             ),
//             const Divider(
//               color: Colors.transparent,
//               height: 10,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 SizedBox(
//                   height: height * 0.1,
//                   width: width * 0.23,
//                   child: GridView.builder(
//                       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 2,
//                         mainAxisSpacing: 5,
//                         crossAxisSpacing: 5,
//                         childAspectRatio: 2.5,
//                       ),
//                       itemCount: dailPad
//                           .length, // Replace this with the actual number of items in your grid
//                       itemBuilder: (context, index) {
//                         return Container(
//                           decoration: BoxDecoration(
//                             color: Colors.grey.withOpacity(0.4),
//                             borderRadius:
//                                 const BorderRadius.all(Radius.circular(30.0)),
//                             border:
//                                 Border.all(color: Colors.grey.withOpacity(0.3)),
//                           ),
//                           child: Center(
//                             child: Text(
//                               '${dailPad[index]} ₹',
//                               style:
//                                   const TextStyle(color: Colors.white, fontSize: 10),
//                             ),
//                           ),
//                         );
//                       }),
//                 ),
//                 InkWell(
//                     onTap: () {
//                       if (isStart == false) {
//                         setState(() {
//                           isBet = true;
//                           bettingAmount = double.parse(amounts.text);
//                         });
//                       }
//                     },
//                     child: Image.asset(
//                       Assets.imagesBet,
//                       width: width * 0.19,
//                     )),
//               ],
//             ),
//             const Divider(
//               color: Colors.transparent,
//               height: 10,
//             ),
//             !_isToggled
//                 ? Container()
//                 : Padding(
//                     padding: const EdgeInsets.only(left: 3, right: 2),
//                     child: Column(
//                       children: [
//                         Row(
//                           // mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: [
//                             const Text(
//                               "Auto Bet  ",
//                               style:
//                                   TextStyle(color: Colors.white, fontSize: 10),
//                             ),
//                             // Container(
//                             //   width: 20,
//                             //   child: Transform.scale(
//                             //     scale: 0.5,
//                             //     child: Switch(
//                             //         activeColor: Colors.green,
//                             //         value: autoBet, onChanged: (v){
//                             //       setState(() {
//                             //         autoBet=v;
//                             //       });
//                             //     }),
//                             //   ),
//                             // ),
//                             // Spacer(),
//                             CustomSwitch(
//                               width: width * 0.08,
//                               height: height * 0.032,
//                               toggleSize: height * 0.014,
//                               value: autoBet,
//                               borderRadius: 20.0,
//                               padding: 2.0,
//                               toggleColor: Colors.white,
//                               switchBorder: Border.all(
//                                 color: Colors.grey,
//                                 width: 1.0,
//                               ),
//                               toggleBorder: Border.all(
//                                 color: Colors.white,
//                                 width: 20.0,
//                               ),
//                               activeColor: Colors.green,
//                               inactiveColor: Colors.grey.withOpacity(0.2),
//                               onToggle: (val) {
//                                 setState(() {
//                                   autoBet = val;
//                                 });
//                               },
//                             ),
//                           ],
//                         ),
//                         SizedBox(
//                           height: height * 0.02,
//                         ),
//                         Row(
//                           // mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: [
//                             const Text(
//                               "Cashout  ",
//                               style:
//                                   TextStyle(color: Colors.white, fontSize: 10),
//                             ),
//                             CustomSwitch(
//                               width: width * 0.08,
//                               height: height * 0.032,
//                               toggleSize: height * 0.014,
//                               value: autoaCas,
//                               borderRadius: 20.0,
//                               padding: 2.0,
//                               toggleColor: Colors.white,
//                               switchBorder: Border.all(
//                                 color: Colors.grey,
//                                 width: 1.0,
//                               ),
//                               toggleBorder: Border.all(
//                                 color: Colors.white,
//                                 width: 20.0,
//                               ),
//                               activeColor: Colors.green,
//                               inactiveColor: Colors.grey.withOpacity(0.2),
//                               onToggle: (val) {
//                                 setState(() {
//                                   autoaCas = val;
//                                 });
//                               },
//                             ),
//                             SizedBox(
//                               width: width * 0.03,
//                             ),
//                             SizedBox(
//                               height: height * 0.04,
//                               width: width * 0.175,
//                               child: TextFormField(
//                                 enabled: autoaCas,
//                                 controller: autovalue,
//                                 textAlign: TextAlign.center,
//                                 style:
//                                     const TextStyle(fontSize: 8, color: Colors.white),
//                                 textAlignVertical: TextAlignVertical.top,
//                                 keyboardType: TextInputType.number,
//                                 // style: RighteousMedium.copyWith(fontSize: heights * 0.019, color: Colors.white),
//                                 decoration: InputDecoration(
//                                   contentPadding: const EdgeInsets.all(0),
//                                   suffix: InkWell(
//                                       onTap: () {
//                                         setState(() {
//                                           autovalue.clear();
//                                         });
//                                       },
//                                       child: const Icon(
//                                         Icons.cancel,
//                                         size: 14,
//                                       )),
//                                   // Text("X  ",style: TextStyle(color: Colors.white.withOpacity(0.3),fontSize: 12,fontWeight: FontWeight.bold),),
//                                   // contentPadding: EdgeInsets.symmetric(vertical: height*0.1,horizontal: width*0.1), // Adjust padding as needed
//                                   // counter: Offstage(),
//                                   enabledBorder: const OutlineInputBorder(
//                                     borderRadius:
//                                         BorderRadius.all(Radius.circular(30.0)),
//                                     borderSide: BorderSide(
//                                         color: Colors.white, width: 1),
//                                   ),
//                                   focusedBorder: const OutlineInputBorder(
//                                     borderRadius:
//                                         BorderRadius.all(Radius.circular(12.0)),
//                                     borderSide: BorderSide(
//                                         color: Colors.white, width: 1),
//                                   ),
//                                   border: const OutlineInputBorder(
//                                     borderSide: BorderSide(color: Colors.white),
//                                     borderRadius: BorderRadius.all(
//                                       Radius.circular(12.0),
//                                     ),
//                                   ),
//                                   focusedErrorBorder: const OutlineInputBorder(
//                                     borderRadius:
//                                         BorderRadius.all(Radius.circular(12.0)),
//                                     borderSide:
//                                         BorderSide(color: Color(0xFFF65054)),
//                                   ),
//                                   errorBorder: const OutlineInputBorder(
//                                     borderRadius:
//                                         BorderRadius.all(Radius.circular(12.0)),
//                                     borderSide:
//                                         BorderSide(color: Color(0xFFF65054)),
//                                   ),
//
//                                   hintStyle: const TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.w400),
//                                   fillColor: Colors.grey.withOpacity(0.3),
//                                   filled: true,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget betButtonTwo() {
//     return Container(
//       width: width * 0.48,
//       height: height * 0.45,
//       decoration: BoxDecoration(
//           border: Border.all(
//               color: autoBet2 == true ? Colors.red : Colors.white12, width: 1),
//           color: Colors.grey.withOpacity(0.3),
//           borderRadius: const BorderRadius.all(Radius.circular(10))),
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             Center(
//               child: SmallSlidingSwitch(
//                 value: _isToggle2,
//                 width: width * 0.29,
//                 onChanged: _smallToggleSwitchTwo,
//                 height: height * 0.06,
//                 animationDuration: const Duration(milliseconds: 400),
//                 onTap: () {},
//                 onDoubleTap: () {},
//                 onSwipe: () {},
//                 textOff: "Bet",
//                 textOn: "Auto",
//                 colorOn: Colors.white,
//                 colorOff: Colors.white,
//                 background: Colors.black,
//                 buttonColor: Colors.grey.withOpacity(0.5),
//                 inactiveColor: Colors.white,
//               ),
//             ),
//             const Divider(
//               color: Colors.transparent,
//               height: 10,
//             ),
//             SizedBox(
//               height: height * 0.05,
//               width: width * 0.4,
//               // color: Colors.red,
//               child: TextFormField(
//                 controller: amounts2,
//                 textAlign: TextAlign.center,
//
//                 style: const TextStyle(fontSize: 16, color: Colors.white),
//
//                 keyboardType: TextInputType.number,
//                 // style: RighteousMedium.copyWith(fontSize: heights * 0.019, color: Colors.white),
//                 decoration: InputDecoration(
//                   contentPadding: const EdgeInsets.all(0),
//                   prefixIcon: Padding(
//                     padding: const EdgeInsets.all(5.0),
//                     child: InkWell(
//                         onTap: () {
//                           if (multiplier > 1) {
//                             setState(() {
//                               multiplier = multiplier - 1;
//                               amounts2.text =
//                                   '${multiplier * double.parse(multiam)}.00';
//                             });
//                           }
//                         },
//                         child: Image.asset(Assets.imagesMinus)),
//                   ),
//                   suffixIcon: Padding(
//                     padding: const EdgeInsets.all(5.0),
//                     child: InkWell(
//                         onTap: () {
//                           if (multiplier >= 1) {
//                             setState(() {
//                               multiplier = multiplier + 1;
//                               amounts2.text =
//                                   '${multiplier * double.parse(multiam)}.00';
//                             });
//                           }
//                         },
//                         child: Image.asset(Assets.imagesPlus)),
//                   ),
//                   // contentPadding: EdgeInsets.symmetric(vertical: height*0.1,horizontal: width*0.1), // Adjust padding as needed
//                   // counter: Offstage(),
//                   enabledBorder: const OutlineInputBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(30.0)),
//                     borderSide: BorderSide(color: Colors.grey, width: 1),
//                   ),
//                   focusedBorder: const OutlineInputBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(12.0)),
//                     borderSide: BorderSide(color: Colors.grey, width: 1),
//                   ),
//                   border: const OutlineInputBorder(
//                     borderSide: BorderSide(color: Colors.grey),
//                     borderRadius: BorderRadius.all(
//                       Radius.circular(12.0),
//                     ),
//                   ),
//                   focusedErrorBorder: const OutlineInputBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(12.0)),
//                     borderSide: BorderSide(color: Color(0xFFF65054)),
//                   ),
//                   errorBorder: const OutlineInputBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(12.0)),
//                     borderSide: BorderSide(color: Color(0xFFF65054)),
//                   ),
//                   hintText: "Enter ",
//                   hintStyle:
//                       const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
//                   fillColor: Colors.black,
//                   filled: true,
//                 ),
//               ),
//             ),
//             const Divider(
//               color: Colors.transparent,
//               height: 10,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 SizedBox(
//                   height: height * 0.1,
//                   width: width * 0.23,
//                   child: GridView.builder(
//                       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 2,
//                         mainAxisSpacing: 5,
//                         crossAxisSpacing: 5,
//                         childAspectRatio: 2.5,
//                       ),
//                       itemCount: dailPad
//                           .length, // Replace this with the actual number of items in your grid
//                       itemBuilder: (context, index) {
//                         return Container(
//                           decoration: BoxDecoration(
//                             color: Colors.grey.withOpacity(0.4),
//                             borderRadius:
//                                 const BorderRadius.all(Radius.circular(30.0)),
//                             border:
//                                 Border.all(color: Colors.grey.withOpacity(0.3)),
//                           ),
//                           child: Center(
//                             child: Text(
//                               '${dailPad[index]} ₹',
//                               style:
//                                   const TextStyle(color: Colors.white, fontSize: 10),
//                             ),
//                           ),
//                         );
//                       }),
//                 ),
//                 InkWell(
//                     onTap: () {
//                       if (isStart == false) {
//                         setState(() {
//                           isBet = true;
//                           bettingAmount = double.parse(amounts2.text);
//                         });
//                       }
//                     },
//                     child: Image.asset(
//                       Assets.imagesBet,
//                       width: width * 0.19,
//                     )),
//               ],
//             ),
//             const Divider(
//               color: Colors.transparent,
//               height: 10,
//             ),
//             !_isToggle2
//                 ? Container()
//                 : Padding(
//                     padding: const EdgeInsets.only(left: 3, right: 2),
//                     child: Column(
//                       children: [
//                         Row(
//                           // mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: [
//                             const Text(
//                               "Auto Bet  ",
//                               style:
//                                   TextStyle(color: Colors.white, fontSize: 10),
//                             ),
//                             // Container(
//                             //   width: 20,
//                             //   child: Transform.scale(
//                             //     scale: 0.5,
//                             //     child: Switch(
//                             //         activeColor: Colors.green,
//                             //         value: autoBet, onChanged: (v){
//                             //       setState(() {
//                             //         autoBet=v;
//                             //       });
//                             //     }),
//                             //   ),
//                             // ),
//                             // Spacer(),
//                             CustomSwitch(
//                               width: width * 0.08,
//                               height: height * 0.032,
//                               toggleSize: height * 0.014,
//                               value: autoBet2,
//                               borderRadius: 20.0,
//                               padding: 2.0,
//                               toggleColor: Colors.white,
//                               switchBorder: Border.all(
//                                 color: Colors.grey,
//                                 width: 1.0,
//                               ),
//                               toggleBorder: Border.all(
//                                 color: Colors.white,
//                                 width: 20.0,
//                               ),
//                               activeColor: Colors.green,
//                               inactiveColor: Colors.grey.withOpacity(0.2),
//                               onToggle: (val) {
//                                 setState(() {
//                                   autoBet2 = val;
//                                 });
//                               },
//                             ),
//                           ],
//                         ),
//                         SizedBox(
//                           height: height * 0.02,
//                         ),
//                         Row(
//                           // mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: [
//                             const Text(
//                               "CashOut  ",
//                               style:
//                                   TextStyle(color: Colors.white, fontSize: 10),
//                             ),
//                             CustomSwitch(
//                               width: width * 0.08,
//                               height: height * 0.032,
//                               toggleSize: height * 0.014,
//                               value: autoaCas2,
//                               borderRadius: 20.0,
//                               padding: 2.0,
//                               toggleColor: Colors.white,
//                               switchBorder: Border.all(
//                                 color: Colors.grey,
//                                 width: 1.0,
//                               ),
//                               toggleBorder: Border.all(
//                                 color: Colors.white,
//                                 width: 20.0,
//                               ),
//                               activeColor: Colors.green,
//                               inactiveColor: Colors.grey.withOpacity(0.2),
//                               onToggle: (val) {
//                                 setState(() {
//                                   autoaCas2 = val;
//                                 });
//                               },
//                             ),
//                             SizedBox(
//                               width: width * 0.03,
//                             ),
//                             SizedBox(
//                               height: height * 0.04,
//                               width: width * 0.175,
//                               child: TextFormField(
//                                 enabled: autoaCas2,
//                                 controller: autovalue2,
//                                 textAlign: TextAlign.center,
//                                 style:
//                                     const TextStyle(fontSize: 8, color: Colors.white),
//                                 textAlignVertical: TextAlignVertical.top,
//                                 keyboardType: TextInputType.number,
//                                 // style: RighteousMedium.copyWith(fontSize: heights * 0.019, color: Colors.white),
//                                 decoration: InputDecoration(
//                                   contentPadding: const EdgeInsets.all(0),
//                                   suffix: InkWell(
//                                       onTap: () {
//                                         setState(() {
//                                           autovalue2.clear();
//                                         });
//                                       },
//                                       child: const Icon(
//                                         Icons.cancel,
//                                         size: 14,
//                                       )),
//                                   // Text("X  ",style: TextStyle(color: Colors.white.withOpacity(0.3),fontSize: 12,fontWeight: FontWeight.bold),),
//                                   // contentPadding: EdgeInsets.symmetric(vertical: height*0.1,horizontal: width*0.1), // Adjust padding as needed
//                                   // counter: Offstage(),
//                                   enabledBorder: const OutlineInputBorder(
//                                     borderRadius:
//                                         BorderRadius.all(Radius.circular(30.0)),
//                                     borderSide: BorderSide(
//                                         color: Colors.white, width: 1),
//                                   ),
//                                   focusedBorder: const OutlineInputBorder(
//                                     borderRadius:
//                                         BorderRadius.all(Radius.circular(12.0)),
//                                     borderSide: BorderSide(
//                                         color: Colors.white, width: 1),
//                                   ),
//                                   border: const OutlineInputBorder(
//                                     borderSide: BorderSide(color: Colors.white),
//                                     borderRadius: BorderRadius.all(
//                                       Radius.circular(12.0),
//                                     ),
//                                   ),
//                                   focusedErrorBorder: const OutlineInputBorder(
//                                     borderRadius:
//                                         BorderRadius.all(Radius.circular(12.0)),
//                                     borderSide:
//                                         BorderSide(color: Color(0xFFF65054)),
//                                   ),
//                                   errorBorder: const OutlineInputBorder(
//                                     borderRadius:
//                                         BorderRadius.all(Radius.circular(12.0)),
//                                     borderSide:
//                                         BorderSide(color: Color(0xFFF65054)),
//                                   ),
//
//                                   hintStyle: const TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.w400),
//                                   fillColor: Colors.grey.withOpacity(0.3),
//                                   filled: true,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget buildMarquee() {
//     return CustomMarquee(
//       key: Key("$useRtlText"),
//       text: '🏐',
//       style: const TextStyle(
//           fontWeight: FontWeight.w900, fontSize: 4, color: Colors.white),
//       velocity: 30.0,
//       blankSpace: width * 0.15,
//     );
//   }
//
//   Widget imageBg() {
//     return AnimatedBuilder(
//         animation: _controller,
//         builder: (_, child) {
//           return Transform.rotate(
//             angle: _controller.value * 170 * math.pi,
//             child: Image.asset(Assets.imagesChakra),
//           );
//         });
//   }
//
//   Widget rowMarquee() {
//     return CustomMarquee(
//       key: Key("$useRtlText"),
//       text: '          🏐          ',
//       style: TextStyle(
//           fontWeight: FontWeight.w900,
//           fontSize: 4,
//           color: Colors.blueAccent.shade700),
//       velocity: 30.0,
//       textDirection: TextDirection.rtl,
//       scrollAxis: Axis.vertical,
//       blankSpace: height * 0.1,
//     );
//   }
// }
//
// class Aviator extends StatefulWidget {
//   final double height;
//   final double width;
//   const Aviator({super.key, required this.height, required this.width});
//   @override
//   State<Aviator> createState() => _AviatorState();
// }
//
// class _AviatorState extends State<Aviator> with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _animation;
//   bool first = true;
//   double width = 0;
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(seconds: 5), // Set the animation duration
//       vsync: this,
//     );
//
//     animationControl();
//   }
//
//   animationControl() {
//     _animation =
//         Tween<double>(begin: 0, end: widget.height * 0.60).animate(_controller);
//     _animation.addListener(() {
//       setState(() {});
//
//       if (_controller.status == AnimationStatus.completed) {
//         setState(() {
//           first = false;
//           width = _animation.value;
//           animation();
//         });
//         _animation = Tween<double>(
//                 begin: widget.height * 0.50, end: widget.height * 0.60)
//             .animate(_controller);
//       }
//     });
//     _controller.forward();
//   }
//
//   animation() async {
//     await Future.delayed(const Duration(milliseconds: 500));
//     if (_controller.status == AnimationStatus.completed) {
//       _controller.reverse();
//     } else if (_controller.status == AnimationStatus.dismissed) {
//       _controller.forward();
//     }
//     animation();
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: widget.height,
//       width: widget.width,
//       child: Container(
//         alignment: Alignment.bottomLeft,
//         height: _animation.value,
//         width: _animation.value,
//         child: Stack(
//           clipBehavior: Clip.none,
//           children: [
//             first == true
//                 ? CustomPaint(
//                     painter: MyPainter(_animation.value),
//                     size: Size(_animation.value, _animation.value / 1.5),
//                   )
//                 : CustomPaint(
//                     painter: MyPainter(_animation.value),
//                     size: Size(width + (width - _animation.value),
//                         _animation.value / 1.5),
//                   ),
//             Positioned(
//               right: -widget.width * 0.2,
//               top: -widget.height * 0.10,
//               child: Image.asset(
//                 Assets.imagesAviator,
//                 height: 40,
//                 width: 100,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class MyPainter extends CustomPainter {
//   final double animationValue;
//
//   MyPainter(this.animationValue);
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     final path = drawPath(size.width, size.height, animationValue);
//
//     final paint = Paint()
//       ..color = Colors.redAccent.withOpacity(0.7)
//       ..style = PaintingStyle.fill;
//
//     final borderPaint = Paint()
//       ..color = Colors.red.shade900 // Change border color
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 4.0; // Change border width
//
//     canvas.drawPath(path, paint);
//     canvas.drawPath(path, borderPaint);
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return true;
//   }
// }
//
// Path drawPath(double canvasWidth, double chartHeight, double animationValue) {
//   final path = Path();
//   final segmentWidth = canvasWidth / 2 / 2;
//   path.moveTo(0, chartHeight);
//   path.cubicTo(
//     segmentWidth,
//     chartHeight,
//     4 * segmentWidth,
//     80,
//     canvasWidth,
//     0,
//   );
//   path.lineTo(canvasWidth, chartHeight);
//   path.close();
//
//   return path;
// }
//
// List<String> dailPad = ['100', '200', '500', '1000'];
// List<BetList> betList = [];
//
// class BetList {
//   final String name;
//   final int amount;
//   final double cashOut;
//   BetList({required this.name, required this.amount, required this.cashOut});
// }

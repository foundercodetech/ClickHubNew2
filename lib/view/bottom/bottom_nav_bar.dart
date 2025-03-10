import 'package:ClickHub/generated/assets.dart';
import 'package:ClickHub/utils/routes/routes_name.dart';
import 'package:ClickHub/utils/utils.dart';
import 'package:ClickHub/view/account/account_screen.dart';
import 'package:ClickHub/view/activity/activity_screen.dart';
import 'package:ClickHub/view/home/home_screen.dart';
import 'package:ClickHub/view/promotion/promotion_screen.dart';
import 'package:ClickHub/view/wallet/wallet_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'widget/bottom_widget.dart';

class BottomNavBar extends StatefulWidget {
  final int initialIndex;
  const BottomNavBar({super.key, this.initialIndex=0});
  // const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _lastSelected = 0;

  final List<Widget> _tabs = [
    const HomeScreen(),
    const ActivityScreen(),
    const PromotionScreen(),
    const WalletScreen(),
    const AccountScreen(),
  ];

  void _selectedTab(int index) {
    setState(() {
      _lastSelected = index;
    });
  }

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky,
        overlays: []);
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args != null && args is int) {
        setState(() {
          _lastSelected = args; // Assign received data to the variable
        });
      }
    });
  }
  Future<bool> _onWillPop() async {
    if (_lastSelected > 0) {
      setState(() {
        _lastSelected=0;
      });
      return false; // Do not pop the route
    } else {
      return  await Utils.showExitConfirmation(context)?? false; // Return false if the dialog is dismissed
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onWillPop,
      child: Scaffold(
        body: _tabs[_lastSelected],
        bottomNavigationBar: FabBottomNavBar(
          color: Colors.black,
          selectedColor: Colors.red,
          notchedShape: const CircularNotchedRectangle(),
          onTabSelected: _selectedTab,
          backgroundColor: Colors.white,
          items: [
            FabBottomNavBarItem(
              imageData: _lastSelected == 0 ? Assets.iconsHomeColor : Assets.iconsHome,
                text: 'Home'
            ),
            FabBottomNavBarItem(
              imageData: _lastSelected == 1 ? Assets.iconsActivityColor : Assets.iconsActivity,
              text: 'Activity',
            ),
            FabBottomNavBarItem(
              imageData: '',
              text: 'Promotion',
            ),
            FabBottomNavBarItem(
              imageData:
              _lastSelected == 3 ? Assets.iconsWalletColor : Assets.iconsWallet,
              text: 'Wallet',
            ),
            FabBottomNavBarItem(
              imageData: _lastSelected == 4 ? Assets.iconsAccountColor : Assets.iconsAccount,
              text: 'Account',
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          shape: const StadiumBorder(),
          onPressed: () {
              setState(() {
                _selectedTab(2);
                selectedIndex=2;
              });
          },
          elevation: 0,
          child: SvgPicture.asset(Assets.iconsPromotion,fit: BoxFit.cover,height: 100)
        ),
      ),
    );
  }
}
class FeedbackProvider {
  static void navigateTohome(BuildContext context) {
    Navigator.pushNamed(context, RoutesName.bottomNavBar,arguments: 0);
  }

  static void navigateToActivity(BuildContext context) {
    Navigator.pushNamed(context, RoutesName.bottomNavBar,arguments: 1);
  }

  static void navigateToPromotion(BuildContext context) {
    Navigator.pushNamed(context, RoutesName.bottomNavBar,arguments: 2);
  }

  static void navigateToWallet(BuildContext context) {
    Navigator.pushNamed(context, RoutesName.bottomNavBar,arguments: 3);
  }
  static void navigateToAccount(BuildContext context) {
    Navigator.pushNamed(context, RoutesName.bottomNavBar,arguments: 4);
  }


}

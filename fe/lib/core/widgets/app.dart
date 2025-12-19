import 'package:fe/core/theme/app_palette.dart';
import 'package:fe/core/widgets/pages/fridge_manager.dart';
import 'package:fe/core/widgets/pages/meal_planner.dart';
import 'package:fe/core/widgets/pages/notifications.dart';
import 'package:fe/core/widgets/pages/report.dart';
import 'package:fe/core/widgets/shopping.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class App extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (_) => const App());
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with TickerProviderStateMixin {
  late TabController _tabController;
  bool _isMiddlePressed = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _onMiddleButtonPressed() {
    setState(() {
      _isMiddlePressed = true;
      _tabController.index = 2; // chuyển sang trang riêng cho float
    });
  }

  void _onTabTapped(int index) {
    setState(() {
      _isMiddlePressed = false;
      _tabController.index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GFTabBarView(
        controller: _tabController,
        children: const <Widget>[
          ReportPage(),
          FridgeManagerPage(),
          ShoppingAssignPage(),
          MealPlannerPage(),
          NotificationsPage(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: _onMiddleButtonPressed,
        backgroundColor: AppPalette.darkColor,
        elevation: 6,
        child: const Icon(
          Icons.shopping_cart_rounded,
          size: 35,
          color: AppPalette.whiteColor,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: GFTabBar(
        tabBarHeight: 40.0,
        controller: _tabController,
        length: _tabController.length+1,
        tabBarColor: AppPalette.backgroundColor,
        indicatorColor: AppPalette.transparentColor,
        labelColor: AppPalette.darkColor,
        unselectedLabelColor: AppPalette.greyColor,
        tabs: <Widget>[
          GestureDetector(
            onTap: () => _onTabTapped(0),
            child: Tab(
              icon: Icon(Icons.home,
                  size: 35,
                  color: (!_isMiddlePressed && _tabController.index == 0)
                      ? AppPalette.darkColor
                      : AppPalette.greyColor),
            ),
          ),
          GestureDetector(
            onTap: () => _onTabTapped(1),
            child: Tab(
              icon: Icon(Icons.kitchen,
                  size: 35,
                  color: (!_isMiddlePressed && _tabController.index == 1)
                      ? AppPalette.darkColor
                      : AppPalette.greyColor),
            ),
          ),
          const Tab(icon: SizedBox.shrink()),
          GestureDetector(
            onTap: () => _onTabTapped(3),
            child: Tab(
              icon: Icon(Icons.local_dining,
                  size: 35,
                  color: (!_isMiddlePressed && _tabController.index == 3)
                      ? AppPalette.darkColor
                      : AppPalette.greyColor),
            ),
          ),
          GestureDetector(
            onTap: () => _onTabTapped(4),
            child: Tab(
              icon: Icon(Icons.notifications,
                  size: 35,
                  color: (!_isMiddlePressed && _tabController.index == 4)
                      ? AppPalette.darkColor
                      : AppPalette.greyColor),
            ),
          ),
        ],
      ),
    );
  }
}


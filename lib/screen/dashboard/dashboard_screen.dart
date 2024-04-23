// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:secucalls/common/radial_chart.dart';
import 'package:secucalls/constant/design_size.dart';
import 'package:secucalls/constant/style.dart';
import 'package:secucalls/screen/dashboard/dashboard_screen_def.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    number = "3.234.111";
    _tabController = TabController(length: 3, vsync: this);
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void tapOnForgetPasswordButton() {
    print('move to forget password');
    Navigator.of(context).pushNamed('/ForgetPassword');
    _scaffoldKey.currentState?.openEndDrawer();
  }

  void tapOnLogOutButton() {
    print('move to log out');
    Navigator.pushNamedAndRemoveUntil(context, '/Login', (route) => false);
  }

  void tapOnHomeButton() {
    print('home');
    _scaffoldKey.currentState?.openEndDrawer();
  }

  void tapOnCallLogButton() {
    print('move to call log');
    // TODO
  }

  late String number;
  late final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: fullScreenPortraitSize,
      child: SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          drawer: CustomDrawer(
            tapOnForgetPasswordButton: tapOnForgetPasswordButton,
            tapOnHomeButton: tapOnHomeButton,
            tapOnLogOutButton: tapOnLogOutButton,
            tapOnCallLogButton: tapOnCallLogButton,
          ),
          // You can design your splash screen UI here
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              title_appbar,
              textAlign: TextAlign.center,
              style: textBlack21Italic,
            ),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomTotalFigure(number: number),
              SizedBox(
                height: 10.h,
              ),
              CustomTabBar(tabController: _tabController),
              Container(
                height: 15.h,
                decoration: BoxDecoration(color: Colors.grey.shade200),
              ),
              CustomTabBarView(tabController: _tabController)
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }
}

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
    required this.tapOnForgetPasswordButton,
    required this.tapOnHomeButton,
    required this.tapOnLogOutButton, 
    required this.tapOnCallLogButton,
  });
  final VoidCallback tapOnForgetPasswordButton;
  final VoidCallback tapOnHomeButton;
  final VoidCallback tapOnLogOutButton;
  final VoidCallback tapOnCallLogButton;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        children: [
          SizedBox(
            height: height_drawer_header.h,
            width: double.infinity,
            child: DrawerHeader(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    alignment: Alignment.bottomCenter,
                    "lib/assets/logo.png",
                    width: size_logo.width.w,
                    height: size_logo.height.h,
                  ),
                  const FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      title_appbar,
                      style: textBlack28Italic,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: top_margin_drawer_item.h,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: left_margin_drawer_item.w,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomListTile(
                  title: title_drawer_item_1,
                  icon: Icons.home,
                  onPress: tapOnHomeButton,
                ),
                SizedBox(
                  height: 10.h,
                ),
                CustomListTile(
                  title: title_drawer_item_4,
                  icon: Icons.phone,
                  onPress: tapOnCallLogButton,
                ),
                SizedBox(
                  height: 10.h,
                ),
                CustomListTile(
                  title: title_drawer_item_2,
                  icon: Icons.account_box,
                  onPress: tapOnForgetPasswordButton,
                ),
                SizedBox(
                  height: 10.h,
                ),
                CustomListTile(
                  title: title_drawer_item_3,
                  icon: Icons.logout_outlined,
                  onPress: tapOnLogOutButton,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    required this.title,
    required this.icon,
    required this.onPress,
  });
  final String title;
  final IconData icon;
  final VoidCallback onPress;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        size: size_icon.height.h,
        color: Colors.black,
      ),
      title: Text(
        title,
        style: textBlack19,
      ),
      onTap: onPress,
    );
  }
}

class CustomTabBarView extends StatelessWidget {
  const CustomTabBarView({
    super.key,
    required TabController tabController,
  }) : _tabController = tabController;

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        width: double.infinity,
        child: TabBarView(
          controller: _tabController,
          children: const <Widget>[
            DashboardPanel(percentageList: [20.0, 75.0, 80.0, 100.0]),
            DashboardPanel(percentageList: [30.0, 65.0, 50.0, 75.0]),
            DashboardPanel(percentageList: [60.0, 35.0, 20.0, 15.0]),
          ],
        ),
      ),
    );
  }
}

class CustomTotalFigure extends StatelessWidget {
  const CustomTotalFigure({
    super.key,
    required this.number,
  });

  final String number;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size_display_box.height.h,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: top_margin_total_number.h,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: left_margin_total_number.w,
              right: left_margin_total_number.w,
            ),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                number,
                style: textBlack28Italic,
              ),
            ),
          ),
          SizedBox(
            height: top_margin_title.h,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: left_margin_title.w,
              right: left_margin_title.w,
            ),
            child: const FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                text_title,
                style: textBlack21Italic,
              ),
            ),
          ),
          SizedBox(
            height: top_margin_sub_title.h,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                left: left_margin_sub_title.w,
                right: left_margin_sub_title.w,
              ),
              child: const FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  sub_text_title,
                  style: textBlack21Italic,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({
    super.key,
    required TabController tabController,
  }) : _tabController = tabController;

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: _tabController,
      labelColor: Colors.black,
      indicatorSize: TabBarIndicatorSize.tab,
      indicatorColor: Colors.black,
      unselectedLabelColor: Colors.grey.shade500,
      padding: EdgeInsets.zero,
      tabs: <Widget>[
        Tab(
          child: SizedBox(
            width: MediaQuery.of(context).size.width / 3,
            child: const Text(
              text_day,
              textAlign: TextAlign.center,
              style: textBlack21Italic,
            ),
          ),
        ),
        Tab(
          child: SizedBox(
            width: MediaQuery.of(context).size.width / 3,
            child: const Text(
              text_week,
              textAlign: TextAlign.center,
              style: textBlack21Italic,
            ),
          ),
        ),
        Tab(
          child: SizedBox(
            width: MediaQuery.of(context).size.width / 3,
            child: const Text(
              text_month,
              textAlign: TextAlign.center,
              style: textBlack21Italic,
            ),
          ),
        ),
      ],
    );
  }
}

class DashboardPanel extends StatelessWidget {
  const DashboardPanel({super.key, required this.percentageList});
  final List<dynamic> percentageList;

  @override
  Widget build(BuildContext context) {
    final double _trashNumber = percentageList[0];
    final double _cheatNumber = percentageList[1];
    final double _adsNumber = percentageList[2];
    final double _totalNumber = percentageList[3];
    final double heightRow = height_tab_bar_view.h / 2;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.h),
      width: double.infinity,
      child: Column(
        children: [
          SizedBox(
            height: heightRow,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RadialChart(
                  label: text_sorac,
                  value: _trashNumber,
                  color: Colors.deepOrange.shade300,
                ),
                RadialChart(
                  label: text_soluadao,
                  value: _cheatNumber,
                  color: Colors.orangeAccent,
                ),
              ],
            ),
          ),
          SizedBox(
            height: heightRow,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RadialChart(
                  label: text_soquangcao,
                  value: _adsNumber,
                  color: Colors.pinkAccent,
                ),
                RadialChart(
                  label: text_tongso,
                  value: _totalNumber,
                  color: Colors.green,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

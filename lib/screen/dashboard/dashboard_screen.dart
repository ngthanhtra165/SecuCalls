import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:secucalls/common/appbar.dart';
import 'package:secucalls/common/button.dart';
import 'package:secucalls/common/radial_chart.dart';
import 'package:secucalls/common/text_field.dart';
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

  late String number;
  late final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: fullScreenPortraitSize,
      child: SafeArea(
        child: Scaffold(
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
                SizedBox(
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
                ),
                const SizedBox(
                  height: 10,
                ),
                TabBar(
                  controller: _tabController,
                  labelColor: Colors.black,
                  indicatorColor: Colors.black,
                  unselectedLabelColor: Colors.grey.shade500,
                  padding: EdgeInsets.zero,
                  tabs: <Widget>[
                    Tab(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 3,
                        child: const Text(text_day, textAlign: TextAlign.center, style: TextStyle(
                          fontSize: 25,
                            fontWeight: FontWeight.normal,
                          fontFamily: "ABeeZee"
                        ),),
                      ),
                    ),
                    Tab(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 3,
                        child: const Text(text_week, textAlign: TextAlign.center, style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.normal,
                            fontFamily: "ABeeZee"
                        ),),
                      ),
                    ),
                    Tab(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 3,
                        child: const Text(text_month, textAlign: TextAlign.center, style: TextStyle(
                            fontSize: 25,
                          fontWeight: FontWeight.normal,
                            fontFamily: "ABeeZee"
                        ),),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 15,
                  decoration: BoxDecoration(color: Colors.grey.shade200),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height -
                      350, // Check lại, trừ đi height của đoạn phía trên tab bar để responsive
                  child: TabBarView(
                    controller: _tabController,
                    children: <Widget>[
                      DashboardPanel(type: text_day),
                      DashboardPanel(type: text_week),
                      DashboardPanel(type: text_month),
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }
}

class DashboardPanel extends StatelessWidget {
  final String type;

  DashboardPanel({required this.type});

  @override
  Widget build(BuildContext context) {
    // mock call api, sau thay bằng giá trị trả về từ api
    final double _trashNumber = type == text_day ? 75.0 : type == text_week ? 64.0 : 32.0;
    final double _cheatNumber = type == text_day ? 25.0 : type == text_week ? 30.0 : 17.0;
    final double _adsNumber = type == text_day ? 50.0 : type == text_week ? 37.0 : 22.0;
    final double _totalNumber = type == text_day ? 75.0 : type == text_week ? 80.0 : 66.0;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RadialChart(
                  label: "Số rác",
                  value: _trashNumber,
                  color: Colors.deepOrange.shade300),
              RadialChart(
                  label: "Số lừa đảo", value: _cheatNumber, color: Colors.orangeAccent)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RadialChart(
                  label: "Số quảng cáo", value: _adsNumber, color: Colors.pinkAccent),
              RadialChart(label: "Tổng số", value: _totalNumber, color: Colors.green)
            ],
          )
        ],
      ),
    );
  }
}

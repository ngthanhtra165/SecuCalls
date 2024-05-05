// ignore_for_file: avoid_print

import 'package:call_log/call_log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:secucalls/common/drawer.dart';
import 'package:secucalls/constant/constants.dart';
import 'package:secucalls/constant/design_size.dart';
import 'package:secucalls/constant/style.dart';
import 'package:secucalls/model/my_number_call_log_model.dart';
import 'package:secucalls/model/spam_number.dart';
import 'package:secucalls/screen/call_log/call_log_screen_def.dart';
import 'package:secucalls/service/api_service.dart';
import 'package:secucalls/utils/phone_number_update.dart';

class CallLogScreen extends StatefulWidget {
  const CallLogScreen({super.key});

  @override
  State<CallLogScreen> createState() => _CallLogScreenState();
}

class _CallLogScreenState extends State<CallLogScreen>
    with TickerProviderStateMixin {
  // List<String> recentCalls = [];
  // List<String> missedCalls = [];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<MyNumberCallLog> recentCalls = [];

  List<MyNumberCallLog> missedCalls = [];

  late final TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    fetchDataFromServer(context);
    _getCallLogs();
  }

  void _getCallLogs() async {
    final Iterable<CallLogEntry> cLog = await CallLog.get();
    if (!Hive.isBoxOpen("recent_calls")) {
      await Hive.openBox("recent_calls");
    }

    final Box box = Hive.box("recent_calls");
    await box.clear();

    for (CallLogEntry entry in cLog) {
      print('-------------------------------------');
      print('F. NUMBER  : ${entry.formattedNumber}');
      print('C.M. NUMBER: ${entry.cachedMatchedNumber}');
      print('NUMBER     : ${entry.number}');
      print('NAME       : ${entry.name}');
      print('TYPE       : ${entry.callType}');
      print('DURATION   : ${entry.duration}');
      print('ACCOUNT ID : ${entry.phoneAccountId}');
      print('ACCOUNT ID : ${entry.phoneAccountId}');
      print('SIM NAME   : ${entry.simDisplayName}');
      print('-------------------------------------');
      late final TypeOfCall typeOfCall;
      switch (entry.callType) {
        case CallType.incoming:
          typeOfCall = TypeOfCall.incoming;
        case CallType.missed:
          typeOfCall = TypeOfCall.missed;
          final String? name = (entry.name != null)
              ? entry.name
              : await checkInfo(entry.formattedNumber ?? "");
          setState(() {
            missedCalls
                .add(MyNumberCallLog(entry.number ?? "", typeOfCall, name!));
          });
        case CallType.outgoing:
          typeOfCall = TypeOfCall.outgoing;
        default:
          typeOfCall = TypeOfCall.outgoing;
      }
      final String? name = (entry.name != null)
          ? entry.name
          : await checkInfo(entry.formattedNumber ?? "");
      setState(() {
        recentCalls.add(MyNumberCallLog(entry.number ?? "", typeOfCall, name!));
      });
    }
  }

  Future<String> checkInfo(String number) async {
    if (!Hive.isBoxOpen("data_from_server")) {
      await Hive.openBox("data_from_server");
    }
    final Box box = Hive.box("data_from_server");

    final categoryOfNumber = await box.get(number);
    if (categoryOfNumber != null) {
      final spamName = categoryOfNumber["category"].join(', ');
      return spamName;
    }
    return "";
  }

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
    Navigator.of(context).pushNamed('/Dashboard');
    _scaffoldKey.currentState?.openEndDrawer();
  }

  void tapOnCallLogButton() {
    print('move to call log');
    Navigator.of(context).pushNamed('/CallLog');
    _scaffoldKey.currentState?.openEndDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: fullScreenPortraitSize,
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          key: _scaffoldKey,
          drawer: CustomDrawer(
            tapOnForgetPasswordButton: tapOnForgetPasswordButton,
            tapOnHomeButton: tapOnHomeButton,
            tapOnLogOutButton: tapOnLogOutButton,
            tapOnCallLogButton: tapOnCallLogButton,
          ),
          appBar: AppBar(
            toolbarHeight: 110.h,
            title: Container(
              height: 70.h,
              margin: EdgeInsets.only(
                left: left_margin_tab_bar.w,
                right: right_margin_tab_bar.w,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: Colors.black, // specify your desired border color here
                  width: 1.0, // specify your desired border width here
                ),
              ),
              child: TabBar(
                controller: _tabController,
                labelStyle: textGray19Italic,
                indicatorSize: TabBarIndicatorSize.tab,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black,
                indicator: const BoxDecoration(
                  color: Color.fromARGB(255, 3, 90, 160),
                ),
                tabs: const [
                  Tab(
                    text: text_tab_bar_all,
                  ),
                  Tab(
                    text: text_tab_bar_missed_calls,
                  ),
                ],
              ),
            ),
            centerTitle: true,
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              // Recent Calls Tab
              CustomListView(
                listInfo: recentCalls,
              ),
              // Missed Calls Tab
              CustomListView(
                listInfo: missedCalls,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomListView extends StatelessWidget {
  const CustomListView({
    super.key,
    required this.listInfo,
  });

  final List<MyNumberCallLog> listInfo;

  IconData iconDataForCallType(TypeOfCall type) {
    switch (type) {
      case TypeOfCall.missed:
        return Icons.call_missed;
      case TypeOfCall.incoming:
        return Icons.call_received;
      case TypeOfCall.outgoing:
        return Icons.call_made;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: listInfo.length,
            itemBuilder: (context, index) {
              return Container(
                height: height_list_title.h,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      width: 1.0,
                      color: Colors.grey.shade200,
                    ),
                    bottom: BorderSide(
                      width: 1.0,
                      color: Colors.grey.shade200,
                    ),
                  ),
                ),
                child: ListTile(
                  title: Text(
                    listInfo[index].cachedMatchedNumber,
                    style: textBlack18,
                  ),
                  leading: Icon(iconDataForCallType(listInfo[index].callType)),
                  subtitle: Text(
                    listInfo[index].name,
                    style: textGray15Italic,
                  ),
                  onTap: () {
                    // Handle tap on recent call
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

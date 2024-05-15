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
import 'package:secucalls/screen/call_log/call_log_screen_def.dart';
import 'package:secucalls/utils/data_call.dart';
import 'package:secucalls/utils/drawer.dart';
    
class CallLogScreen extends StatefulWidget {
  const CallLogScreen({super.key});

  @override
  State<CallLogScreen> createState() => _CallLogScreenState();
}

class _CallLogScreenState extends State<CallLogScreen>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<MyNumberCallLog> recentCalls = [];

  List<MyNumberCallLog> missedCalls = [];

  late final TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
      late final TypeOfCall typeOfCall;
      switch (entry.callType) {
        case CallType.incoming:
          typeOfCall = TypeOfCall.incoming;
        case CallType.missed:
          typeOfCall = TypeOfCall.missed;
          final String? name = (entry.name != null)
              ? entry.name
              : await checkCallInfoInDatabase(entry.formattedNumber ?? "", false);
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
          : await checkCallInfoInDatabase(entry.formattedNumber ?? "", false);
      setState(() {
        recentCalls.add(MyNumberCallLog(entry.number ?? "", typeOfCall, name!));
      });
    }
  }

  void tapOnChangePasswordButton() {
    DrawerUtils.tapOnChangePasswordButton(context, _scaffoldKey);
  }

  void tapOnLogOutButton() async {
    DrawerUtils.tapOnLogOutButton(context);
  }

  void tapOnHomeButton() {
    DrawerUtils.tapOnHomeButton(context, _scaffoldKey);
  }

  void tapOnCallLogButton() {
    DrawerUtils.tapOnSameButton(_scaffoldKey);
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
            tapOnChangePasswordButton: tapOnChangePasswordButton,
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

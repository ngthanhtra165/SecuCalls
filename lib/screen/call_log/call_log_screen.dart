import 'package:flutter/material.dart';
import 'package:call_log/call_log.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:secucalls/common/drawer.dart';
import 'package:secucalls/constant/design_size.dart';
import 'package:secucalls/constant/style.dart';
import 'package:secucalls/screen/call_log/call_log_screen_def.dart';

class CallLogScreen extends StatefulWidget {
  CallLogScreen({super.key});

  @override
  State<CallLogScreen> createState() => _CallLogScreenState();
}

class _CallLogScreenState extends State<CallLogScreen>
    with TickerProviderStateMixin {
  // List<String> recentCalls = [];
  // List<String> missedCalls = [];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<String> recentCalls = [
    "John Doe",
    "Jane Smith",
    "Alice Johnson",
  ];

  final List<String> missedCalls = [
    "Bob Johnson",
    "Kate Williams",
  ];

  late final TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _getCallLogs();
  }

  void _getCallLogs() async {
    var entries = await CallLog.get();
    // setState(() {
    //   recentCalls = entries
    //       .where((entry) =>
    //           entry.callType == CallType.outgoing ||
    //           entry.callType == CallType.incoming).cast<String>()
    //       .toList();
    //   missedCalls =
    //       entries.where((entry) => entry.callType == CallType.missed).cast<String>().toList();
    // });
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
            toolbarHeight: 100.h,
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
                iconData: Icons.call_received,
              ),
              // Missed Calls Tab
              CustomListView(
                listInfo: missedCalls,
                iconData: Icons.call_missed,
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
    required this.iconData,
  });
  Widget checkInfo(String number) {
    return Text(
      "huhu",
      style: textGray15Italic,
    );
  }

  final List<String> listInfo;
  final IconData iconData;
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
                    listInfo[index],
                    style: textBlack18,
                  ),
                  leading: Icon(iconData),
                  subtitle: checkInfo(listInfo[index]),
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

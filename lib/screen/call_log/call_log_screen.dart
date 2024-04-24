import 'package:flutter/material.dart';
import 'package:call_log/call_log.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:secucalls/common/drawer.dart';
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      drawer: CustomDrawer(
        tapOnForgetPasswordButton: tapOnForgetPasswordButton,
        tapOnHomeButton: tapOnHomeButton,
        tapOnLogOutButton: tapOnLogOutButton,
        tapOnCallLogButton: tapOnCallLogButton,
      ),
      appBar: AppBar(
        title: Container(
          margin: EdgeInsets.only(
            top: top_margin_tab_bar.h,
            bottom: top_margin_tab_bar.h,
            left: left_margin_tab_bar.w,
            right: right_margin_tab_bar.w,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
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
              color: Color.fromARGB(255, 8, 136, 240),
            ),
            tabs: [
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
          ListView.builder(
            itemCount: recentCalls.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(recentCalls[index]),
                leading: Icon(Icons.call_received),
                onTap: () {
                  // Handle tap on recent call
                },
              );
            },
          ),

          // Missed Calls Tab
          ListView.builder(
            itemCount: missedCalls.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(missedCalls[index]),
                leading: Icon(Icons.call_missed),
                onTap: () {
                  // Handle tap on missed call
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

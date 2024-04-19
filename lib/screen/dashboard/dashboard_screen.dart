import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:secucalls/common/appbar.dart';
import 'package:secucalls/common/button.dart';
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

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    number = "3.234.111";
  }

  late String number;
  

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: fullScreenPortraitSize,
      child: SafeArea(
        child: Scaffold(
          drawer: Drawer(
            backgroundColor: Colors.blueAccent.shade100,
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
                          alignment : Alignment.bottomCenter,
                          "lib/assets/logo.png",
                          width: size_logo.width.w,
                          height: size_logo.height.h,
                        ),
                        const FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            title_appbar,
                            style: textWhite26Italic,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: top_margin_drawer_item.h,),
                Padding(
                  padding: EdgeInsets.only(left: left_margin_drawer_item.w,),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ListTile(
                        leading: Icon(Icons.abc),
                        title: Text("Trang Chu"),
                        onTap: () {},
                      ),
                    ],
                  ),
                )
              ],
            ),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}

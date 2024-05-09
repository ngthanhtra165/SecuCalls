import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:secucalls/constant/style.dart';
import 'package:secucalls/screen/dashboard/dashboard_screen_def.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
    required this.tapOnChangePasswordButton,
    required this.tapOnHomeButton,
    required this.tapOnLogOutButton, 
    required this.tapOnCallLogButton,
  });
  final VoidCallback tapOnChangePasswordButton;
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
                  onPress: tapOnChangePasswordButton,
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
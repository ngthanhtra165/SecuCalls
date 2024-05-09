// import 'package:contacts_service/contacts_service.dart';
// import 'package:permission_handler/permission_handler.dart';

// void updatePhoneContacts() async {
//   PermissionStatus permissionStatus = await _getContactPermission();
//   if (permissionStatus == PermissionStatus.granted) {
//     List<Contact> contacts =
//         await ContactsService.getContacts(withThumbnails: false);
//     Map<String, String>
//     for (var contact in contacts) {
//       print(
//           "name is ${contact.displayName} and name 2 is ${contact.androidAccountName}");
//       var listNumber = contact.phones ?? [];
//       for (var numer in listNumber) {
//         print("number value ${numer.value} and number key is ${numer.label}");
//       }
//     }
//   }
// }

// Future<PermissionStatus> _getContactPermission() async {
//   PermissionStatus permission = await Permission.contacts.status;
//   if (permission != PermissionStatus.granted &&
//       permission != PermissionStatus.permanentlyDenied) {
//     PermissionStatus permissionStatus = await Permission.contacts.request();
//     return permissionStatus;
//   } else {
//     return permission;
//   }
// }

// ignore_for_file: use_build_context_synchronously

import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:secucalls/service/api_service.dart';
import 'package:secucalls/utils/common_function.dart';

Future<void> fetchDataFromServer(BuildContext context) async {
  try {
    final response = await APIService.shared.fetchData();
    print("fetch data xong");
    if (!Hive.isBoxOpen("data_from_server")) {
      await Hive.openBox("data_from_server");
    }

    final Box box = Hive.box("data_from_server");
    await box.clear();
    print("clear box");
    for (var call in response["data"]) {
      final List<String> category = (call['category'] == null)
          ? []
          : convertListDynamicToListString(call['category']);

      final List<String> description = (call['description'] == null)
          ? []
          : convertListDynamicToListString(call['description']);

      box.put(call['phone_number'].toString(), {
        "category": category,
        "description": description,
        "phone_number": call["phone_number"].toString(),
        "type": call["type"].toString(),
      });
    }
    print("list count is ${response["data"].length}");
    box.put("0345827894", {
      "category": ["Lua dao cua dai hoc fpt"],
      "description": [""],
      "phone_number": "0345827894",
      "type": "null",
    });
  } catch (e) {
    showSnackBar(context, e.toString(), 5);
  }
}

List<String> convertListDynamicToListString(List<dynamic> list) {
  final List<String> info = [];
  for (var element in list) {
    info.add(element.toString());
  }
  return info;
}

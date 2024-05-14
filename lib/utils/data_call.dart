// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:contacts_service/contacts_service.dart';  
import 'package:permission_handler/permission_handler.dart';
import 'package:secucalls/service/api_service.dart';
import 'package:secucalls/utils/common_function.dart';

void updatePhoneContacts() async {
  PermissionStatus permissionStatus = await _getContactPermission();
  if (permissionStatus == PermissionStatus.granted) {
    List<Contact> contacts =
        await ContactsService.getContacts(withThumbnails: false);

    // for (var contact in contacts) {
    //   print(
    //       "name is ${contact.displayName} and name 2 is ${contact.androidAccountName}");
    //   var listNumber = contact.phones ?? [];
    //   for (var numer in listNumber) {
    //     print("number value ${numer.value} and number key is ${numer.label}");
    //   }
    // }
  }
}

Future<PermissionStatus> _getContactPermission() async {
  PermissionStatus permission = await Permission.contacts.status;
  if (permission != PermissionStatus.granted &&
      permission != PermissionStatus.permanentlyDenied) {
    PermissionStatus permissionStatus = await Permission.contacts.request();
    return permissionStatus;
  } else {
    return permission;
  }
}

Future<void> fetchDataFromServer(BuildContext context) async {
  try {
    final response = await APIService.shared.fetchData();
    if (!Hive.isBoxOpen("data_from_server")) {
      await Hive.openBox("data_from_server");
    }

    final Box box = Hive.box("data_from_server");
    await box.clear();
    print("clear box");
    Set<String> uniqueCategory = Set<String>();
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

Future<void> getInformationFromCall(String? number) async {
  if (number == null) {
    return;
  }
  PermissionStatus permissionStatus = await _getContactPermission();
  if (permissionStatus != PermissionStatus.granted) {
    return;
  }

  if (!Hive.isBoxOpen("data_contacts")) {
    await Hive.openBox("data_contacts");
  }

  // check in contacts
  final Box box = Hive.box("data_contacts");

  var contactOfNumber = await box.get(number);
  if (contactOfNumber != null) {
    saveIncomingCallIInfo(number: number, name: contactOfNumber);
    return;
  }
  // check in database
  contactOfNumber = checkCallInfoInDatabase(number, true);
  saveIncomingCallIInfo(number: number, name: contactOfNumber);
}

Future<void> saveIncomingCallIInfo(
    {required String number, required String name}) async {
  if (!Hive.isBoxOpen("current_incoming_call")) {
    await Hive.openBox("current_incoming_call");
  }
  final Box box = Hive.box("current_incoming_call");

  await box.put("current_call_name", number);
  await box.put("current_call_number", name);

  await box.close();
}

Future<String> checkCallInfoInDatabase(String number , bool isIncomingCall) async {
  if (!Hive.isBoxOpen("data_from_server")) {
    await Hive.openBox("data_from_server");
  }
  final Box box = Hive.box("data_from_server");

  final categoryOfNumber = await box.get(number);

  if (categoryOfNumber != null) {
    final spamName = categoryOfNumber["category"].join(', ');
    if (isIncomingCall) {
      
    }
    return spamName;
  }
  return "";
}

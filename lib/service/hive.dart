

import 'package:hive/hive.dart';

void addStringIntoHive(String name, List<dynamic> infos) async {
  if (!Hive.isBoxOpen(name)) {
    await Hive.openBox<String>(name);
  }
  final Box<String> box = Hive.box<String>(name);
  for (String info in infos) {
    box.add(info);
  }
}

String getString(String name , int position) {
  
}
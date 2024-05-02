import 'package:hive/hive.dart';

void addStringIntoBox(String name, Map<String, dynamic> infos) async {
  if (!Hive.isBoxOpen(name)) {
    await Hive.openBox(name);
  }
  final Box box = Hive.box(name);
  for (final info in infos.entries) {
    box.put(info.key, info.value);
  }
}

Future<String?> getString(String name, String key) async {
  if (!Hive.isBoxOpen(name)) {
    print('box is open $name');
    await Hive.openBox(name);
  }
  final Box box = Hive.box(name);
  print("box is $box");
  return await box.get(key);
}

void resetToken() async {
  await Hive.openBox("refresh");
  Hive.close();
}

void clearBox(String name) async {
  if (!Hive.isBoxOpen(name)) {
    await Hive.openBox(name);
  }
  final Box box = Hive.box(name);
  box.clear();
}

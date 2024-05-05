import 'package:hive/hive.dart';

Future<void> addStringIntoBox(String name, Map<String, dynamic> infos) async {
  if (!Hive.isBoxOpen(name)) {
    await Hive.openBox(name);
  }
  final Box box = Hive.box(name);
  for (final info in infos.entries) {
    await box.put(info.key, info.value);
  }
}

Future<String?> getString(String name, String key) async {
  if (!Hive.isBoxOpen(name)) {
    await Hive.openBox(name);
  }
  final Box box = Hive.box(name);
  return await box.get(key);
}

void resetToken() async {
  await Hive.openBox("refresh");
  await Hive.close();
}

Future<void> clearBox(String name) async {
  if (!Hive.isBoxOpen(name)) {
    await Hive.openBox(name);
  }
  final Box box = Hive.box(name);
  await box.clear();
}

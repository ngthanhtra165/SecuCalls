import 'package:call_log/call_log.dart';
import 'package:hive/hive.dart';

part 'spam_number.g.dart';

@HiveType(typeId: 1) // Unique typeId for each Hive model
class MySpamNumber extends HiveObject {
  @HiveField(0)
  final List<String> category;

  @HiveField(1)
  final List<String> description;

  @HiveField(2)
  final String phoneNumber;

  @HiveField(3)
  final String type;

  MySpamNumber(this.category, this.description, this.phoneNumber, this.type);
}

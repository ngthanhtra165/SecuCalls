
import 'package:call_log/call_log.dart';
import 'package:hive/hive.dart';

part 'my_number_call_log_model.g.dart';

@HiveType(typeId: 0) // Unique typeId for each Hive model
class MyNumberCallLog extends HiveObject {
  @HiveField(0)
  final String cachedMatchedNumber;

  @HiveField(1)
  final CallType callType;

  @HiveField(2)
  final CallType name;

  MyNumberCallLog(this.cachedMatchedNumber, this.callType, this.name);
}
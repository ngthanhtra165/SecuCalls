
import 'package:secucalls/constant/constants.dart';
// Unique typeId for each Hive model
class MyNumberCallLog {

  final String cachedMatchedNumber;

  final TypeOfCall callType;


  final String name;

  MyNumberCallLog(this.cachedMatchedNumber, this.callType, this.name);
}
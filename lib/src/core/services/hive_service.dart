import 'package:hive/hive.dart';

class HiveService {
  HiveService._();


  static Future<void> initHive() async {
    await Hive.openBox('AppBox');
  }

  static final box = Hive.box('AppBox');


  static Future<void> saveThreadId(String threadId) async {
    await box.put('thread', threadId);
  }
  static String getThreadId() {
    return box.get('thread') ?? "";
  }
  static Future<void> removeThreadId() async {
    await box.delete('thread');
  }

  static Future<void> saveUserId(String threadId) async {
    await box.put('userId', threadId);
  }
  static String getUserId() {
    return box.get('userId') ?? "";
  }
  static Future<void> removeUserId() async {
    await box.delete('userId');
  }
}
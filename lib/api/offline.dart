import 'package:shared_preferences/shared_preferences.dart';

class OfflineHelper {
  static Future putDataNews(String data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('news');
    await prefs.setString('news', data);
  }

  static Future<String> getDataNews() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('news');
  }

  ///Categories
  static Future putDataCategories(String data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('caty');
    await prefs.setString('caty', data);
  }

  static Future<String> getDataCategories() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('caty');
  }
}

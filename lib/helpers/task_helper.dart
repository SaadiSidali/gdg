import 'package:gdg_app/providers/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class TaskHelper {
  // static bool isDone(String thing) {
  //   return thing.split('###')[1] == '1';
  // }

  static Future<void> setPhone(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('phoneSet')==null) return;
    final url = 'https://gdg-app-22cea.firebaseio.com/tasks/$userId.json';
    final response = await http.get(url);
    final expectedData = response.body as Map<String, dynamic>;
    setFocus(expectedData['focus'].toString());
    setDone('', expectedData['focuses']);
    prefs.setBool('phoneSet', true);
  }

  static Future<String> getFocus() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString('focus');
  }

  static Future<void> setFocus(String focus) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('focus', focus);
  }

  static Future<void> setDone(String focus, [focuses]) async {
    final prefs = await SharedPreferences.getInstance();
    [focuses] != null
        ? prefs.setStringList('focuses', focuses)
        : print('object');
    if (focus.isNotEmpty) {
      prefs.setStringList(
          'focuses', prefs.getStringList('focuses')..add(focus));
      prefs.remove('focus');
    }
  }

  static Future<List<String>> getDoneTasks() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('focuses');
  }

  static Future<void> serverThing(String userId) async {
    // i've been staring at this for the last 30min and i don;t now why
    final prefs = await SharedPreferences.getInstance();
    final focuses = prefs.getStringList('focuses');
    final focus = prefs.getString('focus');
    final url = 'https://gdg-app-22cea.firebaseio.com/tasks/$userId.json';
    http.post(url, body: {
      'focus': focus,
      'focuses': focuses,
    });
  }
}

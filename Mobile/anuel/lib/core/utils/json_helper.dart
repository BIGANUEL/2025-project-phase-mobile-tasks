import 'dart:convert';
class JsonHelper {
  static String encodeList(List<Map<String, dynamic>> list) => json.encode(list);
  static List<dynamic> decodeList(String jsonStr) => json.decode(jsonStr);
}

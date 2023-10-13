
import 'dart:convert';

List<demoListmodal> postFromJson(String str) =>
    List<demoListmodal>.from(json.decode(str).map((x) => demoListmodal.fromMap(x)));


class demoListmodal {
  demoListmodal({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });
  int userId;
  int id;
  String title;
  String body;


  factory demoListmodal.fromMap(Map<String, dynamic> json) => demoListmodal(
    userId :json['userId'],
    id : json['id'],
    title : json['title'],
    body : json['body'],

  );
}

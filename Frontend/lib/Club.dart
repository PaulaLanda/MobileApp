import 'dart:ffi';

import 'User.dart';
import 'dart:convert';
import 'User.dart';

class Club {
  String photo = "";
  int id = 0;
  String name = "";
  String address = "";
  User userP = User();
  String m = "";
  String t = "";
  String w = "";
  String th = "";
  String f = "";
  String s = "";
  String d = "";
  List<dynamic> prices;

  Club({
    String? photo,
    int? id,
    String? name,
    String? address,
    User? userP,
    String? m,
    String? t,
    String? w,
    String? th,
    String? f,
    String? s,
    String? d,
    List<dynamic>? prices,
  })  : photo = photo ?? "",
        id = id ?? 0,
        name = name ?? "",
        address = address ?? "",
        userP = userP ?? User(),
        m = m ?? "",
        t = t ?? "",
        w = w ?? "",
        th = th ?? "",
        f = f ?? "",
        s = s ?? "",
        d = d ?? "",
        prices = prices ?? [];

  factory Club.fromJson(Map<String, dynamic> json) {
    return Club(
      id: json['id'] ?? 0,
      name: json['name'] ?? "",
      address: json['address'] ?? "",
      userP: User.fromJson(json['userP'] ?? {}),
      m: json['m'] ?? "",
      t: json['t'] ?? "",
      w: json['w'] ?? "",
      th: json['th'] ?? "",
      f: json['f'] ?? "",
      s: json['s'] ?? "",
      d: json['d'] ?? "",
    );
  }
}

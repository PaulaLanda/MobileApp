import 'dart:ffi';

class User {
   int id = 0;
   String name = "";
   String surname = "";
   String password = "";
   String userType = "";

   User({
      this.id = 0,
      this.name = "",
      this.surname = "",
      this.password = "",
      this.userType = "",
   });

   factory User.fromJson(Map<String, dynamic> json) {
      return User(
         id: json['id'] ?? 0,
         name: json['name'] ?? "",
         surname: json['surname'] ?? "",
         password: json['password'] ?? "",
         userType: json['userType'] ?? "",
      );
   }
}

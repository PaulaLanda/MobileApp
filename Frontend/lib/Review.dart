import 'dart:ffi';

class Review {
   int id = 0;
   String userId = "";
   int clubId = 0;
   int mark = 0;
   String text = "";

   Review({
      this.id = 0,
      this.userId = "",
      this.clubId = 0,
      this.mark = 0,
      this.text = "",
   });

   factory Review.fromJson(Map<String, dynamic> json) {
      return Review(
         id: json['id'] ?? 0,
         userId: json['user'] ?? 0,
         clubId: json['club'] ?? 0,
         mark: json['mark'] ?? 0,
         text: json['text'] ?? "",
      );
   }
}

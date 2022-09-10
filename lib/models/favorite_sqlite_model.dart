import 'package:flutter/material.dart';

class Favorite {
   int id;
   Favorite({
    @required this.id,
  });

   // Convert a Dog into a Map. The keys must correspond to the names of the
   // columns in the database.
   Map<String, dynamic> toMap() {
     return {
       'id': id,
     };
   }
}
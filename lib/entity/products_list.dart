import 'dart:convert';

import 'package:equatable/equatable.dart';

class UserProducts extends Equatable {
  const UserProducts({
    required this.email,
    required this.userProducts,
    required this.summ,
  });

  final String email;
  final int summ;
  final List<String> userProducts;

  UserProducts.fromJson(Map<String, dynamic> map)
      : email = map['email'] as String,
        summ = map['summ'] as int,
        userProducts = new List<String>.from(json.decode(map['chosenProducts']));

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'summ': summ,
      'chosenProducts': jsonEncode(userProducts)
    };
  }

  @override
  String toString() {
    return 'Products: ${userProducts.toString()} Price:  ${summ.toString()}';
  }

  @override
  List<Object> get props => [email, userProducts, summ];
}


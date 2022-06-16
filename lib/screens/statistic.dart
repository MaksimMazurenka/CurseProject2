
import 'package:flutter/material.dart';
import 'package:helper_app/Screens/home_page.dart';
import 'package:helper_app/data/file_handler.dart';
import 'package:helper_app/data/file_handler_products.dart';
import 'package:helper_app/data/filr_handler_boughts.dart';
import 'package:helper_app/entity/products_list.dart';
import 'package:helper_app/entity/user.dart';

class getEmail{

  String userEmail = "";
  dynamic setUserEmail(String email){
    userEmail = email;
  }
  String getUserEmail(){
    return userEmail;
  }
}

class Statistic extends StatefulWidget {
  @override
  State<Statistic > createState() => _StatisticState();
}
int z  = 1;
class _StatisticState extends State<Statistic>{
  List<String> list = [];
  void getUsersData() async{
    Future<List<User>> _users = FileHandler.instance.readUsers();
    List<User> userrs = await _users;
    Future<List<UserProducts>> _selected_products = FileHandlerProduct.instance.readProducts();
    List<UserProducts> selected_products = await _selected_products;
    Future<List<UserProducts>> _purchased_list = FileHandlerBought.instance.readProducts();
    List<UserProducts> purchased_list = await _purchased_list;
    for(int i = 0; i<selected_products.length;i++){
      if(userrs[0].email==selected_products[i].email){
        list.add(selected_products[i].toString());
      }
    }
    list.add("<------------------------------------------------------>");
    for(int i = 1; i<purchased_list.length;i++){
      if(userrs[0].email==purchased_list[i].email){
          list.add(purchased_list[i].toString());
      }
    }
    setState(() {
      z = 2;
    });
  }
  @override
  Widget build(BuildContext context) {
    getUsersData();
    return Scaffold(
      appBar: AppBar(
        title: Text("History"),
      ),
        body: SizedBox(
      width: MediaQuery
          .of(context)
        .size
        .width,
        child: ListView.builder(
        itemCount: list.length, itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 4),
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Text(list[index], style: TextStyle(fontSize: 24)),
            ),
          );
        },
    )
    ));
  }
}

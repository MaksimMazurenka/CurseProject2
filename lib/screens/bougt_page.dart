
import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:helper_app/data/file_handler_products.dart';
import 'package:helper_app/data/filr_handler_boughts.dart';
import 'package:helper_app/entity/products_list.dart';

class BoughtPage extends StatelessWidget {
  final String emailr;
  List<String> selected = [];
  int momomomoney = 0;

  BoughtPage({
    Key? key, required this.emailr
  }) : super(key: key);
  List<String> result = [];

  readProducts() async {
    Future<List<UserProducts>> Userproducts = FileHandlerProduct.instance
        .readProducts();
    List<UserProducts> userrs = await Userproducts;
    List<String> producty = userrs[0].userProducts;
    result = producty;
    return producty;
  }

  String _name = "";

  _changeName(String text){
    _name = text;
    momomomoney = int.parse(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome"),
      ),
      body: Center(
        child: new Column(
          children: [
            CheckboxGroup(
                labels: <String>[
                  "Хлебушек",
                  "Вода",
                  "Сальцесон",
                  "Энергетик",
                  "Молоко",
                  "Пельмени",
                  "Дошик",
                ],
                onChange: (bool isChecked, String label, int index) =>
                    print(""),
                onSelected: (checked) =>
                selected = checked
            ),
            TextField(
                style: TextStyle(fontSize: 22),
                onChanged: _changeName),
            RaisedButton(child: new Text("Confirm"),
              onPressed: () {
                FileHandlerBought.instance.writeProducts(UserProducts(
                    email: emailr,
                    userProducts: selected,
                    summ: momomomoney));
              },
            ),
          ],
        ),
      ),
    );
  }

}

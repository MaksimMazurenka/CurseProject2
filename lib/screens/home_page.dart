
import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:helper_app/Screens/bougt_page.dart';
import 'package:helper_app/Screens/statistic.dart';
import 'package:helper_app/data/file_handler_products.dart';
import 'package:helper_app/entity/products_list.dart';
import 'package:helper_app/image/uploadImage.dart';

class MyHomePage extends StatelessWidget {
  final String emailr;
  List<String> selected = [];
  int momomomoney = 0;

  MyHomePage({
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
      drawer: new Drawer(
          child: new ListView(
            children: <Widget> [
              new ListTile(
                title: new Text('Purchases'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BoughtPage(emailr: emailr)),
                  );
                },
              ),
              new ListTile(
                title: new Text('History'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Statistic()),
                  );
                },
              ),
              new Divider(),
              new ListTile(
                title: new Text('Image Saver'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Imaginate()),
                  );
                },
              ),
            ],
          )
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
                FileHandlerProduct.instance.writeProducts(UserProducts(
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


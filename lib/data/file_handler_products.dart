
import 'dart:convert';
import 'dart:io';

import 'package:helper_app/data/filr_handler_boughts.dart';
import 'package:helper_app/entity/products_list.dart';
import 'package:path_provider/path_provider.dart';

class FileHandlerProduct {

  // Makes this a singleton class, as we want only want a single
  // instance of this object for the whole application
  FileHandlerProduct._privateConstructor();
  static final FileHandlerProduct instance = FileHandlerProduct._privateConstructor();

  static File? _file;
  String userEmail = "";
  // static final _fileName = 'products_file.txt';
  static final _fileName = 'products_file.txt';

  // Get the data file+
  Future<File> get file async {
    if (_file != null) return _file!;

    _file = await _initFile();
    return _file!;
  }

  // Inititalize file
  Future<File> _initFile() async {
    final _directory = await getApplicationDocumentsDirectory();
    final _path = _directory.path;
    return File('$_path/$_fileName');
  }

  static Set<UserProducts> _productSet = {};

  Future<void> writeProducts(UserProducts userProducts) async {
    final File fl = await file;
    _productSet = {};
    _productSet.add(userProducts);
    FileHandlerBought.instance.clearProducts();
    FileHandlerBought.instance.writeProducts(userProducts);
    // Now convert the set to a list as the jsonEncoder cannot encode
    // a set but a list.
     final _productListMap = _productSet.map((e) => e.toJson()).toList();
    //
    await fl.writeAsString(jsonEncode(_productListMap));

  }

  Future<List<UserProducts>> readProducts() async {
    final File fl = await file;
    final _content = await fl.readAsString();

    final List<dynamic> _jsonData = jsonDecode(_content);
    final List<UserProducts> _products = _jsonData
        .map(
          (e) => UserProducts.fromJson(e as Map<String, dynamic>),
    )
        .toList();
    return _products;
  }

  Future<void> deleteProduct(UserProducts products) async {
    final File fl = await file;

    _productSet.removeWhere((e) => e == products);
    //
    await fl.writeAsString(jsonEncode(_productSet));
  }

  Future<void> updateProducts({
    required String email,
    required UserProducts updatedProduct,
  }) async {
    _productSet.removeWhere((e) => e.email == updatedProduct.email);
    await writeProducts(updatedProduct);
  }
}
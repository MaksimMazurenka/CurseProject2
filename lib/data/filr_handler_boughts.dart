
import 'dart:convert';
import 'dart:io';

import 'package:helper_app/data/file_handler_products.dart';
import 'package:helper_app/entity/products_list.dart';
import 'package:path_provider/path_provider.dart';

class FileHandlerBought {

  // Makes this a singleton class, as we want only want a single
  // instance of this object for the whole application
  FileHandlerBought._privateConstructor();
  static final FileHandlerBought instance = FileHandlerBought._privateConstructor();

  static File? _file;
  String userEmail = "";
  static final _fileName = 'bought_file.txt';

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
    Future<List<UserProducts>> selectedProduct = readProducts();
    List<UserProducts> youSelectIt = await selectedProduct;

    _productSet.add(userProducts);
    for(int i=0; i < youSelectIt.length;i++){
      _productSet.add(youSelectIt[i]);
    }
    final _productListMap = _productSet.map((e) => e.toJson()).toList();
    await fl.writeAsString(jsonEncode(_productListMap));

  }

  Future<void> clearProducts() async {
    final File fl = await file;
    _productSet = {};

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
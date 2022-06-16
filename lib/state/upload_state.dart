import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/all.dart';

enum STATE{
  NORMAL,
  PICKED,
  UPLOAD,
  SUCCESS,
  ERROR
}

final uploadState = StateProvider((ref) => STATE.NORMAL);












//вычисление инфляциии на основе продуктовой корзины
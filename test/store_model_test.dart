import 'package:flutter_test/flutter_test.dart';

import 'package:reactivestore/model/store_model.dart';

void main() {
  test('testing length of the list', () {
    final model = StoreModel();
    final totalItems = model.totalItems;

    expect(totalItems, 0);
    model.add({'name':'Daniel','surname':'Moe','age':7});
    model.add({'name':'Marcus','surname':'Doe','age':72});
    model.add({'name':'Jessica','surname':'Smith','age':12});
    expect(model.totalItems, 3);
  });

}
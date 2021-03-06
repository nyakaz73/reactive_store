import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class StoreModel extends ChangeNotifier {
  // This is an Observable we can subscribe to its changes.

  List<Map> _mainList = new List();

  int get totalItems => this._mainList.length;
  List<Map> get itemsList => this._mainList;

  /*Implementing a Composition Design Pattern on a List ADT
    Adding additional operations to the already existing list
  */

  of(BuildContext context, bool listen) {
    return Provider.of<StoreModel>(context, listen: listen); //accessing store
  }

  void add(Map data) {
    this._mainList.add(data);
    notifyListeners();
  }

  void remove(int index) {
    this._mainList.removeAt(index);
    notifyListeners();
  }

  void removeAll() {
    this._mainList.clear();
    notifyListeners();
  }
}


import 'dart:collection';
import 'package:flutter/cupertino.dart';

class StoreModel extends ChangeNotifier{ // This is an Observable we can subscribe to its changes.
  Map<dynamic,dynamic> dataMap =new HashMap();
  List<Map> _mainList = new List();

  /*Implementing a Composition Design Pattern on a List ADT
    Adding additional operations to the already existing list
  */
  void add(Map data){
    print('Adding data'+data.toString());
    this._mainList.add(data);
    print('Data added in model');
    this._mainList.forEach((element) {
      print(element);
      print('NOw the name');
      print(element['name']);
    });
    print(this._mainList);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  void remove(int index){
    this._mainList.removeAt(index);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  void removeAll(){
    this._mainList.clear();
    notifyListeners();
  }

  int get totalItems => this._mainList.length;
  List<Map> get itemsList => this._mainList;

}
library reactivestore;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reactivestore/model/store_model.dart';

class ReactiveStore extends StatefulWidget {
  final Widget child;
  ReactiveStore({@required this.child});

  @override
  ReactiveStoreState createState() {
    return new ReactiveStoreState();
  }
}

class ReactiveStoreState extends State<ReactiveStore> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<StoreModel>(
      create: (context) => StoreModel(),
      child: widget.child,
    );
  }
}

class UpdateUI extends StatefulWidget {
  final Function builder;
  UpdateUI({@required this.builder});

  @override
  UpdateUIState createState() {
    return new UpdateUIState();
  }
}

class UpdateUIState extends State<UpdateUI> {
  @override
  Widget build(BuildContext context) {
    return Consumer<StoreModel>(builder: widget.builder);
  }
}

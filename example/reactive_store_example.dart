import 'package:flutter/material.dart';
import 'package:reactivestore/model/store_model.dart';
import 'package:reactivestore/reactivestore.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ReactiveStore(
      child: MaterialApp(
        title: 'Reactive Store App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(title: 'Reactive Store'),
      )
    );
     
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          new UpdateUI(
            builder: (context, dialogModel, child) => Expanded(
              child: new ListView.builder(
                itemCount:dialogModel.itemsList != null ? dialogModel.totalItems : 0,
                itemBuilder: (BuildContext context, int index) {
                  return new Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text(dialogModel.itemsList[index]['name'].toString() +' ' +dialogModel.itemsList[index]['salary'].toString()),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showDialog(context: context, builder: (_) => MyCustomDialog());
        },
        child: Icon(Icons.person_add),
      ),
    );
  }
}

class MyCustomDialog extends StatefulWidget {
  @override
  MyCustomDialogState createState() {
    return new MyCustomDialogState();
  }
}

class MyCustomDialogState extends State<MyCustomDialog> {
  final formKey = new GlobalKey<FormState>();
  Size deviceSize;

  String name, salary;

  @override
  Widget build(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Container(
          height: deviceSize.height / 2.0,
          child: new Form(
            key: formKey,
            child: new Column(
              children: <Widget>[
                Flexible(
                    child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Padding(
                        padding: EdgeInsets.only(left: 30.0, top: 30.0),
                        child: new Text(
                          "Customer Details",
                          style: TextStyle(
                              fontWeight: FontWeight.w300, fontSize: 25.0),
                        ),
                      ),
                      new Padding(
                        padding: EdgeInsets.all(10.0),
                        child: new ListTile(
                          leading: const Icon(Icons.person_outline),
                          title: new TextFormField(
                            autofocus: false,
                            decoration: InputDecoration(
                              labelText: "Full Name",
                            ),
                            validator: (value) => value.isEmpty
                                ? "Fristname cant\'t be empty"
                                : null,
                            onSaved: (value) => name = value,
                          ),
                        ),
                      ),
                      new Padding(
                        padding: EdgeInsets.all(10.0),
                        child: new ListTile(
                          leading: const Icon(Icons.attach_money),
                          title: new TextFormField(
                            autofocus: false,
                            initialValue: this.salary,
                            keyboardType: TextInputType.numberWithOptions(),
                            decoration: InputDecoration(
                              labelText: "Salary",
                            ),
                            validator: (value) => value.isEmpty
                                ? "Amount No cant\'t be empty"
                                : null,
                            onSaved: (value) => salary = value,
                          ),
                        ),
                      ),
                      new Padding(
                        padding: EdgeInsets.only(right: 0.0),
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            new FlatButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: new Text(
                                  "CANCEL",
                                  style: TextStyle(color: Colors.red),
                                )),
                            new FlatButton(
                                onPressed: () {
                                  addCustomer();
                                },
                                child: new Text(
                                  "ADD",
                                  style: TextStyle(color: Colors.blue),
                                )),
                          ],
                        ),
                      )
                    ],
                  ),
                ))
              ],
            ),
          ),
        ));
  }

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  Future<String> addCustomer() async {
    if (validateAndSave()) {
      //final model = DialogModel(); //Mode is the Observable
      final model = Provider.of<StoreModel>(context);
      model.add({'name': this.name, 'salary': this.salary});
      Navigator.pop(context);
    }
    return "Success";
  }
}



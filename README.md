# Flutter reactive_store package
A new Flutter package which helps developers in managing the state of their apps and creating reactive components/widgets with less boiler plate code.

### Show some :heart: and :star: the repo to support the project

### Screenshots
<img src="https://raw.githubusercontent.com/nyakaz73/reactive_store/master/image0.jpg" width="400em" height="800em" /> <img src="https://raw.githubusercontent.com/nyakaz73/reactive_store/master/image1.jpg" width="400em" height="800em" />

## Getting Started
This package was inspired by the medium post i wrote [here](https://medium.com/@tafadzwalnyamukapa/dialog-state-management-flutter-using-providers-and-change-notifiers-cbd5a59bcf5a) on Dialog State Management in Flutter — using Providers and Change Notifiers.

## Usage
[Example](https://github.com/nyakaz73/Flutter-Footer/blob/master/example/footer_example.dart)

To use this package :

* add the dependancy to your [pubspec.yaml](https://github.com/nyakaz73/Flutter-Footer/blob/master/pubspec.yanl) file.
```yaml
    dependencies:
     flutter:
       sdk:flutter
     reactivestore:
```

### How to Use

The reactivestore package has two classes ie

* 1. [ReactiveStore]()
* 2. [UpdateUI]()

The **ReactiveStore** class is an ansestor class that provides an instance of changes to all its descendants. The ReactiveStore takes a child widget as the root ansestor widget see example below.

```dart
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
     
```
In the example above all descendants of the MyHonePage will be monitored for changes in their states.

The **UpdateUI** is the Consumer Widget for those who are familier with the [provider]() package. The widget is used to update the UI of our application whenever there is a change in state in our application tree.
The [UpdateUI]() widget take a builder as its attribute. The Function builder take three argumement as follows:
```dart
new UpdateUI(
  builder: (BuildContext, StoreModel, Widget)=>child
)

```
The BuildContext is the current context of you widget, StoreModel is the name of the store(you can give any any) and the Widget is the child. See example below:

```dart
new Padding(
  padding: EdgeInsets.all(10.0),
  child: UpdateUI(
    builder: (context,consumerModel,child)=>consumerModel.itemsList !=null?Text(
      consumerModel.totalItems.toString(),
      style: TextStyle(fontWeight: FontWeight.w500,fontSize: 25.0, color: Colors.green),):null,
  )
)

```
### The Store ADT

The above example introduces us to the final piece of our [reactivestore]() which is the [StoreModel]() Abstract Data Type (ADT). The StoreModel  is the store which stores the data. The [StoreModel]() listens for changes in state in our app and **notifies** the Widgets wrapped by the [UpdateUI]() widget. The [StoreModel]() is essentially an **Observable** class.

The data in the store is accessed using the [Provider.of]() . The Provider.of is of type StoreModel, and to access the data without nessessarily changing the  UI you use it with a listen parameter set to false as follows.

```dart
final model = Provider.of<StoreModel>(context,listen:false);
```
The StoreModel  is a List implmented ADT with the following operations:

| Operation                                         | Description    | 
| -------------                                     |:-------------:|
| final model = Provider.of<StoreModel>(context);   | Data access with default listen set to true          |
|                                                   |               |
| model.add({'name':'John','age':5})                                     | add method takes a Map       | 
| model.remove(index)                               | remove method takes the integer index         | 
| model.removeAll()                                 | removed the data in the store          | 
| model.itemsList.isEmpty()                                  | returns true is the store is empty else false          |
| model.itemsList.length                                  | returns the size of the list          |
| model.totalItems                                  | returns the size of the list. Its just a getter method you can use insted of model.itemsList.length          |
| data = model.itemsList                             | returns a list of Maps in the store          | 
| data = model.itemsList[0]                             | returns a Map at index 0          |  
| data = model.itemsList[0]['age']                             | returns the age in the list at index 0          |   


* **NB** The List<E> operations apply as long as you are using **itemsList** key eg model.itemsList.* since the data is being store in a list

## Imports
 After installing the [reactivestore]() package remember the imports
```dart
import 'package:reactivestore/model/store_model.dart';
import 'package:reactivestore/reactivestore.dart';
import 'package:provider/provider.dart';
```

## Simple Example
In this Example i will show you how you can easily manage the state of your app using a [Dialog](https://api.flutter.dev/flutter/material/Dialog-class.html) as a descendant class. 


```dart
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
```
In the above snippet i have imported the reactivestore and a provider package. I have wrapped the root MaterialApp with a ReactiveStore Widget.

```dart
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    TextStyle titleStyle = Theme.of(context).textTheme.subtitle1;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: new Column(
        children: <Widget>[
          new Padding(
              padding: EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text("Total Members:",style: TextStyle(fontWeight: FontWeight.w300,fontSize: 22.0),textAlign: TextAlign.left,),
                ),

                new Padding(
                    padding: EdgeInsets.all(10.0),
                    child: UpdateUI(
                      builder: (context,consumerModel,child)=>consumerModel.itemsList !=null?Text(
                        consumerModel.totalItems.toString(),
                        style: TextStyle(fontWeight: FontWeight.w500,fontSize: 25.0, color: Colors.green),):null,
                    )
                )
              ],
            ),
          ),
          UpdateUI(
              builder: (context,customerModel,child)=>Expanded(
                child: new ListView.builder(
                  itemCount: customerModel.itemsList !=null? customerModel.totalItems:0,
                    itemBuilder: (BuildContext context, int index){
                      return new Padding(
                          padding: EdgeInsets.only(left: 5.0,right: 5.0),
                        child: Card(
                          elevation: 5.0,
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.blue,
                              child: Icon(Icons.person_outline),
                            ),
                            title: Text(customerModel.itemsList[index]['name'], style: titleStyle,),
                            subtitle: Text('\$ ${customerModel.itemsList[index]['salary'].toString()}.00',style: titleStyle,),
                            trailing: new GestureDetector(
                              child: new Icon(Icons.delete, color: Colors.red,),
                              onTap: (){
                                _showAlertDialog('Status', 'Are you sure you want to delete ${customerModel.itemsList[index]['name'].toUpperCase()}',index);
                              },
                            ),
                          ),
                        ),
                      );
                    }
                ),

            ),
          )

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
   void _showAlertDialog(String title, String message, int index){
    final model = StoreModel(); //Model is the Observable
    final x = model.of(context, true); //Use of method in model with context and listen set to true. To update UI

    AlertDialog alertDialog = AlertDialog(
      title: new Icon(Icons.warning, size: 80.0, color: Colors.amber,),
      content: Text(message),
      actions: <Widget>[
        FlatButton(
          child: Text('YES',style: TextStyle(color: Colors.red),),
          onPressed: () {
            x.remove(index);
            Navigator.of(context).pop();
          },
        ),

        FlatButton(
          child: Text('CANCEL'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
    showDialog(
        context: context,
        builder: (_)=>alertDialog
    );
  }
}

```

In the above code notice how we are tracking for chages using the [UpdateUI]() widget
```dart
...
...
new Padding(
  padding: EdgeInsets.all(10.0),
  child: UpdateUI(
    builder: (context,consumerModel,child)=>consumerModel.itemsList !=null?Text(
      consumerModel.totalItems.toString(),
      style: TextStyle(fontWeight: FontWeight.w500,fontSize: 25.0, color: Colors.green),):null,
  ),
),
...
...
```
The  [UpdateUI]() will rebuild whenever something is added to our store. 
* **Nb** The builder in UpdateUI takes three arguments(BuildContext, StoreModel, Widget). You can name the the StoreModel however you want as long as you are using the name to access the data in store. eg  consumerModel as above.

```dart 
...
...
UpdateUI(
  builder: (context,customerModel,child)=>Expanded(
    child: new ListView.builder(
      itemCount: customerModel.itemsList !=null? customerModel.totalItems:0,
        itemBuilder: (BuildContext context, int index){
          return new Padding(
              padding: EdgeInsets.only(left: 5.0,right: 5.0),
            child: Card(
              elevation: 5.0,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Icon(Icons.person_outline),
                ),
                title: Text(customerModel.itemsList[index]['name'], style: titleStyle,),
                subtitle: Text('\$ ${customerModel.itemsList[index]['salary'].toString()}.00',style: titleStyle,),
                trailing: new GestureDetector(
                  child: new Icon(Icons.delete, color: Colors.red,),
                  onTap: (){
                    _showAlertDialog('Status', 'Are you sure you want to delete ${customerModel.itemsList[index]['name'].toUpperCase()}',index);
                  },
                ),
              ),
            ),
          );
        }
    ),
  ),
)
...
...
```
In the above snipped notice how we are accessing the data using a list map conversion

```dart
new Text('\$ ${customerModel.itemsList[index]['salary'].toString()}.00',style: titleStyle,), 
```
As described above remember to use the keyword **itemsList** to access the list data.


The result after the above implemation. Remember to comment out MyCustomDialog call in the floating action button  since we havent implemented it yet.
<img src="image3" width="400em" height="800em" />

Now we need to implement the MyCustomDialog in the floating action button.

```dart

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

  Future addCustomer() async {
    if (validateAndSave()) {
      final model = StoreModel(); //Mode is the Observable
      final x = model.of(context, true); //Use of method in model with context and listen set to true. To update UI
      x.add({'name': this.name, 'salary': this.salary});
      Navigator.pop(context);
    }
  }
}

```
The MyCustomDialog class is the descendant class of the ansestor [ReactiveStore]() class Widget.
Now lets take a look at the **addCustomer** method.  The method will add our data into the store, in this case the name and salary.
To access the data in our store you use the **of** method in the [StoreModel]().
To access while notifying Widgets wrapped by the [UpdateUI]() Widget we use the **of** method in the [StoreModel]() listen set to true. See code below

```dart
...
...
Future addCustomer() async {
  if (validateAndSave()) {
    final model = StoreModel(); //Model is the Observable
    final x = model.of(context, true); //Use of method in model with context and listen set to true. To update UI
    x.add({'name': this.name, 'salary': this.salary});
    Navigator.pop(context);
  }
}
...
...

```
To add data in the store  you use the **add**  method in the [StoreModel](). 
If you want to access the data without neccessarily rebuilding the UI (i.e rebuilding widgets wrapped by UpdateUI Widget) you set the listen parameter to false or directly use the instance of the [StoreModel](). See code below:

```dart
final model  = StoreModel();
final access = model.of(context, false);

//these return the total number of items(items being Maps of data) in  the store without rebuilding the UI
int items = model.itemsList.length; 
int items2 = access.itemsList.length;
```

* **NB** Directly using the StoreModel instance object to access operations in the StoreModel does not the rebuild UI you need to pass the context and listen using the **of** method.



### Pull Requests
I Welcome and i encourage all Pull Requests

## Created and Maintained by
* Author: [Tafadzwa Lameck Nyamukapa](https://github.com/nyakaz73) :
* Email:  [tafadzwalnyamukapa@gmail.com]
* Open for any colleboration and Remote Work!!
* Happy Fluttering!!

### License
```
MIT License

Copyright (c) 2020 Tafadzwa Lameck Nyamukapa

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

```

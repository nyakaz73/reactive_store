# Flutter reactive_store package
A new Flutter package which helps developers in managing the state of their apps and creating reactive components/widgets with less boiler plate code.

### Show some :heart: and :star: the repo to support the project

### Screenshots
<img src="https://github.com/nyakaz73/Flutter-Footer/raw/master/footer1.jpg" width="400em" height="800em" /> <img src="https://github.com/nyakaz73/Flutter-Footer/raw/master/footer2.jpg" width="400em" height="800em" />

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
The above example introduces us to the final piece of our [reactivestore]() which is the [StoreModel]() Abstract Data Type (ADT). The StoreModel as the name suggests is the store to which we are going to store our data. The [StoreModel]() listens for changes in state in our app and **notifies** the Widgets wrapped by the [UpdateUI]() widget. The [StoreModel]() is essentially an Observable class.

The StoreModel  is a List implmented ADT with the following operations
| Operation                | StoreModel   |  Linked List  |  
| -------------            |:-------------:|:-------------:|
| linked = LinkedList()    | O(1)          | O(1)          |
|                          |               |               |
| linked.add(value)        | NA            | O(1)          |
| linked.append(value)     | O(N)          | O(N)          |  
| linked.remove(value)     | O(1)          | O(N)          |
| linked.isEmpty()         | O(1)          | O(1)          |
| n = len(map)             | O(1)          | O(1)          |
| x in linked              | O(N)          | O(N)          |
| traversal                | O(N)          | O(N)          |

## Imports
 After installing the [footer](https://github.com/nyakaz73/Flutter-Footer/blob/master/pubspec.yanl) package remember the imports
```dart
import 'package:footer/footer.dart';
import 'package:footer/footer_view.dart';
```

## Simple Example
In this Example i will show you how you can simply use the [FooterView](https://github.com/nyakaz73/Flutter-Footer/blob/master/example/footer_example.dart) Widget inside a Scaffold body. 

* Note that when the children list is not overflowing the Footer will be fixed right at the bottom of the Page.
* If there is overflow the whole page will become scrollable and the footer wont be fixed . See gif image below.
```dart
import 'package:footer/footer.dart';
import 'package:footer/footer_view.dart';


@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: new Text('Footer View Example')
      ),
      body: new FooterView(
        children:<Widget>[
          new Padding(
            padding: new EdgeInsets.only(top:200.0),
            child: Center(
              child: new Text('Scrollable View'),
            ),
          ),
        ],
        footer: new Footer(
          child: Text('I am a Customizable footer!!'),
          padding: EdgeInsets.all(10.0),
        ),
        flex: 1, //default flex is 2
      ),
    );
  }
```
<img src="https://github.com/nyakaz73/Flutter-Footer/raw/master/footer0.jpg" width="400em" height="800em" />


## Below is a Full Example

```dart
import 'package:flutter/material.dart';
import 'package:footer/footer.dart';
import 'package:footer/footer_view.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  static Map<int, Color> color = {
    50:Color.fromRGBO(4, 131, 184, .1),
    100:Color.fromRGBO(4, 131, 184, .2),
    200:Color.fromRGBO(4, 131, 184, .3),
    300:Color.fromRGBO(4, 131, 184, .4),
    400:Color.fromRGBO(4, 131, 184, .5),
    500:Color.fromRGBO(4, 131, 184, .6),
    600:Color.fromRGBO(4, 131, 184, .7),
    700:Color.fromRGBO(4, 131, 184, .8),
    800:Color.fromRGBO(4, 131, 184, .9),
    900:Color.fromRGBO(4, 131, 184, 1),
  };
  //MaterialColor myColor = MaterialColor(0xFF162A49, color);
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Footer',
      theme: ThemeData(
        primarySwatch: MaterialColor(0xFF162A49, color),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FooterPage(),
    );
  }
}

class FooterPage extends StatefulWidget {
  @override
  FooterPageState createState() {
    return new FooterPageState();
  }
}

class FooterPageState extends State<FooterPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new  Text('Flutter Footer View',style: TextStyle(fontWeight:FontWeight.w200),)
      ),
      drawer: new Drawer(),
      body: FooterView(
          children: <Widget>[
            new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Padding(
                  padding: EdgeInsets.only(top:50,left: 70),
                    child: new Text('Scrollable View Section'),
                )
              ],
            ),
          ],
          footer: new Footer(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children:<Widget>[
                  new Center(
                    child:new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        new Container(
                          height: 45.0,
                          width: 45.0,
                          child: Center(
                            child:Card(
                              elevation: 5.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0), // half of height and width of Image
                              ),
                              child: IconButton(
                                icon: new Icon(Icons.audiotrack,size: 20.0,),
                                color: Color(0xFF162A49),
                                onPressed: () {},
                              ),
                            ),
                          )
                        ),
                        new Container(
                          height: 45.0,
                          width: 45.0,
                          child: Center(
                            child:Card(
                              elevation: 5.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0), // half of height and width of Image
                              ),
                              child: IconButton(
                                icon: new Icon(Icons.fingerprint,size: 20.0,),
                                color: Color(0xFF162A49),
                                onPressed: () {},
                              ),
                            ),
                          )
                        ),
                        new Container(
                          height: 45.0,
                          width: 45.0,
                          child: Center(
                            child:Card(
                              elevation: 5.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0), // half of height and width of Image
                              ),
                              child: IconButton(
                                icon: new Icon(Icons.call,size: 20.0,),
                                color: Color(0xFF162A49),
                                onPressed: () {},
                              ),
                            ),
                          )
                        ),
                      ],
                    ),
                  ),

                  Text('Copyright ©2020, All Rights Reserved.',style: TextStyle(fontWeight:FontWeight.w300, fontSize: 12.0, color: Color(0xFF162A49)),),
                  Text('Powered by Nexsport',style: TextStyle(fontWeight:FontWeight.w300, fontSize: 12.0,color: Color(0xFF162A49)),),
                ]
              ),
              padding: EdgeInsets.all(5.0),
            
          )
      ),
      floatingActionButton: new FloatingActionButton(
              elevation: 10.0,
              child: new Icon(Icons.chat),
              backgroundColor: Color(0xFF162A49),
              onPressed: (){
              }
      ),
    );
  }
}

```
## Scrollable FooterView
<img src="https://github.com/nyakaz73/Flutter-Footer/raw/master/footer3.gif" width="400em" height="800em" />

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

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:reactivestore/model/store_model.dart';
import 'package:reactivestore/reactivestore.dart';


void main() {
  testWidgets('ReactiveStore Widget with a child', (WidgetTester tester) async {
    // Create the widget by telling the tester to build it.
    await tester.pumpWidget(ReactiveStore(
      child: new Scaffold(
        body: Container(
          child:Text('ReactiveStore with a child Text Widget')
        ),
      )
    ));

    // Create the Finders.
    final titleFinder = find.text('ReactiveStore with a child Text Widget');
    
    // Use the `findsOneWidget` matcher provided by flutter_test to
    // verify that the Text widgets appear exactly once in the widget tree.
    expect(titleFinder, findsOneWidget);
   
  });


  testWidgets('UpdateUI Widget with a callback builder function', (WidgetTester tester) async {
    

    await tester.pumpWidget(ReactiveStore(
      child: new MaterialApp(
        home: new Scaffold(
          body: new Column(
            children: <Widget>[
              new Builder(
                builder: (BuildContext context){
                  //final model = Provider.of<StoreModel>(context,listen: false);//This does not work since it will be currently building
                  final model = StoreModel();
                  model.add({'name':'Daniel','surname':'Moe','age':7});
                  model.add({'name':'Marcus','surname':'Doe','age':72});
                  model.add({'name':'Jessica','surname':'Smith','age':12});
                  return Text(model.itemsList.length.toString());

                }
              ),
              new UpdateUI(
                builder: (context, dialogModel, child) =>
                    dialogModel.itemsList != null
                        ? Text(
                            dialogModel.totalItems.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 25.0,
                                color: Colors.green),
                          )
                        : null),
            ],
          ),
        )
      ),
    ));

    final fullNameFinder = find.text('3');
    //expect(fullNameFinder, findsNothing);
    expect(fullNameFinder, findsOneWidget);

  });
}
  
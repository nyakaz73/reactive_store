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
  
}
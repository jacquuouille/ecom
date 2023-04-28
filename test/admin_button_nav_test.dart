//before starting anything, make sure you add '?' into admin_page.dart (body:StreamBuilder... stream: ref.read()? 
// the reason for that is that when we test AdminHome the database provider will be null so we don't want it to error out. 

// Integration tests basics

import 'package:ecom/app/pages/portal/admin_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets("Navigate to Add product when Add is pressed inside Admin Home", 
  (tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: AdminHome(
          )
        )
      )
    );
 final possibleFAB = find.widgetWithIcon(FloatingActionButton, Icons.add); // to make sure hte button is right here
 expect(possibleFAB, findsOneWidget);
 await tester.tap(possibleFAB); //Tapping the widget
 await tester.pumpAndSettle(); // to be able to call oll of the frames needed to render the next page 
 expect(find.text("Admin Home"), findsNothing); // to make sure we are not in Admin anymore 
 expect(find.text("Upload Image"), findsOneWidget); // to make sure a product is here when we click on the button

  });

}
import 'package:flutter/material.dart';

import '../app/pages/portal/user_bag.dart';

class UserTopBar extends StatelessWidget {
  final IconButton leadingIconButton; // here, we want to make the left icon dynamic. the 2 others will be fixed as we want to make it reusable for the other pages.
  const UserTopBar({
    required this.leadingIconButton, super.key});


  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size; 
    return Container(
      width: screenSize.width,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            leadingIconButton, 
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {

              }
            ),
            IconButton(
              icon: const Icon(Icons.shopping_bag),
              onPressed: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context) => const UserBag()
                  )
                );
              }
            ),
          ],
        ),
      )
    );
  }
}
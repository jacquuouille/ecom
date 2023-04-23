import 'package:flutter/material.dart'; 

class ProductBanner extends StatelessWidget {
  const ProductBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
        width: screenSize.width,
        padding: const EdgeInsets.all(8.0), // padding() is allowing inside Container()
        height: 150,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color.fromARGB(255, 255, 123, 0), Colors.black],
          ),
          borderRadius: BorderRadius.circular(15.0),
          ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row( 
            children: [
             Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start, 
               children: const [
                 Text(
                    "New Release", 
                    style: TextStyle(fontSize: 13, color: Colors.white)
                    ),
                  Text(
                    "Cool shoes", 
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
                  )
                ],
              ),
              const Spacer(),
              Image.network(
                "https://firebasestorage.googleapis.com/v0/b/flutterbricks-public.appspot.com/o/shoe2.png?alt=media&token=8c9f66f4-bbfb-42f2-80ce-1811e7d7fab7", 
                width: 125,
              )
            ],
          ),
        )
      );
    }
  }
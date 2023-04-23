import 'package:flutter/material.dart';
import '../../../models/product.dart';
import '../../../widgets/user_top_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../auth/providers.dart';
import '../portal/user_bag.dart';



class ProductDetail extends ConsumerWidget {
  final Product product;
  const ProductDetail({required this.product, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0), 
          child: ListView( // List view since we want to page to be scrollable 
            children: [
              UserTopBar(
                leadingIconButton: IconButton(
                  icon: const Icon(Icons.keyboard_backspace), 
                  onPressed: () {
                    Navigator.pop(context);
                  }
                ),
              ), 
              const SizedBox(height: 5.0), 
              Hero(
                tag: product.name, 
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25.0), 
                  child: Image.network(
                    product.image, 
                    // width: screenSize.width, 
                    // height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 8.0), 
              const Text(
                "My Store", 
                style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 148, 145, 145),),
              ),
              const SizedBox(height: 4.0), 
              Text(
                product.name, 
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold), 
              ),
              const SizedBox(height: 14.0), 
              const Text(
                "Description", 
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold), 
              ),
              const SizedBox(height: 2.0), 
              Text(
                product.description, 
                style: const TextStyle(fontSize: 13, color: Color.fromARGB(255, 148, 145, 145), )
              ), 
              const SizedBox(height: 14.0), 
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Price", 
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                    Text(
                      "\$" + product.price.toString(),
                       style: const TextStyle( fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue, ),
                  ),
                ],
              ),
              const SizedBox(height: 25.0), 
              GestureDetector(
                onTap: () {
                  ref.read(bagProvider).addProduct(product);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UserBag()
                    ),
                  );
                }, 
                child: Container(
                  padding: const EdgeInsets.all(15.0), 
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0), 
                    color: Colors.orange,
                  ), 
                  child: const Center(
                    child: Text(
                      "Add to Bag", 
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)
                      ))
                )
              )
            ],
          ),
        ),
      ),
    );
    }
}

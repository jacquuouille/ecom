import 'package:ecom/extensions/string_ext.dart';
import 'package:flutter/material.dart';
import '../app/pages/auth/providers.dart';
import '../app/pages/product/product_detail.dart';
import '../models/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'empty.dart';

class ProductsDisplay extends ConsumerWidget {
  const ProductsDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenSize = MediaQuery.of(context).size;
    return StreamBuilder<List<Product>>(
      stream: ref.read(databaseProvider)!.getProducts(), 
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active 
         && snapshot.data != null) {
          if(snapshot.data!.isEmpty) {
            return const EmptyWidget();
          }
        }; 
        return SizedBox(
          height: screenSize.height, 
          child: GridView.builder(
            scrollDirection: Axis.vertical, 
            itemCount: snapshot.data?.length, 
            shrinkWrap: true, 
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2), 
            itemBuilder: (context, index) {
              final product = snapshot.data![index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context, 
                    MaterialPageRoute(
                      builder: (context) => ProductDetail(
                        product: product)
                    )
                  );
                },
              child: Container(
                padding: const EdgeInsets.all (12.0),
                decoration: BoxDecoration( 
                  borderRadius: BorderRadius.circular(15.0),
                ),
                 child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Hero(
                        tag: product.name,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: Image.network(
                              product.image,
                              fit: BoxFit.cover,
                              height: 120,
                            )
                          ),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      // product.name,
                      product.name.capitalize(), 
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold) 
                    ),
                    const SizedBox(height: 4.0), 
                    Text(
                      "\$" + product.price.toString(),
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.blue
                      ),
                    ),
                  ],)
                ),
              );
            },
          ),
        );
      }
    );
  }
} 

import 'package:ecom/app/pages/auth/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ecom/models/product.dart'; 
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../../utils/snackbards.dart';
import '../../../widgets/empty.dart';
import '../product/admin_add_product.dart';


class AdminHome extends ConsumerWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Home"), 
        backgroundColor: Colors.orange,
        actions: [
          IconButton(
            onPressed: () => ref.read(firebaseAuthProvider).signOut(),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: StreamBuilder<List<Product>>(
        stream: ref.read(databaseProvider)?.getProducts(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.active && snapshot.data != null) { 
            if (snapshot.data!.isEmpty) {
              return const EmptyWidget();
              }
            return ListView.builder(
              itemCount: snapshot.data!.length, 
              itemBuilder: (context, index) {
                final product = snapshot.data![index];
                return ProductListTile(
                  product: product, 
                  onDelete: () async {
                    openErrorSnackBar(
                      context, 
                      "Item deleted", 
                      // const Icon(Icons.delete, color: Colors.white,)
                    );
                    await ref 
                      .read(databaseProvider)! 
                      .deleteProduct(product.id!);
                  }
                );
              }
            );
          }
          return const Center(child: CircularProgressIndicator());
        }
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add, color: Colors.white), 
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => const AdminAddProductPage(),
          ),
          ),
        backgroundColor: Colors.orange
      ),
    );
  }
}

class ProductListTile extends StatelessWidget {
  final Product product;
  final Function()? onPressed;
  final Function() onDelete;
  const ProductListTile(
      {required this.product, this.onPressed, required this.onDelete, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Slidable(
      key: const ValueKey(0), 
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (c) => onDelete(), 
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white, 
            icon: Icons.delete, 
            label: "Delete",
          ),
        ],
      ), 
    child: GestureDetector(
      onTap: () {
        if (onPressed != null) onPressed!();
      },
    child: Padding(
      padding: const EdgeInsets.only(left: 14.0, top: 14.0, right: 14.0, bottom: 3),
      child: Container(
        width: screenSize.width,
        height: 75,
        decoration: BoxDecoration(
          color: Colors.white, 
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(
            width: 2,
            color: Colors.orange), 
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.15), 
              offset: const Offset(0, 5), 
              blurRadius: 10,
            ),
          ],
        ),
        child: 
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right:12.0, top: 10.0, bottom: 10.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  product.image, 
                  height: 50,
                  fit: BoxFit.cover, 
                  ),
                ),
              const SizedBox(width: 9),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [ 
                  Text(
                    product.name,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text(
                    product.description,
                    style: const TextStyle(fontSize: 13)),
                ],
              ),
              const Spacer(),
              Text(
                "\$" + product.price.toString(),
                style: const TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 55, 50, 50)),
              ),
              // const SizedBox(height: 1),
            ],
          ),  
        ),
      ),
    ),
    ), );
  }
}
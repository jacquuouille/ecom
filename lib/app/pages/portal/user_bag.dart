import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../widgets/empty.dart';
import '../auth/providers.dart';

class UserBag extends ConsumerWidget {
  const UserBag({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bagViewModel = ref.watch(bagProvider);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0), 
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [ 
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.keyboard_backspace), 
                    onPressed: () {
                      Navigator.pop(context);
                    }, 
                  ),
                const Flexible(
                  child: Text(
                    "My Bag",
                    style: TextStyle(fontSize: 16, color: Colors.black)
                    ),
                  ),
                ],
              ),
              bagViewModel.productsBag.isEmpty 
              ? const Align(
                  alignment: Alignment.bottomLeft,
                  child: EmptyWidget()
              ,) 
              : Flexible(
              child: ListView.builder(
                itemCount: bagViewModel.totalProducts, 
                itemBuilder: (context, index) {
                  final product = bagViewModel.productsBag[index];
                  return ListTile(
                    title: Text(product.name), 
                    subtitle: Text("\$" + product.price.toString()), 
                    trailing: IconButton(
                      icon: const Icon(Icons.delete), 
                      onPressed: () {
                        bagViewModel.removeProduct(product);
                      },
                    ),
                  );
                },
              ),
            ),
            // const SizedBox(height: 100), 
            Align(
              alignment: Alignment.bottomCenter, 
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                children: [
                  Text(
                    "Total: \$" + bagViewModel.totalPrice.toStringAsFixed(2), 
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final payment = ref.read(paymentProvider);
                      final user = ref.read(authStateChangesProvider);
                      final userBag = ref.watch(bagProvider);
                      final result = await payment.initPaymentSheet(user.value!, userBag.totalPrice);

                      
                      if (!result.isError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Payment completed!')),
                          );
                          userBag.clearBag();
                          Navigator.pop(context);
                      } 
                      else
                      {
                       ScaffoldMessenger.of(context).showSnackBar(
                         SnackBar(
                           content: Text(result.message),
                         ),
                       );
                      }
                      
                    }, 
                    child: const Text(
                      'Checkout', 
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)
                      ),
                  ),
                ],
                ),
              ),
            ],
          ),
        )
      )
    );
  }
}

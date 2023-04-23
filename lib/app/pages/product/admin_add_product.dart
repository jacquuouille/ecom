import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ecom/models/product.dart'; 
import '../../../utils/snackbards.dart';
import '../auth/providers.dart';

class AdminAddProductPage extends ConsumerStatefulWidget {
  const AdminAddProductPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AdminAddProductPageState();
}

// TO SAVE THE IMAGE STATE
final addImageProvider = StateProvider<XFile?>((_) => null); 

class _AdminAddProductPageState extends ConsumerState<AdminAddProductPage> {
  final titleTextEditingController = TextEditingController();
  final priceEditingController = TextEditingController();
  final descriptionEditingController = TextEditingController();

  _addProduct() async {
      final storage = ref.read(databaseProvider);
      final fileStorage = ref.read(storageProvider); // reference file storage
      final imageFile = ref.read(addImageProvider.state).state; // referece the image File

      if (storage == null || fileStorage == null || imageFile == null) { // make sure none of them are null
        print("Error: storage, fileStorage or imageFile is null");
        return;
      }
      // Upload to Filestorage
      final imageUrl = await fileStorage.uploadFile( // upload File using our
        imageFile.path,
      );
      await storage.addProduct(Product(
        name: titleTextEditingController.text,
        description: descriptionEditingController.text,
        price: double.parse(priceEditingController.text),
        image: imageUrl,
      ));
      openIconSnackBar( 
        context,
        "Product added successfully", 
        const Icon(Icons.check, color: Colors.white)
      );

      Navigator.pop(context);
   
    }

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Product"),
        backgroundColor: Colors.orange, 
      ), 
      body: Padding(
        padding: const EdgeInsets.all(25.0), 
        child: Column(
          children: [ 
            CustomInputFieldFb1(
              inputController: titleTextEditingController, 
              hintText: 'Product Name'
            ),
            const SizedBox(height: 15.0),
            CustomInputFieldFb1(
              inputController: descriptionEditingController, 
              hintText: 'Product Description'
            ),
            const SizedBox(height: 15.0),
            CustomInputFieldFb1(
              inputController: priceEditingController, 
              hintText: 'Product Price'
            ),
            const SizedBox(height: 30.0),
            Consumer(
              builder: (context, watch, child) {
                final image = ref.watch(addImageProvider); 
                return image == null 
                ? const Text("No image selected") 
                : Image.file(
                    File(image.path), 
                    height: 200
                );
              },
            ),
            ElevatedButton( 
              onPressed: () => _addProduct(), 
              child: const Text(
                "Add Product",
                style: TextStyle(color: Colors.white)
              ), 
              style: ElevatedButton.styleFrom( 
                backgroundColor: Colors.black 
              ), 
            ),
            ElevatedButton(
                child: const Text(
                  'Upload Image', 
                    style: TextStyle(color: Colors.white)
                  ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black
                ),
                onPressed: () async {
                  final image = await ImagePicker().pickImage(
                    source: ImageSource.gallery,
                  );
                  if (image!= null) {
                    ref.watch(addImageProvider.state).state = image;
                  }
                },
              ),
          ],
        ),
      )
    );
  }
}

class CustomInputFieldFb1 extends StatelessWidget {
final TextEditingController inputController;
final String hintText;
final Color primaryColor;

const CustomInputFieldFb1(
    {Key? key,
    required this.inputController,
    required this.hintText,
    this.primaryColor = Colors.orange})
    : super(key: key);

@override
Widget build(BuildContext context) {
  return Container(
    height: 50,
    decoration: BoxDecoration(boxShadow: [
      BoxShadow(
          offset: const Offset(12, 26),
          blurRadius: 50,
          spreadRadius: 0,
          color: Colors.grey.withOpacity(.1)),
    ]),
    child: TextField(
      controller: inputController,
      onChanged: (value) {
        //Do something wi
      },
      keyboardType: TextInputType.emailAddress,
      style: const TextStyle(fontSize: 14, color: Colors.black),
      decoration: InputDecoration(
        filled: true,
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey.withOpacity(.75)),
        fillColor:Colors.transparent,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
        border:  UnderlineInputBorder(
            borderSide: BorderSide(color: primaryColor, width: 2.0),
        ),
        focusedBorder:  UnderlineInputBorder(
            borderSide: BorderSide(color: primaryColor, width: 2.0),
        ),
        errorBorder:  const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 2.0),
        ),
        enabledBorder:  UnderlineInputBorder(
            borderSide: BorderSide(color: primaryColor, width: 2.0),
        ),
      ),
    ),
  );
}
}

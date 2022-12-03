import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:project_4/provided-models/product.dart';

class ProductFormScreen extends StatefulWidget {
  static const routeName = '/product-form';
  final void Function(Map<String, String>) onProductSave;
  final Product? product;
  const ProductFormScreen({
    super.key,
    required this.onProductSave,
    this.product
  });

  @override
  State<ProductFormScreen> createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  final priceFocusNode = FocusNode();
  final descriptionFocusNode = FocusNode();
  final imageUrlFocusNode = FocusNode();
  final imageUrlController = TextEditingController();

  final productFormKey = GlobalKey<FormState>();

  String imageUrl = '';

  final Map<String, String> productFields = {
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': '',
  };

  @override
  void initState() {
    super.initState();
    if (widget.product != null) {
      productFields['title'] = widget.product!.title;
      productFields['description'] = widget.product!.description;
      productFields['price'] = widget.product!.price.toStringAsFixed(2);
      productFields['imageUrl'] = widget.product!.imageUrl;
      imageUrlController.text = widget.product!.imageUrl;

      // Toggle imageUrl field focus to show image
      imageUrlFocusNode.requestFocus();
      Timer.run(() {
        imageUrlFocusNode.unfocus();
      });
    }
    imageUrlFocusNode.addListener(handleImageUrlFocus);
  }

  void handleImageUrlFocus() {
    setState(() {
      if(!imageUrlFocusNode.hasFocus) {
        imageUrl = imageUrlController.text;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    priceFocusNode.dispose();
    descriptionFocusNode.dispose();
    imageUrlFocusNode.removeListener(handleImageUrlFocus);
    imageUrlFocusNode.dispose();
    imageUrlController.dispose();
  }

  void handleSave() {
    if(productFormKey.currentState!.validate()) {
      productFormKey.currentState!.save();
      widget.onProductSave(productFields);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
        actions: [
          IconButton(
            onPressed: handleSave,
            icon: const Icon(Icons.save)
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: productFormKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    label: Text('Title')
                  ),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (value) => priceFocusNode.requestFocus(),
                  initialValue: productFields['title'],
                  validator: (value) {
                    if(value == null || value.isEmpty) {
                      return 'Please Provide a value';
                    }
                    else {
                      return null;
                    }
                  },
                  onSaved: (newValue) => productFields['title'] = newValue ?? '',
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    label: Text('Price')
                  ),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  onFieldSubmitted: (value) => descriptionFocusNode.requestFocus(),
                  initialValue: productFields['price'],
                  validator: (value) {
                    if(value == null || value.isEmpty) {
                      return 'Please Provide a value';
                    }
                    else if(double.tryParse(value) == null) {
                      return 'Enter a valid number';
                    }
                    else if(double.parse(value) <= 0.0) {
                      return 'Enter a valid number';
                    }
                    else {
                      return null;
                    }
                  },
                  onSaved: (newValue) => productFields['price'] = newValue ?? '',
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    label: Text('Description')
                  ),
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  initialValue: productFields['description'],
                  validator: (value) {
                    if(value == null || value.isEmpty) {
                      return 'Please Provide a value';
                    }
                    else {
                      return null;
                    }
                  },
                  onSaved: (newValue) => productFields['description'] = newValue ?? '',
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 8, right: 10,),
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.grey
                        )
                      ),
                      child: Container(
                        child: imageUrl.isEmpty ?
                          const Text('Enter a URL') :
                          FittedBox(
                            child: Image.network(
                              imageUrl,
                              fit: BoxFit.cover,
                            ),
                          )
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          label: Text('Image Url')
                        ),
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.done,
                        controller: imageUrlController,
                        focusNode: imageUrlFocusNode,
                        onFieldSubmitted: (value) => handleSave(),
                        validator: (value) {
                          if(value == null || value.isEmpty) {
                            return 'Please Provide a value';
                          }
                          if(!(value.startsWith('http') || value.startsWith('https'))) {
                            return 'Enter a valid URL';
                          }
                          else {
                            return null;
                          }
                        },
                        onSaved: (newValue) => productFields['imageUrl'] = newValue ?? '',
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ),
      )
    );
  }
}
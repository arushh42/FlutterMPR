import 'package:flutter/material.dart';

class AdminPage extends StatelessWidget {
  final List<Product>? customerProducts; // Making customerProducts optional

  AdminPage({this.customerProducts});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _showAddProductDialog(context);
          },
          child: Text('Add Product'),
        ),
      ),
    );
  }

  void _showAddProductDialog(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController priceController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Product'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: priceController,
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                String name = nameController.text;
                double price = double.tryParse(priceController.text) ?? 0.0;
                String description = descriptionController.text;

                if (name.isNotEmpty && price > 0) {
                  // Add the new product to the customer products list if available
                  if (customerProducts != null) {
                    Product newProduct = Product(
                      name: name,
                      price: price,
                      rating: 0,
                      description: description,
                    );
                    customerProducts!.add(newProduct);
                  }
                  Navigator.pop(context);
                } else {
                  // Show error message if fields are empty or invalid
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Please enter valid product details.'),
                    backgroundColor: Colors.red,
                  ));
                }
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
}

class Product {
  final String name;
  final double price;
  final double rating;
  final String description;

  Product({
    required this.name,
    required this.price,
    required this.rating,
    required this.description,
  });
}

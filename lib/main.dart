import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class Product {
  String name;
  String image;
  double price;
  int quantity;

  Product({required this.name, required this.image, required this.price, this.quantity = 0});
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product List Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProductListScreen(),
    );
  }
}

class ProductListScreen extends StatefulWidget {
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<Product> products = [
    Product(name: 'Product 1', image: 'Assets/images.jpeg', price: 10.0),
    Product(name: 'Product 2', image: 'Assets/images.jpeg', price: 15.0),
    Product(name: 'Product 3', image: 'Assets/images.jpeg', price: 20.0),
    Product(name: 'Product 4', image: 'Assets/images.jpeg', price: 25.0),
    Product(name: 'Product 5', image: 'Assets/images.jpeg', price: 30.0),
    Product(name: 'Product 6', image: 'Assets/images.jpeg', price: 35.0),
  ];

  double calculateTotalPrice() {
    double total = 0;
    for (var product in products) {
      total += product.quantity * product.price;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Image.asset(products[index].image,),
                  title: Text(products[index].name),
                  subtitle:Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove,),
                        onPressed: () {
                          setState(() {
                            if (products[index].quantity > 0) {
                              products[index].quantity--;
                            }
                          });
                        },
                      ),
                      Text(products[index].quantity.toString()),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            products[index].quantity++;
                          });
                        },
                      ),
                    ],
                  ),
                  trailing:  Text('\$${products[index].price.toStringAsFixed(2)}'),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Total: \$${calculateTotalPrice().toStringAsFixed(2)}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      bottomNavigationBar: ElevatedButton(
         style: ElevatedButton.styleFrom(fixedSize: Size(200, 50),backgroundColor: Colors.red),
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Congratulations! Check out successful.'),
            ),
          );
        },
        child: Text("Check"),

      ),
    );
  }
}

import 'package:flutter/material.dart';

void main() {
  runApp(ShoppingApp());
}

class ShoppingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ShoppingScreen(),
    );
  }
}

class ShoppingItem {
  final String name;
  final double unitPrice;
  int quantity;

  ShoppingItem(this.name, this.unitPrice, this.quantity);
}

class ShoppingScreen extends StatefulWidget {
  @override
  _ShoppingScreenState createState() => _ShoppingScreenState();
}

class _ShoppingScreenState extends State<ShoppingScreen> {
  List<ShoppingItem> shoppingItems = [
    ShoppingItem('Item 1', 10.0, 0),
    ShoppingItem('Item 2', 20.0, 0),
    ShoppingItem('Item 3', 15.0, 0),
    ShoppingItem('Item 4', 12.0, 0),
    ShoppingItem('Item 5', 8.0, 0),
    ShoppingItem('Item 6', 25.0, 0),
    ShoppingItem('Item 7', 18.0, 0),
    ShoppingItem('Item 8', 30.0, 0),
    ShoppingItem('Item 9', 22.0, 0),
    ShoppingItem('Item 10', 5.0, 0),
  ];

  void incrementItem(int index) {
    setState(() {
      shoppingItems[index].quantity++;
    });
  }

  void decrementItem(int index) {
    if (shoppingItems[index].quantity > 0) {
      setState(() {
        shoppingItems[index].quantity--;
      });
    }
  }

  double getTotalAmount() {
    double total = 0.0;
    for (var item in shoppingItems) {
      total += item.quantity * item.unitPrice;
    }
    return total;
  }

  void showSnackbar(BuildContext context) {
    final snackBar = SnackBar(
      content: Text('Congratulations! Checkout Successful'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Screen'),
      ),
      body: ListView.builder(
        itemCount: shoppingItems.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(shoppingItems[index].name),
            subtitle: Text('Price: \$${shoppingItems[index].unitPrice.toStringAsFixed(2)}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    decrementItem(index);
                  },
                ),
                Text(shoppingItems[index].quantity.toString()),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    incrementItem(index);
                  },
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Total Amount: \$${getTotalAmount().toStringAsFixed(2)}',
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showSnackbar(context);
        },
        child: Icon(Icons.check),
      ),
    );
  }
}

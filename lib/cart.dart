import 'package:flutter/material.dart';

// Define a class to hold the food item details
class FoodItem {
  final String name;
  final String imageUrl;
  final double price;

  FoodItem({
    required this.name,
    required this.imageUrl,
    required this.price,
  });
}

class CartScreen extends StatefulWidget {
  final List<FoodItem> cartItems;
  final void Function(FoodItem foodItem) onRemoveFromCart;

  CartScreen({
    required this.cartItems,
    required this.onRemoveFromCart,
  });

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late Map<String, int> itemQuantities;

  @override
  void initState() {
    super.initState();
    // Initialize itemQuantities with the quantity of each food item
    itemQuantities = {};

    // Check if cartItems is not empty and initialize itemQuantities
    if (widget.cartItems.isNotEmpty) {
      for (var item in widget.cartItems) {
        itemQuantities[item.name] = (itemQuantities[item.name] ?? 0) + 1;
      }
    } else {
      print("Cart is empty.");
    }
  }

  double get totalPrice {
    double total = 0;
    itemQuantities.forEach((item, quantity) {
      FoodItem foodItem = widget.cartItems.firstWhere((food) => food.name == item);
      total += foodItem.price * quantity;
    });
    return total;
  }

  // Update quantity
  void updateQuantity(String item, int change) {
    setState(() {
      itemQuantities[item] = (itemQuantities[item]! + change).clamp(1, 99); // Ensures min quantity is 1
    });
  }

  // Function to remove an item from the cart with confirmation dialog
  void removeItem(FoodItem foodItem) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Removal'),
          content: Text('Do you really want to remove "${foodItem.name}" from your cart?'),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  // Remove the item from the cart and update the quantities
                  itemQuantities.remove(foodItem.name);
                  widget.cartItems.removeWhere((item) => item.name == foodItem.name);
                });
                widget.onRemoveFromCart(foodItem); // Update the cart in the parent widget
                Navigator.pop(context); // Close the dialog after removal
              },
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog without removing
              },
              child: const Text('No'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white), // Back button
          onPressed: () {
            Navigator.of(context).pop(); // Go back to the previous screen
          },
        ),
        automaticallyImplyLeading: false, // Removes the default leading icon if it's present
        title: Column(
          children: [
            // Logo sized box with both width and height
            SizedBox(
              width: 267, // Set width for the logo box
              height: 65, // Set height for the logo
              child: Image.asset(
                'assets/images/logo.png', // Path for your logo image
                fit: BoxFit.contain, // Ensures logo doesn't get stretched
              ),
            ),
          ],
        ),
        iconTheme: const IconThemeData(color: Colors.white), // Ensure icons are white
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: const Text(
                'Cart', // Centered text in the body
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: itemQuantities.length,
              itemBuilder: (context, index) {
                String itemName = itemQuantities.keys.elementAt(index);
                FoodItem foodItem = widget.cartItems.firstWhere((food) => food.name == itemName);
                int quantity = itemQuantities[itemName]!;

                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  color: Colors.grey[800],
                  child: ListTile(
                    leading: Image.asset(foodItem.imageUrl, width: 50, height: 50),
                    title: Text(
                      foodItem.name,
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      'MYR ${foodItem.price.toStringAsFixed(2)}',
                      style: TextStyle(color: Colors.white),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove, color: Colors.white),
                          onPressed: () {
                            updateQuantity(foodItem.name, -1); // Decrease quantity
                          },
                        ),
                        Text(
                          '$quantity',
                          style: TextStyle(color: Colors.white),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add, color: Colors.white),
                          onPressed: () {
                            updateQuantity(foodItem.name, 1); // Increase quantity
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            removeItem(foodItem); // Remove item with confirmation
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total: ',
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  'MYR ${totalPrice.toStringAsFixed(2)}',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

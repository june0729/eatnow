import 'package:eatnow/Chinese_categories.dart';
import 'package:eatnow/categories.dart';
import 'package:flutter/material.dart';
import 'cart.dart'; // Import CartScreen
import 'login.dart'; // Import LoginScreen
import 'profile_user.dart';

void main() {
  runApp(EatNowApp());
}

class EatNowApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<FoodItem> cartItems = [];
  int _currentIndex = 0;  // Track the current index of BottomNavigationBar

  void addToCart(FoodItem foodItem) {
    setState(() {
      cartItems.add(foodItem);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${foodItem.name} added to cart')),
    );
  }

  void removeFromCart(FoodItem foodItem) {
    setState(() {
      cartItems.remove(foodItem);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${foodItem.name} removed from cart')),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;  // Update the selected index
    });

    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CategoriesScreen()), // Navigate to CategoriesScreen
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProfileUserScreen()), // Navigate to Profile
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(57.0),
        child: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              // Navigate to the LoginScreen when back button is pressed
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
          ),
          title: Center(
            child: Image.asset(
              'assets/images/logo.png',
              height: 65,
              fit: BoxFit.contain,
            ),
          ),
          actions: [
            IconButton(
              icon: Stack(
                children: [
                  const Icon(Icons.shopping_cart, color: Colors.white),
                  if (cartItems.isNotEmpty)
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 18,
                          minHeight: 18,
                        ),
                        child: Text(
                          '${cartItems.length}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CartScreen(
                      cartItems: cartItems,
                      onRemoveFromCart: removeFromCart,
                    ),
                  ),
                ).then((updatedCart) {
                  if (updatedCart != null) {
                    setState(() {
                      cartItems = updatedCart;
                    });
                  }
                });
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                'Home',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 35),
            const Text(
              'Your Meal, Your Schedule! Browse our special menu, order ahead, and pick up with no wait.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'Popular Foods',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: [
                  FoodItemWidget(
                    imageUrl: 'assets/images/banmian.jpg',
                    name: 'Silver Inn',
                    price: 15.99,
                    tags: const ['Thai food', 'Thai food', 'Thai food'],
                    onAddToCart: addToCart,
                  ),
                  FoodItemWidget(
                    imageUrl: 'assets/images/banmian.jpg',
                    name: 'Hillside Retreat',
                    price: 20.00,
                    tags: const ['Thai food', 'American', 'Italian'],
                    onAddToCart: addToCart,
                  ),
                  FoodItemWidget(
                    imageUrl: 'assets/images/banmian.jpg',
                    name: 'Ocean Breeze',
                    price: 22.50,
                    tags: const ['Seafood', 'Chinese', 'Fresh'],
                    onAddToCart: addToCart,
                  ),
                  FoodItemWidget(
                    imageUrl: 'assets/images/banmian.jpg',
                    name: 'Mountain Feast',
                    price: 18.00,
                    tags: const ['American', 'Grill', 'BBQ'],
                    onAddToCart: addToCart,
                  ),
                  FoodItemWidget(
                    imageUrl: 'assets/images/banmian.jpg',
                    name: 'Urban Bites',
                    price: 12.50,
                    tags: const ['Fast Food', 'Burgers', 'Fries'],
                    onAddToCart: addToCart,
                  ),
                  FoodItemWidget(
                    imageUrl: 'assets/images/banmian.jpg',
                    name: 'Vegan Delights',
                    price: 10.00,
                    tags: const ['Vegan', 'Healthy', 'Salads'],
                    onAddToCart: addToCart,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,  // Use the currentIndex property
        backgroundColor: Colors.black,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Account',
          ),
        ],
        onTap: _onItemTapped,  // Use the _onItemTapped method to change selected tab
      ),
    );
  }
}

class FoodItemWidget extends StatelessWidget {
  final String imageUrl;
  final String name;
  final double price;
  final List<String> tags;
  final Function(FoodItem) onAddToCart;

  FoodItemWidget({
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.tags,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                imageUrl,
                width: 160,
                height: 140,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add, color: Colors.orange),
                        onPressed: () {
                          FoodItem foodItem = FoodItem(
                            name: name,
                            imageUrl: imageUrl,
                            price: price,
                          );
                          onAddToCart(foodItem);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    tags.join(' • '),
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

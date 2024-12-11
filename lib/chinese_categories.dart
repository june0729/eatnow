import 'package:flutter/material.dart';

class ChineseCategoriesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Image.asset(
          'assets/images/logo.png', // Replace with your logo image path
          height: 50, // Adjust height as needed
        ),
      ),
      body: Container(
        color: Colors.black,
        child: Column(
          children: [
            // Title "Categories"
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Align(
                alignment: Alignment.topCenter, // Modify this for positioning
                child: Text(
                  'Categories',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                  ),
                ),
              ),
            ),
            // Categories Tabs
            Container(
              color: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildCategoryTab('Chinese', true),
                  _buildCategoryTab('Malay', false),
                  _buildCategoryTab('India', false),
                  _buildCategoryTab('Drink & Dessert', false),
                ],
              ),
            ),
            // Food Items List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: 5, // Updated count for five items
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return _buildFoodItem(
                      'assets/images/banmian.jpg', // Replace with your local image path
                      'Meatloaf with Mashed Potatoes',
                      'MYR 20.00',
                    );
                  } else if (index == 1) {
                    return _buildFoodItem(
                      'assets/images/banmian.jpg', // Replace with another local image path
                      'Steamed Dumplings',
                      'MYR 15.00',
                    );
                  } else if (index == 2) {
                    return _buildFoodItem(
                      'assets/images/banmian.jpg', // Replace with another local image path
                      'Sweet and Sour Chicken',
                      'MYR 18.00',
                    );
                  } else if (index == 3) {
                    return _buildFoodItem(
                      'assets/images/banmian.jpg', // Replace with another local image path
                      'Fried Rice',
                      'MYR 12.00',
                    );
                  } else {
                    return _buildFoodItem(
                      'assets/images/banmian.jpg', // Replace with another local image path
                      'Spring Rolls',
                      'MYR 10.00',
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.grey,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.category), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: 'Account'),
        ],
        currentIndex: 1, // Highlight Categories tab
        onTap: (index) {},
      ),
    );
  }

  Widget _buildCategoryTab(String label, bool isSelected) {
    return Text(
      label,
      style: TextStyle(
        color: isSelected ? Colors.yellow : Colors.white,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }

  Widget _buildFoodItem(String imagePath, String title, String price) {
    return Card(
      color: Colors.black,
      margin: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Food Image
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              imagePath, // Use dynamic image path
              height: 120,
              width: 150,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16.0),
          // Food Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title, // Use dynamic title
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 21.0, color: Colors.white),
                ),
                const SizedBox(height: 15.0),
                Text(
                  price, // Use dynamic price
                  style: const TextStyle(color: Colors.red, fontSize: 14.0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ChineseCategoriesPage(),
    theme: ThemeData.dark(),
  ));
}

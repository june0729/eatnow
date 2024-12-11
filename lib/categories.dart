import 'package:eatnow/chinese_categories.dart';
import 'package:flutter/material.dart';
import 'package:eatnow/home.dart';  // Import HomeScreen
import 'profile_user.dart';      // Import AccountScreen

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  int _currentIndex = 1; // Set the initial selected tab to Categories

  // Method to handle tab selection
  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index; // Update the selected index
    });

    // Navigate to the appropriate screen based on the selected tab
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()), // Navigate to HomeScreen
      );
    } else if (index == 1) {
      // Stay on CategoriesScreen (no navigation needed)
    } else if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ProfileUserScreen()), // Navigate to AccountScreen
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop(); // This pops the current screen
          },
        ),
        flexibleSpace: Center(
          child: Image.asset(
            'assets/images/logo.png', // Replace with your logo image path
            height: 64, // Adjust the height of the logo
          ),
        ),
      ),
      backgroundColor: Colors.black, // Keep the main background black
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Wrap the Text widget with a Center widget to align it to the center
            Center(
              child: Container(
                width: double.infinity, // This ensures the text occupies the full width
                padding: EdgeInsets.symmetric(vertical: 1), // Add padding to control spacing
                child: Text(
                  'Categories', // "Categories" text moved to the body
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,  // Adjust the font size as needed
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center, // Center align the text
                ),
              ),
            ),
            SizedBox(height: 30),
            // ListView to display the categories
            Expanded(
              child: Container(
                color: Colors.black, // Default background is black
                child: ListView.builder(
                  itemCount: 4, // Total number of items to display
                  itemBuilder: (context, index) {
                    return _buildCategoryCard(
                      category: _categoryNames[index],
                      description: _categoryDescriptions[index],
                      imageUrl: _categoryImages[index],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.white,
        currentIndex: _currentIndex, // Set the current index to update the selected tab
        onTap: _onItemTapped, // Use the _onItemTapped method to change selected tab
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
      ),
    );
  }

  // Category names, descriptions, and image URLs
  final List<String> _categoryNames = [
    'Chinese',
    'Malay',
    'India',
    'Drink and Dessert'
  ];

  final List<String> _categoryDescriptions = [
    'Shortbread, chocolate turtle malay, and red velvet.',
    'Shortbread, chocolate turtle malay, and red velvet.',
    'Shortbread, chocolate turtle malay, and red velvet.',
    'Shortbread, chocolate turtle malay, and red velvet.'
  ];

  final List<String> _categoryImages = [
    'assets/images/banmian.jpg',
    'assets/images/banmian.jpg',
    'assets/images/banmian.jpg',
    'assets/images/banmian.jpg'
  ];

  Widget _buildCategoryCard({
    required String category,
    required String description,
    required String imageUrl,
  }) {
    return GestureDetector(
      onTap: () {
        if (category == 'Chinese') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ChineseCategoriesPage()), // Navigate to Chinese Categories Screen
          );
        }
      },
      child: Card(
        color: Colors.white, // Set the card color to white
        margin: EdgeInsets.symmetric(vertical: 10), // Margin to give space between items
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              // Image on the left
              Container(
                width: 150, // Fixed width for the image
                height: 160, // Fixed height for the image
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(imageUrl),
                    fit: BoxFit.cover, // Ensure the image covers the space without distortion
                  ),
                ),
              ),
              SizedBox(width: 15), // Add space between image and text
              // Text beside the image
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      category,
                      style: TextStyle(
                        color: Colors.black, // Change the text color for visibility on a white background
                        fontWeight: FontWeight.bold,
                        fontSize: 20, // Increased font size for category name
                      ),
                    ),
                    SizedBox(height: 5), // Space between category name and description
                    Text(
                      description,
                      style: TextStyle(
                        color: Colors.black87, // Slightly lighter text for the description
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  home: CategoriesScreen(),
));

import 'package:flutter/material.dart';
import 'models/products_model.dart';

dynamic person;

final GlobalKey<FormState> signInKey = GlobalKey<FormState>();
TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
String? email;
String? password;
bool viewPassword = true;

//for loginScreen
final GlobalKey<FormState> logInKey = GlobalKey<FormState>();
TextEditingController emailControllerLog = TextEditingController();
TextEditingController passwordControllerLog = TextEditingController();
String? logEmail;
String? logPassword;
bool logViewPassword = true;

class GroceryCategory {
  final int id;
  final String name;

  GroceryCategory(this.id, this.name);
}

List<GroceryCategory> viewCategory = [
  GroceryCategory(1, 'Fruits'),
  GroceryCategory(2, 'Vegetables'),
  GroceryCategory(3, 'Dairy'),
  GroceryCategory(4, 'Bakery'),
  GroceryCategory(5, 'Meat'),
  GroceryCategory(6, 'Pantry Staples'),
  GroceryCategory(7, 'Beverages'),
  GroceryCategory(8, 'Snacks'),
  // Add more categories as needed
];

List<GroceryCategory> category = [
  GroceryCategory(1, 'Fruits'),
  GroceryCategory(2, 'Vegetables'),
  GroceryCategory(3, 'Dairy'),
  GroceryCategory(4, 'Bakery'),
  GroceryCategory(5, 'Meat'),
  GroceryCategory(6, 'Pantry Staples'),
  GroceryCategory(7, 'Beverages'),
  GroceryCategory(8, 'Snacks'),
  // Add more categories as needed
];

List<Products> products = [
  Products(
    id: 1,
    name: 'Apple',
    category: 'Fruits',
    description: 'Fresh and juicy apples',
    image: 'apple.jpg',
    quantity: 10,
    price: 14,
  ),
  Products(
    id: 2,
    name: 'Banana',
    category: 'Fruits',
    description: 'Yellow and ripe bananas',
    image: 'banana.jpg',
    quantity: 15,
    price: 55,
  ),
  Products(
    id: 3,
    name: 'Carrot',
    category: 'Vegetables',
    description: 'Orange carrots packed with nutrients',
    image: 'carrot.jpg',
    quantity: 20,
    price: 25,
  ),
  Products(
    id: 4,
    name: 'Milk',
    category: 'Dairy',
    description: 'Fresh and nutritious milk',
    image: 'milk.jpg',
    quantity: 25,
    price: 28,
  ),
  Products(
    id: 5,
    name: 'Bread',
    category: 'Bakery',
    description: 'Soft and delicious bread',
    image: 'bread.jpg',
    quantity: 30,
    price: 15,
  ),
  Products(
    id: 6,
    name: 'Chicken',
    category: 'Meat',
    description: 'Lean and tender chicken meat',
    image: 'chicken.jpg',
    quantity: 12,
    price: 5,
  ),
  Products(
    id: 7,
    name: 'Rice',
    category: 'Pantry Staples',
    description: 'High-quality rice for meals',
    image: 'rice.jpg',
    quantity: 40,
    price: 35,
  ),
  Products(
    id: 8,
    name: 'Chips',
    category: 'Snacks',
    description: 'Crunchy potato chips',
    image: 'chips.jpg',
    quantity: 20,
    price: 20,
  ),
  Products(
    id: 9,
    name: 'Orange',
    category: 'Fruits',
    description: 'Juicy and sweet oranges',
    image: 'orange.jpg',
    quantity: 18,
    price: 12,
  ),
  Products(
    id: 10,
    name: 'Lettuce',
    category: 'Vegetables',
    description: 'Fresh and crispy lettuce',
    image: 'lettuce.jpg',
    quantity: 22,
    price: 18,
  ),
  Products(
    id: 11,
    name: 'Yogurt',
    category: 'Dairy',
    description: 'Creamy and delightful yogurt',
    image: 'yogurt.jpg',
    quantity: 28,
    price: 20,
  ),
  Products(
    id: 12,
    name: 'Baguette',
    category: 'Bakery',
    description: 'Classic French baguette',
    image: 'baguette.jpg',
    quantity: 35,
    price: 17,
  ),
  Products(
    id: 13,
    name: 'Salmon',
    category: 'Meat',
    description: 'Fresh salmon fillet',
    image: 'salmon.jpg',
    quantity: 10,
    price: 70,
  ),
  Products(
    id: 14,
    name: 'Pasta',
    category: 'Pantry Staples',
    description: 'Versatile pasta for cooking',
    image: 'pasta.jpg',
    quantity: 50,
    price: 15,
  ),
  Products(
    id: 15,
    name: 'Red Apple',
    category: 'Fruits',
    description: 'Sweet and crunchy red apples',
    image: 'red_apple.jpg',
    quantity: 50,
    price: 75,
  ),
  Products(
    id: 16,
    name: 'Banana',
    category: 'Fruits',
    description: 'Ripe and delicious bananas',
    image: 'banana.jpg',
    quantity: 30,
    price: 4,
  ),
  Products(
    id: 17,
    name: 'Broccoli',
    category: 'Vegetables',
    description: 'Nutritious and green broccoli',
    image: 'broccoli.jpg',
    quantity: 25,
    price: 12,
  ),
  Products(
    id: 18,
    name: 'Milk',
    category: 'Dairy',
    description: 'Fresh and creamy milk',
    image: 'milk.jpg',
    quantity: 20,
    price: 25,
  ),
  Products(
    id: 19,
    name: 'Baguette',
    category: 'Bakery',
    description: 'Crusty French baguette',
    image: 'baguette.jpg',
    quantity: 40,
    price: 15,
  ),
  Products(
    id: 20,
    name: 'Chicken Breast',
    category: 'Meat',
    description: 'Lean and tender chicken breast',
    image: 'chicken_breast.jpg',
    quantity: 15,
    price: 55,
  ),
  Products(
    id: 21,
    name: 'Rice',
    category: 'Pantry Staples',
    description: 'High-quality rice grains',
    image: 'rice.jpg',
    quantity: 60,
    price: 2,
  ),
  Products(
    id: 22,
    name: 'Chocolate Bar',
    category: 'Snacks',
    description: 'Rich and indulgent chocolate bar',
    image: 'chocolate_bar.jpg',
    quantity: 40,
    price: 175,
  ),
  Products(
    id: 23,
    name: 'Orange',
    category: 'Fruits',
    description: 'Tangy and juicy oranges',
    image: 'orange.jpg',
    quantity: 35,
    price: 60,
  ),
  Products(
    id: 24,
    name: 'Spinach',
    category: 'Vegetables',
    description: 'Fresh and nutritious spinach leaves',
    image: 'spinach.jpg',
    quantity: 18,
    price: 10,
  ),
  Products(
    id: 25,
    name: 'Greek Yogurt',
    category: 'Dairy',
    description: 'Creamy and thick Greek yogurt',
    image: 'greek_yogurt.jpg',
    quantity: 25,
    price: 30,
  ),
  Products(
    id: 26,
    name: 'Whole Wheat Bread',
    category: 'Bakery',
    description: 'Healthy whole wheat bread slices',
    image: 'whole_wheat_bread.jpg',
    quantity: 30,
    price: 30,
  ),
  Products(
    id: 27,
    name: 'Salmon Fillet',
    category: 'Meat',
    description: 'Fresh and pink salmon fillet',
    image: 'salmon_fillet.jpg',
    quantity: 12,
    price: 85,
  ),
  Products(
    id: 28,
    name: 'Pasta',
    category: 'Pantry Staples',
    description: 'Versatile pasta for various dishes',
    image: 'pasta.jpg',
    quantity: 50,
    price: 125,
  ),
];

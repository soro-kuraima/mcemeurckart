import 'package:flutter/material.dart';
import '../models/products_model.dart';

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

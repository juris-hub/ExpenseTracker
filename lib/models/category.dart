import 'package:flutter/material.dart';

enum Category { food, travel, leisure, work, test, test123 }

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
  Category.test: Icons.abc,
  Category.test123: Icons.abc_outlined
};

class Categories {
  const Categories(
      {required this.id,
      required this.title,
      required this.color,
      required this.icon});

  final String id;
  final String title;
  final Color color;
  final IconData icon;
}

//for testing purposes

const availableCategories = [
  Categories(
    id: 'c1',
    title: 'Food',
    color: Colors.purple,
    icon: Icons.food_bank,
  ),
  Categories(
    id: 'c2',
    title: 'Work',
    color: Colors.red,
    icon: Icons.work,
  ),
  Categories(
    id: 'c3',
    title: 'Shopping',
    color: Colors.grey,
    icon: Icons.shopping_bag,
  ),
  Categories(
    id: 'c4',
    title: 'Home',
    color: Colors.amber,
    icon: Icons.home,
  ),
  Categories(
    id: 'c5',
    title: 'Credits',
    color: Colors.blue,
    icon: Icons.currency_pound,
  ),
  Categories(
    id: 'c6',
    title: 'Health',
    color: Colors.brown,
    icon: Icons.healing,
  ),
  Categories(
    id: 'c7',
    title: 'Other',
    color: Colors.deepPurple,
    icon: Icons.question_mark,
  ),
];

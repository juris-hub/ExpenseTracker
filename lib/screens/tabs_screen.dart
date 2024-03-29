import 'package:expense_tracker/screens/expenses.dart';
import 'package:flutter/material.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedScreenIndex = 0;

  void _selectScreen(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = const ExpensesScreen();
    var activePageTitle = 'Expenses';

    if (_selectedScreenIndex == 1) {
      // activePage = const AddExpenseScreen();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectScreen,
        currentIndex: _selectedScreenIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.wallet),
            label: 'Expenses',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.add), label: 'Under development'),
        ],
      ),
    );
  }
}

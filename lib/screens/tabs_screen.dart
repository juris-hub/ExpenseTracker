import 'package:expense_tracker/screens/expenses.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final _formKey = GlobalKey<FormState>();
  int _selectedScreenIndex = 0;

  void _selectScreen(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  void _addExpense() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => NewExpense(
          formKey: _formKey,
        ),
      ),
    );
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
        actions: [
          IconButton(
            onPressed: _addExpense,
            icon: const Icon(Icons.add),
          ),
        ],
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

import 'package:expense_tracker/providers/expense.provider.dart';
import 'package:expense_tracker/screens/expenses.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedScreenIndex = 0;

  void _selectScreen(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  void _addExpense() async {
    final newExpense = await Navigator.of(context).push<int>(
      MaterialPageRoute(
        builder: (ctx) => const NewExpense(),
      ),
    );

    if (newExpense == 200) {
      ref.read(expensesProvider.notifier).fetchExpenses();
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
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
      body: const ExpensesScreen(),
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

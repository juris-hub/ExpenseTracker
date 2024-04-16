import 'package:expense_tracker/widgets/expenses_list.dart';
import 'package:flutter/material.dart';

class ExpensesScreen extends StatelessWidget {
  const ExpensesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ExpensesList(),
    );
  }
}

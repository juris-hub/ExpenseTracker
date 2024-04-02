import 'package:expense_tracker/providers/expense.provider.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:expense_tracker/widgets/expenses_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExpensesScreen extends ConsumerStatefulWidget {
  const ExpensesScreen({super.key});

  @override
  ConsumerState<ExpensesScreen> createState() => _ExpensesState();
}

class _ExpensesState extends ConsumerState<ExpensesScreen> {
  @override
  Widget build(BuildContext context) {
    final registeredExpenses = ref.watch(expenseProvider);

    Widget mainContent = const Center(
      child: Text('No expenses found. Start adding some!'),
    );

    if (registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: registeredExpenses,
      );
    }

    return Scaffold(
      body: mainContent,
    );
  }
}

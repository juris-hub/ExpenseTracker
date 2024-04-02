import 'package:expense_tracker/models/expense.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExpenseNotifier extends StateNotifier<List<Expense>> {
  ExpenseNotifier()
      : super([
          Expense(
              amount: 19.99,
              category: 'Work',
              date: DateTime.now(),
              title: 'Flutter Course'),
          Expense(
              amount: 12.45,
              category: 'Leisure',
              date: DateTime.now(),
              title: 'A1 bill'),
        ]);

  void newExpense(Expense expense) {
    state = [...state, expense];
  }

  void removeExpense(Expense expense) {
    final expenseExists = state.contains(expense);

    if (expenseExists) {
      state = state.where((element) => element.id != expense.id).toList();
    }
  }
}

final expenseProvider = StateNotifierProvider<ExpenseNotifier, List<Expense>>(
    (ref) => ExpenseNotifier());

import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/services/expenses_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final expensesProvider = StateNotifierProvider<ExpensesNotifier, List<Expense>>(
    (ref) => ExpensesNotifier());

class ExpensesNotifier extends StateNotifier<List<Expense>> {
  ExpensesNotifier() : super([]) {
    fetchExpenses();
  }

  final ExpensesService _expensesService = ExpensesService();

  Future<void> fetchExpenses() async {
    final expenses = await _expensesService.fetchExpenses();
    state = expenses;
  }

  Future<void> deleteExpense(String id) async {
    await _expensesService.deleteExpense(id);
    final expenses = await _expensesService.fetchExpenses();
    state = expenses;
  }

  Future<int> addExpense(Expense expense) async {
    final response = await _expensesService.addExpense(expense);
    return response;
  }

  Future<int> editExpense(Expense expense, String id) async {
    final response = await _expensesService.editExpense(expense, id);
    final expenses = await _expensesService.fetchExpenses();
    state = expenses;

    return response;
  }
}

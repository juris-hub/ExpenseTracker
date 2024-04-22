import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/services/expenses_service.dart';
import 'package:expense_tracker/services/models/expense_request.dart';
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

  Future<int> addExpense(ExpenseRequest request) async {
    final response = await _expensesService.addExpense(request);
    return response;
  }

  Future<int> editExpense(ExpenseRequest request) async {
    final response = await _expensesService.editExpense(request);
    final expenses = await _expensesService.fetchExpenses();
    state = expenses;

    return response;
  }
}

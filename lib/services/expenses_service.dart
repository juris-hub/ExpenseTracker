import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/services/models/expense_request.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ExpensesService {
  Future<List<Expense>> fetchExpenses() async {
    final url = Uri.parse('https://10.0.2.2:7164/api/Expenses');
    final response = await http.get(url);
    final List<dynamic> listData = json.decode(response.body);
    final List<Expense> loadedExpenses = [];
    for (final item in listData) {
      loadedExpenses.add(
        Expense(
            title: item['title'],
            amount: item['amount'],
            date: DateTime.parse(item['date']),
            category: item['category'],
            id: item['id']),
      );
    }
    return loadedExpenses;
  }

  Future<void> deleteExpense(String id) async {
    final url = Uri.parse('https://10.0.2.2:7164/api/Expenses/${id}');
    await http.delete(url);
  }

  Future<int> addExpense(ExpenseRequest request) async {
    final url = Uri.parse('https://10.0.2.2:7164/api/Expenses');
    final response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
        body: json.encode(request.toJson()));

    return response.statusCode;
  }

  Future<int> editExpense(ExpenseRequest request) async {
    print(request.expense.id);
    final url =
        Uri.parse('https://10.0.2.2:7164/api/Expenses/${request.expense.id}');
    final response = await http.put(url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
        body: json.encode(ExpenseRequest(request.expense)));

    return response.statusCode;
  }
}

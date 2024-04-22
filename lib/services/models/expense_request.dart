import 'package:expense_tracker/models/expense.dart';

class ExpenseRequest {
  final Expense expense;

  ExpenseRequest(this.expense);

  Map<String, dynamic> toJson() {
    return {
      'expense': expense.toJson(),
    };
  }
}

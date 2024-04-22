import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

final formatter = DateFormat.yMd();

const uuid = Uuid();

class Expense {
  Expense(
      {required this.title,
      required this.amount,
      required this.date,
      required this.category,
      this.id});

  final String title;
  final num amount;
  final String? id;
  final DateTime date;
  final String category;

  String get formattedDate {
    return formatter.format(date);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'date': date.toIso8601String(),
      'category': category,
    };
  }
}

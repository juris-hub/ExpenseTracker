import 'package:expense_tracker/providers/expense.provider.dart';
import 'package:expense_tracker/widgets/expense_item.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExpensesList extends ConsumerStatefulWidget {
  const ExpensesList({super.key});

  @override
  ConsumerState<ExpensesList> createState() => _ExpensesListState();
}

class _ExpensesListState extends ConsumerState<ExpensesList> {
  @override
  Widget build(BuildContext context) {
    final expenses = ref.watch(expensesProvider);

    Widget mainContent = RefreshIndicator(
      onRefresh: () async {
        ref.watch(expensesProvider.notifier).fetchExpenses();
      },
      child: ListView(children: const [
        SizedBox(
          height: 50,
        ),
        Center(
          child: Text('No expenses! Start adding some!'),
        ),
      ]),
    );

    if (expenses.isEmpty) {
      return mainContent;
    }

    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) => Dismissible(
        onDismissed: (direction) {
          ref
              .watch(expensesProvider.notifier)
              .deleteExpense(expenses[index].id!);
        },
        key: UniqueKey(),
        child: GestureDetector(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (ctx) => NewExpense(
                    expense: expenses[index],
                  ))),
          child: ExpenseItem(
            expense: expenses[index],
          ),
        ),
      ),
    );
  }
}

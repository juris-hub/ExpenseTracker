import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/providers/expense.provider.dart';
import 'package:expense_tracker/widgets/category_grid_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/category.dart';

class NewExpense extends ConsumerStatefulWidget {
  const NewExpense({super.key});

  @override
  ConsumerState<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends ConsumerState<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  String _selectedCategory = '';

  List<bool> _isCategoryTapped = List.filled(availableCategories.length, false);

  void _selectCategory(String category, int index) {
    setState(() {
      _selectedCategory = category;

      _isCategoryTapped = List.filled(availableCategories.length, false);
      _isCategoryTapped[index] = !_isCategoryTapped[index];
    });
  }

  // add category to expense object method

  void _presentDatePicker() async {
    DateTime now = DateTime.now();
    DateTime startDate = DateTime(now.year - 1, now.month, now.day);
    final selectedDate = await showDatePicker(
        context: context, firstDate: startDate, lastDate: now);

    setState(() {
      _selectedDate = selectedDate;
    });
  }

  void _submitExpense() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;

    if (_titleController.text.trim().isEmpty || amountIsInvalid) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text(
            ('Invalid input'),
          ),
          content: const Text(
              'Please make sure a valid title, amount, date and category was entered.'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text('Okay'))
          ],
        ),
      );
      return;
    }

    ref.watch(expenseProvider.notifier).newExpense(Expense(
        title: _titleController.text,
        amount: enteredAmount,
        date: _selectedDate!,
        category: _selectedCategory));

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Expense'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              maxLength: 50,
              decoration: const InputDecoration(
                label: Text('Title'),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      prefixText: '€ ',
                      label: Text('Amount'),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                    child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(_selectedDate == null
                        ? 'No date selected'
                        : formatter.format(_selectedDate!)),
                    IconButton(
                      onPressed: _presentDatePicker,
                      icon: const Icon(
                        Icons.calendar_month,
                      ),
                    ),
                  ],
                ))
              ],
            ),
            const SizedBox(
              height: 36,
            ),
            Text(
              'Categories',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 16,
            ),
            Expanded(
              child: GridView.builder(
                  itemCount: availableCategories.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 0.7,
                    crossAxisSpacing: 40,
                    mainAxisSpacing: 15,
                  ),
                  itemBuilder: (ctx, index) {
                    final category = availableCategories[index];
                    return CategoryGridItem(
                      category: category,
                      isTapped: _isCategoryTapped[index],
                      onSelectedCategory: () {
                        _selectCategory(category.title, index);
                      },
                    );
                  }),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).colorScheme.onBackground,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(25)),
              child: ElevatedButton(
                onPressed: _submitExpense,
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.surface),
                child: Text(
                  'Add expense',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/providers/expense.provider.dart';
import 'package:expense_tracker/services/models/expense_request.dart';
import 'package:expense_tracker/widgets/category_grid_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/category.dart';

class NewExpense extends ConsumerStatefulWidget {
  const NewExpense({super.key, this.expense});

  final Expense? expense;

  @override
  ConsumerState<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends ConsumerState<NewExpense> {
  var _enteredTitle = '';
  var _eneteredAmount = '';
  late DateTime? _selectedDate = widget.expense?.date ?? DateTime.now();
  late String _selectedCategory = widget.expense?.category ?? '';
  var _isSending = false;
  final _formKey = GlobalKey<FormState>();

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

  void _addExpense() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _isSending = true;
      });

      int response;

      if (widget.expense != null && widget.expense!.id!.isNotEmpty) {
        var expenseId = widget.expense!.id;
        response = await ref.watch(expensesProvider.notifier).editExpense(
              ExpenseRequest(
                Expense(
                    id: expenseId,
                    title: _enteredTitle,
                    amount: double.parse(_eneteredAmount),
                    date: _selectedDate!,
                    category: _selectedCategory),
              ),
            );
      } else {
        response = await ref.watch(expensesProvider.notifier).addExpense(
              ExpenseRequest(
                Expense(
                    title: _enteredTitle,
                    amount: double.parse(_eneteredAmount),
                    date: _selectedDate!,
                    category: _selectedCategory),
              ),
            );
      }

      Navigator.of(context).pop(response);
    }
  }

  @override
  Widget build(BuildContext context) {
    String buttonText;

    widget.expense != null
        ? buttonText = 'Edit expense'
        : buttonText = 'Add expense';

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.expense?.title ?? "New expense"),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: widget.expense?.title ?? '',
                maxLength: 50,
                decoration: const InputDecoration(
                  label: Text('Title'),
                ),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      value.trim().length <= 1) {
                    return 'Must be between 1 and 50 characters.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _enteredTitle = value!;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      initialValue: widget.expense?.amount.toString() ?? '',
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        prefixText: '€ ',
                        label: Text('Amount'),
                      ),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            double.tryParse(value) == null ||
                            double.tryParse(value)! <= 0) {
                          return 'Must be a valid, positive number !';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _eneteredAmount = value!;
                      },
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
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      childAspectRatio: 0.7,
                      crossAxisSpacing: 40,
                      mainAxisSpacing: 15,
                    ),
                    itemBuilder: (ctx, index) {
                      final category = availableCategories[index];
                      if (widget.expense != null &&
                          widget.expense!.category == category.title) {
                        _isCategoryTapped[index] = true;
                      }
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
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).colorScheme.onBackground,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(25)),
                child: ElevatedButton(
                  onPressed: _isSending ? null : _addExpense,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.surface),
                  child: _isSending
                      ? const SizedBox(
                          height: 16,
                          width: 16,
                          child: CircularProgressIndicator(),
                        )
                      : Text(
                          buttonText,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontWeight: FontWeight.bold),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

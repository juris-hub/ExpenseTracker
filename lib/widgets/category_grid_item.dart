import 'package:expense_tracker/models/category.dart';
import 'package:flutter/material.dart';

class CategoryGridItem extends StatelessWidget {
  const CategoryGridItem({
    super.key,
    required this.category,
    required this.onSelectedCategory,
    required this.isTapped,
  });

  final Categories category;
  final void Function() onSelectedCategory;
  final bool isTapped;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onSelectedCategory,
          splashColor: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(100),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: isTapped
                    ? Border.all(
                        color: Theme.of(context).colorScheme.onBackground,
                        width: 2,
                      )
                    : null,
                gradient: LinearGradient(
                  colors: [Colors.white, category.color.withOpacity(0.1)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Center(
                child: Icon(
                  category.icon,
                  size: 36,
                  color: category.color,
                ),
              ),
            ),
          ),
        ),
        Text(
          category.title,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
              fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}

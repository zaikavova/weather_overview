import 'package:flutter/material.dart';

class FloatingButton extends StatelessWidget {
  const FloatingButton({
    super.key,
    required this.floatingButtonSize,
    required this.onTap,
    this.isLoading = false,
  });

  final double floatingButtonSize;
  final bool isLoading;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: floatingButtonSize,
        width: floatingButtonSize,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: theme.shadowColor.withOpacity(0.5),
              offset: Offset(0, 1),
              blurRadius: 10,
              spreadRadius: 0,
            ),
          ],
          color: theme.primaryColor,
          borderRadius: BorderRadius.all(
            Radius.circular(floatingButtonSize),
          ),
        ),
        child: Center(
          child: isLoading
              ? CircularProgressIndicator(
                  color: theme.colorScheme.onSecondary,
                )
              : Icon(
                  Icons.add,
                  color: theme.colorScheme.onSecondary,
                ),
        ),
      ),
    );
  }
}

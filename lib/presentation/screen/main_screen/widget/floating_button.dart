import 'package:flutter/material.dart';

class FloatingButton extends StatelessWidget {
  const FloatingButton({
    super.key,
    required this.floatingButtonSize,
    required this.theme,
    required this.onTap,
  });

  final double floatingButtonSize;
  final ThemeData theme;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.all(
        Radius.circular(floatingButtonSize),
      ),
      onTap: onTap,
      child: Ink(
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
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

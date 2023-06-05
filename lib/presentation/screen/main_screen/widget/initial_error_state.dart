import 'package:flutter/material.dart';

class InitialErrorStateWidget extends StatelessWidget {
  const InitialErrorStateWidget({
    super.key,
    required this.errorMessage,
    required this.onRetryPressed,
  });

  final String errorMessage;
  final VoidCallback onRetryPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(errorMessage),
        InkWell(
          onTap: onRetryPressed,
          child: Ink(
            child: Icon(Icons.replay),
          ),
        ),
      ],
    );
  }
}

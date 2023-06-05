import 'package:flutter/material.dart';
import 'package:weather_overview/generated/l10n.dart';

class EmptyLocationsWidget extends StatelessWidget {
  const EmptyLocationsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: Text(S.of(context).title),
        ),
        SliverFillRemaining(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                S.of(context).addFirstLocationMessage,
              ),
            ],
          ),
          hasScrollBody: false,
          fillOverscroll: false,
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class DataFilteringWidgetBuilder<T> extends StatefulWidget {
  const DataFilteringWidgetBuilder({
    required this.filter,
    required this.data,
    required this.builder,
    super.key,
  });

  final Widget Function(List<T> data) builder;
  final List<T> Function(List<T> data) filter;
  final List<T> data;

  @override
  State<DataFilteringWidgetBuilder<T>> createState() =>
      _DataFilteringWidgetBuilderState<T>();
}

class _DataFilteringWidgetBuilderState<T>
    extends State<DataFilteringWidgetBuilder<T>> {
  List<T> filteredData = [];

  @override
  void didUpdateWidget(covariant DataFilteringWidgetBuilder<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.data != widget.data || oldWidget.filter != widget.filter) {
      filteredData = widget.filter(widget.data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(filteredData);
  }
}

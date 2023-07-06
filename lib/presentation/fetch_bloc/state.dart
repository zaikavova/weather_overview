class FetchState<DataPM> {
  FetchState({
    this.isLoading = true,
    this.error,
    this.items,
  });

  final List<DataPM>? items;
  final bool isLoading;
  final String? error;

  bool get hasError => error != null;
}

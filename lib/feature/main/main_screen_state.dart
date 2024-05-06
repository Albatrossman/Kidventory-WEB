class MainScreenState {
  final bool loading;
  final String? message;

  MainScreenState({this.loading = false, this.message});

  MainScreenState copy({bool? loading, String? message}) {
    return MainScreenState(
      loading: loading ?? this.loading,
      message: message ?? this.message,
    );
  }
}

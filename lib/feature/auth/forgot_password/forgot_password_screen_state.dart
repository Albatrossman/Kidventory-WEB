class ForgotPasswordScreenState {
  final bool loading;
  final String? message;

  ForgotPasswordScreenState({this.loading = false, this.message});

  ForgotPasswordScreenState copy({bool? loading, String? message}) {
    return ForgotPasswordScreenState(
      loading: loading ?? this.loading,
      message: message ?? this.message,
    );
  }
}

class SignUpScreenState {
  final bool loading;
  final String? message;

  SignUpScreenState({this.loading = false, this.message});

  SignUpScreenState copy({bool? loading, String? message}) {
    return SignUpScreenState(
      loading: loading ?? this.loading,
      message: message ?? this.message,
    );
  }
}
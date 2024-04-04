class SignInScreenState {
  final bool loading;
  final String? message;

  SignInScreenState({this.loading = false, this.message});

  SignInScreenState copy({bool? loading, String? message}) {
    return SignInScreenState(
      loading: loading ?? this.loading,
      message: message ?? this.message,
    );
  }
}

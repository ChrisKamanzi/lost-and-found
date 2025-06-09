class LoginState {
  final String email;
  final String password;
  final bool isLoading;
  final String? error;

  LoginState({
    this.email = '',
    this.password = '',
    this.isLoading = false,
    this.error,
  });

  LoginState copyWith({
    String? email,
    String? password,
    bool? isLoading,
    String? error,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

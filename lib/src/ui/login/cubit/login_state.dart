part of 'login_cubit.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {
  final bool? hasHidePass;
  final bool isBusy;

  LoginInitial({
    this.isBusy = false,
    this.hasHidePass = true,
  });

  LoginInitial copyWith({
    bool? hasHidePass,
    bool? isBusy,
  }) {
    return LoginInitial(
      hasHidePass: hasHidePass ?? this.hasHidePass,
      isBusy: isBusy ?? this.isBusy,
    );
  }
}

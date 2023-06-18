part of 'sign_up_cubit.dart';

abstract class SignUpState {}

class SignUpInitial extends SignUpState {
  final bool? hasHidePass, hasHideConfirmPass, isBusy, hasAcceptTerms;

  SignUpInitial({
    this.hasHidePass = true,
    this.hasHideConfirmPass = true,
    this.isBusy = false,
    this.hasAcceptTerms = false,
  });

  SignUpInitial copyWith({
    bool? hasHidePass,
    bool? isBusy,
    bool? hasHideConfirmPass,
    bool? hasAcceptTerms,
  }) {
    return SignUpInitial(
      hasHidePass: hasHidePass ?? this.hasHidePass,
      hasHideConfirmPass: hasHideConfirmPass ?? this.hasHideConfirmPass,
      isBusy: isBusy ?? this.isBusy,
      hasAcceptTerms: hasAcceptTerms ?? this.hasAcceptTerms,
    );
  }
}

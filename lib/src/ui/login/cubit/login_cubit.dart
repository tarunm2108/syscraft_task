import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syscraft_task/app_locale/lang_key.dart';
import 'package:syscraft_task/app_routes/app_routes.dart';
import 'package:syscraft_task/repository/local_db/db_service.dart';
import 'package:syscraft_task/utils/navigation.dart';
import 'package:syscraft_task/utils/shared_pre.dart';
import 'package:syscraft_task/utils/utility.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final emailNode = FocusNode();
  final passNode = FocusNode();

  LoginCubit() : super(LoginInitial());

  void hideShowPass() {
    final last = state as LoginInitial;
    emit(last.copyWith(hasHidePass: !(last.hasHidePass ?? false)));
  }

  Future<void> loginTap() async {
    if (emailCtrl.text.trim().isEmpty) {
      Utility.showToast(msg: LangKey.pleaseEnterEmail);
    } else if (passCtrl.text.trim().isEmpty) {
      Utility.showToast(msg: LangKey.pleaseEnterPassword);
    } else if (!Utility.isEmail(emailCtrl.text.trim())) {
      Utility.showToast(msg: LangKey.pleaseEnterValidEmail);
    } else {
      final lastState = state as LoginInitial;
      emailNode.unfocus();
      passNode.unfocus();
      emit(lastState.copyWith(isBusy: true));
      final user = await DBService.instance
          .getUserDetails(emailCtrl.text.trim(), passCtrl.text.trim());
      emit(lastState.copyWith(isBusy: false));
      if (user != null) {
        SharedPre.instance.setObj(SharedPre.loginUser, user.toJson());
        NavigationService.instance.popAllAndPushName(AppRoutes.home);
      } else {
        Utility.showToast(msg: LangKey.invalidCredential);
      }
    }
  }

  void goToSignUp() {
    NavigationService.instance.replace(AppRoutes.signUp);
  }
}

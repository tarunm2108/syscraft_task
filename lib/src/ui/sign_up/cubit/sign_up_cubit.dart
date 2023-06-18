import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:syscraft_task/app_locale/lang_key.dart';
import 'package:syscraft_task/app_routes/app_routes.dart';
import 'package:syscraft_task/model/user_model.dart';
import 'package:syscraft_task/repository/local_db/db_service.dart';
import 'package:syscraft_task/utils/navigation.dart';
import 'package:syscraft_task/utils/shared_pre.dart';
import 'package:syscraft_task/utils/utility.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());

  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final nameCtrl = TextEditingController();
  final lastnameCtrl = TextEditingController();
  final dobCtrl = TextEditingController();
  final confirmPassCtrl = TextEditingController();
  final nameNode = FocusNode();
  final lastnameNode = FocusNode();
  final emailNode = FocusNode();
  final passNode = FocusNode();
  final confirmPassNode = FocusNode();

  void hideShowPass() {
    final last = state as SignUpInitial;
    emit(last.copyWith(hasHidePass: !(last.hasHidePass ?? false)));
  }

  void hideShowConfirmPass() {
    final last = state as SignUpInitial;
    emit(
        last.copyWith(hasHideConfirmPass: !(last.hasHideConfirmPass ?? false)));
  }

  Future<void> onSubmitTap() async {
    final lastState = state as SignUpInitial;
    if (nameCtrl.text.trim().isEmpty) {
      Utility.showToast(msg: LangKey.allFieldsRequired);
    } else if (lastnameCtrl.text.trim().isEmpty) {
      Utility.showToast(msg: LangKey.allFieldsRequired);
    } else if (emailCtrl.text.trim().isEmpty) {
      Utility.showToast(msg: LangKey.allFieldsRequired);
    } else if (dobCtrl.text.trim().isEmpty) {
      Utility.showToast(msg: LangKey.allFieldsRequired);
    } else if (passCtrl.text.trim().isEmpty) {
      Utility.showToast(msg: LangKey.allFieldsRequired);
    } else if (confirmPassCtrl.text.trim().isEmpty) {
      Utility.showToast(msg: LangKey.allFieldsRequired);
    } else if (!Utility.isEmail(emailCtrl.text.trim())) {
      Utility.showToast(msg: LangKey.pleaseEnterValidEmail);
    } else if (passCtrl.text.trim() != confirmPassCtrl.text.trim()) {
      Utility.showToast(msg: LangKey.passwordDoesNoMatch);
    } else if (!(lastState.hasAcceptTerms ?? false)) {
      Utility.showToast(msg: LangKey.pleaseAcceptTermsAndConditions);
    } else {
      nameNode.unfocus();
      lastnameNode.unfocus();
      emailNode.unfocus();
      passNode.unfocus();
      confirmPassNode.unfocus();
      emit(lastState.copyWith(isBusy: true));
      final isEmailExist =
          await DBService.instance.checkEmailExists(emailCtrl.text.trim());
      if (isEmailExist) {
        emit(lastState.copyWith(isBusy: false));
        Utility.showToast(msg: LangKey.emailAlreadyExist);
      } else {
        final result = await DBService.instance.insertUser(UserModel(
          firstname: nameCtrl.text.trim(),
          lastname: lastnameCtrl.text.trim(),
          email: emailCtrl.text.trim(),
          password: passCtrl.text.trim(),
          dob: dobCtrl.text.trim(),
          hasWelcome: 0,
        ),);
        debugPrint('insert result = $result');
        emit(lastState.copyWith(isBusy: false));
        if (result > 0) {
          final user = await DBService.instance
              .getUserDetails(emailCtrl.text.trim(), passCtrl.text.trim());
          if (user != null) {
            SharedPre.instance.setObj(SharedPre.loginUser, user.toJson());
            NavigationService.instance.popAllAndPushName(AppRoutes.home);
          } else {
            NavigationService.instance.popAllAndPushName(AppRoutes.login);
          }
        } else {
          Utility.showToast(msg: LangKey.userRegistrationFailed);
        }
      }
    }
  }

  void goToLogin() {
    NavigationService.instance.replace(AppRoutes.login);
  }

  void selectDate(BuildContext context) {
    DateTime selectedDate = DateTime.now();
    if (dobCtrl.text.isNotEmpty) {
      selectedDate = DateFormat('dd MMM, yyyy').parse(dobCtrl.text.trim());
    }
    Utility.commonDatePicker(
      context: context,
      onDateSelection: (date) {
        dobCtrl.text = DateFormat('dd MMM, yyyy').format(date);
        emit(state);
      },
      selectedDate: selectedDate,
    );
  }

  void termsTap() {
    final last = state as SignUpInitial;
    emit(last.copyWith(hasAcceptTerms: !(last.hasAcceptTerms ?? false)));
  }
}

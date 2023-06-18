import 'package:syscraft_task/app_locale/lang_key.dart';
import 'package:syscraft_task/src/extensions/space_extension.dart';
import 'package:syscraft_task/src/extensions/text_style_extension.dart';
import 'package:syscraft_task/src/ui/sign_up/cubit/sign_up_cubit.dart';
import 'package:syscraft_task/src/widgets/app_bar_widget.dart';
import 'package:syscraft_task/src/widgets/app_button_widget.dart';
import 'package:syscraft_task/src/widgets/app_scaffold.dart';
import 'package:syscraft_task/src/widgets/app_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpCubit(),
      child: BlocBuilder<SignUpCubit, SignUpState>(
        builder: (context, state) {
          if (state is SignUpInitial) {
            return WillPopScope(
              onWillPop: (){
                context.read<SignUpCubit>().goToLogin();
                return Future.value(false);
              },
              child: AppScaffold(
                appBar: const AppBarWidget(title: LangKey.signUp),
                body: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      AppTextFieldWidget(
                        controller: context.read<SignUpCubit>().nameCtrl,
                        hintText: LangKey.firstname,
                        inputAction: TextInputAction.next,
                        node: context.read<SignUpCubit>().nameNode,
                        textCapitalization: TextCapitalization.words,
                      ),
                      20.toSpace,
                      AppTextFieldWidget(
                        controller: context.read<SignUpCubit>().lastnameCtrl,
                        hintText: LangKey.lastname,
                        inputAction: TextInputAction.next,
                        node: context.read<SignUpCubit>().lastnameNode,
                        textCapitalization: TextCapitalization.words,
                      ),
                      20.toSpace,
                      AppTextFieldWidget(
                        controller: context.read<SignUpCubit>().dobCtrl,
                        hintText: LangKey.dob,
                        inputAction: TextInputAction.next,
                        readOnly: true,
                        onTap: () =>
                            context.read<SignUpCubit>().selectDate(context),
                      ),
                      20.toSpace,
                      AppTextFieldWidget(
                        controller: context.read<SignUpCubit>().emailCtrl,
                        hintText: LangKey.email,
                        inputType: TextInputType.emailAddress,
                        inputAction: TextInputAction.next,
                        node: context.read<SignUpCubit>().emailNode,
                      ),
                      20.toSpace,
                      AppTextFieldWidget(
                        controller: context.read<SignUpCubit>().passCtrl,
                        hintText: LangKey.password,
                        inputType: TextInputType.text,
                        inputAction: TextInputAction.next,
                        node: context.read<SignUpCubit>().passNode,
                        obscureText: state.hasHidePass,
                        suffix: InkWell(
                          onTap: () => context.read<SignUpCubit>().hideShowPass(),
                          child: Icon(
                            state.hasHidePass ?? false
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                      ),
                      20.toSpace,
                      AppTextFieldWidget(
                        controller: context.read<SignUpCubit>().confirmPassCtrl,
                        hintText: LangKey.confirmPassword,
                        inputType: TextInputType.text,
                        inputAction: TextInputAction.done,
                        node: context.read<SignUpCubit>().confirmPassNode,
                        obscureText: state.hasHideConfirmPass,
                        suffix: InkWell(
                          onTap: () =>
                              context.read<SignUpCubit>().hideShowConfirmPass(),
                          child: Icon(
                            state.hasHideConfirmPass ?? false
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                      ),
                      CheckboxListTile(
                        value: state.hasAcceptTerms,
                        contentPadding: EdgeInsets.zero,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        controlAffinity: ListTileControlAffinity.leading,
                        onChanged: (value) =>
                            context.read<SignUpCubit>().termsTap(),
                        title: Text(
                          LangKey.acceptTermsAndConditions,
                          style: const TextStyle().regular,
                        ),
                      ),
                      AppButtonWidget(
                        onPressed: () =>
                            context.read<SignUpCubit>().onSubmitTap(),
                        title: LangKey.submit,
                      ),
                      20.toSpace,
                      InkWell(
                        onTap: () => context.read<SignUpCubit>().goToLogin(),
                        child: RichText(
                          text: TextSpan(
                            text: LangKey.alreadyYouHaveAccount,
                            style: const TextStyle().regular.copyWith(
                                  color: Colors.black,
                                ),
                            children: [
                              TextSpan(
                                text: " ${LangKey.login}",
                                style: const TextStyle().bold.copyWith(
                                      color: Colors.blue,
                                    ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}

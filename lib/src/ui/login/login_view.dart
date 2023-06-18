import 'package:syscraft_task/app_locale/lang_key.dart';
import 'package:syscraft_task/src/extensions/space_extension.dart';
import 'package:syscraft_task/src/extensions/text_style_extension.dart';
import 'package:syscraft_task/src/ui/login/cubit/login_cubit.dart';
import 'package:syscraft_task/src/widgets/app_bar_widget.dart';
import 'package:syscraft_task/src/widgets/app_button_widget.dart';
import 'package:syscraft_task/src/widgets/app_scaffold.dart';
import 'package:syscraft_task/src/widgets/app_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          if (state is LoginInitial) {
            return AppScaffold(
              noneClickable: state.isBusy,
              appBar: const AppBarWidget(title: LangKey.login),
              body: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppTextFieldWidget(
                        controller: context.read<LoginCubit>().emailCtrl,
                        hintText: LangKey.email,
                        inputType: TextInputType.emailAddress,
                        inputAction: TextInputAction.next,
                        node: context.read<LoginCubit>().emailNode,
                      ),
                      20.toSpace,
                      AppTextFieldWidget(
                        controller: context.read<LoginCubit>().passCtrl,
                        hintText: LangKey.password,
                        inputType: TextInputType.text,
                        inputAction: TextInputAction.done,
                        node: context.read<LoginCubit>().passNode,
                        obscureText: state.hasHidePass,
                        suffix: InkWell(
                          onTap: () => context.read<LoginCubit>().hideShowPass(),
                          child: Icon(state.hasHidePass ?? false
                              ? Icons.visibility
                              : Icons.visibility_off,),
                        ),
                      ),
                      20.toSpace,
                      AppButtonWidget(
                        onPressed: () => context.read<LoginCubit>().loginTap(),
                        title: LangKey.login,
                      ),
                      20.toSpace,
                      InkWell(
                        onTap: () => context.read<LoginCubit>().goToSignUp(),
                        child: RichText(
                          text: TextSpan(
                            text: LangKey.doNotYouHaveAccount,
                            style: const TextStyle().regular.copyWith(
                                  color: Colors.black,
                                ),
                            children: [
                              TextSpan(
                                text: " ${LangKey.signUp}",
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

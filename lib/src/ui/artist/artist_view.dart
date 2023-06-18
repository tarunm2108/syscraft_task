import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syscraft_task/app_locale/lang_key.dart';
import 'package:syscraft_task/src/extensions/space_extension.dart';
import 'package:syscraft_task/src/ui/artist/artist_arg.dart';
import 'package:syscraft_task/src/ui/artist/cubit/artist_cubit.dart';
import 'package:syscraft_task/src/widgets/app_bar_widget.dart';
import 'package:syscraft_task/src/widgets/app_button_widget.dart';
import 'package:syscraft_task/src/widgets/app_scaffold.dart';
import 'package:syscraft_task/src/widgets/app_text_field_widget.dart';

class ArtistView extends StatelessWidget {
  const ArtistView({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as ArtistArg;
    return BlocProvider(
      create: (context) => ArtistCubit()..init(context, args),
      child: BlocBuilder<ArtistCubit, ArtistState>(
        builder: (context, state) {
          if (state is ArtistInitial) {
            return AppScaffold(
              noneClickable: state.isBusy,
              appBar: AppBarWidget(
                title: args.action == ArtistAction.add
                    ? LangKey.addArtist
                    : LangKey.editArtist,
              ),
              body: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppTextFieldWidget(
                      controller: context.read<ArtistCubit>().nameCtrl,
                      hintText: LangKey.name,
                      inputAction: TextInputAction.next,
                      node: context.read<ArtistCubit>().nameNode,
                      textCapitalization: TextCapitalization.words,
                    ),
                    20.toSpace,
                    AppTextFieldWidget(
                      controller: context.read<ArtistCubit>().dobCtrl,
                      hintText: LangKey.dob,
                      inputAction: TextInputAction.next,
                      readOnly: true,
                      onTap: () =>
                          context.read<ArtistCubit>().selectDate(context),
                    ),
                    40.toSpace,
                    AppButtonWidget(
                      onPressed: () =>
                          context.read<ArtistCubit>().onSubmitTap(),
                      title: LangKey.submit,
                    ),
                  ],
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

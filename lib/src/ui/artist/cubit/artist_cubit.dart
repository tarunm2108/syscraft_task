import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:syscraft_task/app_locale/lang_key.dart';
import 'package:syscraft_task/model/artist_model.dart';
import 'package:syscraft_task/repository/local_db/db_service.dart';
import 'package:syscraft_task/src/ui/artist/artist_arg.dart';
import 'package:syscraft_task/utils/navigation.dart';
import 'package:syscraft_task/utils/shared_pre.dart';
import 'package:syscraft_task/utils/utility.dart';

part 'artist_state.dart';

class ArtistCubit extends Cubit<ArtistState> {
  final nameCtrl = TextEditingController();
  final dobCtrl = TextEditingController();
  final nameNode = FocusNode();

  ArtistCubit() : super(ArtistInitial());

  void init(BuildContext context, ArtistArg args) {
    final last = state as ArtistInitial;
    emit(last.copyWith(isBusy: true));
    if (args.artist != null) {
      nameCtrl.text = args.artist?.name ?? '';
      dobCtrl.text = args.artist?.dob ?? '';
    }
    emit(last.copyWith(isBusy: false, args: args));
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

  Future<void> onSubmitTap() async {
    final lastState = state as ArtistInitial;
    if (nameCtrl.text.trim().isEmpty) {
      Utility.showToast(msg: LangKey.allFieldsRequired);
    } else if (dobCtrl.text.trim().isEmpty) {
      Utility.showToast(msg: LangKey.allFieldsRequired);
    } else {
      emit(lastState.copyWith(isBusy: true));
      final data = await SharedPre.instance.getObj(SharedPre.loginUser);
      if (lastState.args?.action == ArtistAction.edit) {
        lastState.args?.artist?.name = nameCtrl.text.trim();
        lastState.args?.artist?.dob = dobCtrl.text.trim();
       await DBService.instance.updateArtist(lastState.args!.artist!);
      } else {
        await DBService.instance.insertArtist(
          ArtistModel(
            userId: data['id'],
            name: nameCtrl.text.trim(),
            dob: dobCtrl.text.trim(),
          ),
        );
      }
      emit(lastState.copyWith(isBusy: false));
      NavigationService.instance.pop();
    }
  }
}

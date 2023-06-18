import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syscraft_task/app_locale/lang_key.dart';
import 'package:syscraft_task/app_routes/app_routes.dart';
import 'package:syscraft_task/model/artist_model.dart';
import 'package:syscraft_task/model/user_model.dart';
import 'package:syscraft_task/repository/api/api_client.dart';
import 'package:syscraft_task/repository/local_db/db_service.dart';
import 'package:syscraft_task/repository/response/api_resp.dart';
import 'package:syscraft_task/src/extensions/text_style_extension.dart';
import 'package:syscraft_task/src/ui/artist/artist_arg.dart';
import 'package:syscraft_task/utils/navigation.dart';
import 'package:syscraft_task/utils/shared_pre.dart';
import 'package:syscraft_task/utils/utility.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  UserModel? loginUser;

  Future<void> init(BuildContext context) async {
    final last = state as HomeInitial;
    emit(last.copyWith(isBusy: true));
    SharedPre.instance.getObj(SharedPre.loginUser).then((data) {
      if (data.isNotEmpty) {
        loginUser = UserModel.fromJson(data);
        if (loginUser?.hasWelcome == null || loginUser?.hasWelcome == 0) {
          loginUser?.hasWelcome = 1;
          SharedPre.instance.setObj(SharedPre.loginUser, loginUser?.toJson());
          DBService.instance.update(loginUser!);
          showWelcomeDialog(context);
        }
        getArtist();
      } else {
        emit(last.copyWith(isBusy: false));
      }
    });
  }

  Future<void> getArtist() async {
    final last = state as HomeInitial;
    emit(last.copyWith(isBusy: true));
    final list = await DBService.instance.getUserArtist(loginUser?.id ?? 0);
    emit(last.copyWith(artistList: list, isBusy: false));
  }

  void showWelcomeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(
            LangKey.welcome,
            style: const TextStyle().bold,
          ),
          content: Text(
            LangKey.congratulations,
            style: const TextStyle().regular,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              style: TextButton.styleFrom(
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                padding: EdgeInsets.zero,
              ),
              child: Text(
                LangKey.ok.toUpperCase(),
                style: const TextStyle().bold,
              ),
            ),
          ],
        );
      },
    );
  }

  void goToArtist() {
    NavigationService.instance
        .navigateTo(AppRoutes.artist, arg: ArtistArg(action: ArtistAction.add))
        .then((value) => getArtist());
  }

  Future<void> logout() async {
    final last = state as HomeInitial;
    emit(last.copyWith(isBusy: true));
    await SharedPre.instance.clearAll();
    emit(last.copyWith(isBusy: false));
    NavigationService.instance.popAllAndPushName(AppRoutes.login);
  }

  Future<void> deleteArtist(ArtistModel item) async {
    final last = state as HomeInitial;
    emit(last.copyWith(isBusy: true));
    final result = await DBService.instance.deleteArtist(item.id ?? 0);
    if (result > 0) {
      last.artistList?.remove(item);
    }
    emit(last.copyWith(isBusy: false, artistList: last.artistList));
  }

  void editArtist(ArtistModel item) {
    NavigationService.instance
        .navigateTo(AppRoutes.artist,
            arg: ArtistArg(
              action: ArtistAction.edit,
              artist: item,
            ))
        .then((value) => getArtist());
  }

  Future<void> loadData() async {
    if (await Utility.checkNetwork()) {
      final last = state as HomeInitial;
      try {
        emit(last.copyWith(isBusy: true));
        final response = await ApiClient.instance
            .getMethod(url: 'https://dummyjson.com/users');
        if (response.statusCode == 200) {
          final apiResp = apiRespFromJson(response.body);
          emit(last.copyWith(isBusy: false, userList: apiResp.users ?? []));
        } else {
          Utility.showToast(msg: LangKey.serverNotRespond);
          emit(last.copyWith(isBusy: false));
        }
      } catch (e) {
        emit(last.copyWith(isBusy: false));
      }
    } else {
      Utility.showToast(msg: LangKey.noInternet);
    }
  }

  void onTabChange(int index) {
    final last = state as HomeInitial;
    emit(last.copyWith(selectTab: index));
    if(index == 1){
      loadData();
    }
  }
}

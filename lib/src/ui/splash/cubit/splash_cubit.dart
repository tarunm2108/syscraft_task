import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syscraft_task/app_routes/app_routes.dart';
import 'package:syscraft_task/utils/navigation.dart';
import 'package:syscraft_task/utils/shared_pre.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  Future<void> init() async {
    final data = await SharedPre.instance.getObj(SharedPre.loginUser);
    await Future.delayed(const Duration(seconds: 5)).whenComplete(
      () {
        if (data.isNotEmpty) {
          NavigationService.instance.popAllAndPushName(AppRoutes.home);
        } else {
          NavigationService.instance.popAllAndPushName(AppRoutes.login);
        }
      },
    );
  }
}

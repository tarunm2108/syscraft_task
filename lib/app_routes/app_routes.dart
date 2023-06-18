import 'package:syscraft_task/src/ui/artist/artist_view.dart';
import 'package:syscraft_task/src/ui/home/home_view.dart';
import 'package:syscraft_task/src/ui/login/login_view.dart';
import 'package:syscraft_task/src/ui/no_internet/no_internet_view.dart';
import 'package:syscraft_task/src/ui/sign_up/sign_up_view.dart';
import 'package:syscraft_task/src/ui/splash/splash_view.dart';

class AppRoutes {
  static const splash = '/';
  static const login = '/login';
  static const signUp = '/signUp';
  static const home = '/home';
  static const artist = '/artist';
  static const noInternet = '/NoInternetView';

  static final routes = {
    splash: (context) => const SplashView(),
    login: (context) => const LoginView(),
    signUp: (context) => const SignUpView(),
    home: (context) => const HomeView(),
    artist: (context) => const ArtistView(),
    noInternet: (context) => const NoInternetView(),
  };
}

import 'package:syscraft_task/app_cubit/app_cubit.dart';
import 'package:syscraft_task/app_routes/app_routes.dart';
import 'package:syscraft_task/src/ui/no_internet/no_internet_view.dart';
import 'package:syscraft_task/utils/constants.dart';
import 'package:syscraft_task/utils/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver{

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    debugPrint('AppLifecycleState = $state');
    super.didChangeAppLifecycleState(state);
  }
  @override
  void dispose() {
   WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..init(),
      child: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          if (state is AppNoInternet) {
            return MaterialApp(
              title: Constants.appName,
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              home: const NoInternetView(),
            );
          }  else {
            return MaterialApp(
              title: Constants.appName,
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              routes: AppRoutes.routes,
              navigatorKey: NavigationService.instance.navigatorKey,
            );
          }
        },
      ),
    );
  }
}

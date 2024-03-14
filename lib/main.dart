import 'package:blog_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/auth/presentation/pages/login.dart';
import 'package:blog_app/features/home/presentation/pages/home_page.dart';
import 'package:blog_app/init_dependancies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependancies();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => serviceLocator<AppUserCubit>()),
      BlocProvider(create: (_) => serviceLocator<AuthBloc>())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(IsUserLoggedIn());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Blogify',
        theme: ThemeData.dark(useMaterial3: true),
        home: BlocSelector<AppUserCubit, AppUserState, bool>(
          selector: (state) {
            return state is AppUserLoggedIn;
          },
          builder: (context, isLoggedInState) {
            if (isLoggedInState) {
              return const HomePage();
            }
            return const SignInScreen();
          },
        ));
  }
}

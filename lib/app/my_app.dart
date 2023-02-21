import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoes_shop_ui/app/bloc/auth_bloc.dart';
import 'package:shoes_shop_ui/routes/app_navigation.dart';

class App extends StatelessWidget {
  const App({
    super.key,
    required ScreenFactory screenFactory,
    required AuthenticationRepository authRepository,
  })  : _authRepository = authRepository,
        _screenFactory = screenFactory;

  final AuthenticationRepository _authRepository;
  final ScreenFactory _screenFactory;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(
          value: _authRepository,
        ),
      ],
      child: BlocProvider(
        create: (_) => AuthBloc(
          authRepository: _authRepository,
        ),
        child: _MateApp(_screenFactory),
      ),
    );
  }
}

class _MateApp extends StatelessWidget {
  const _MateApp(this.screenFactory);
  final ScreenFactory screenFactory;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return CupertinoApp.router(
          theme: const CupertinoThemeData(brightness: Brightness.light),
          color: const Color(0xFFcccccc),
          // theme: AppThemes.lightTheme,
          // darkTheme: AppThemes.lightTheme,
          // localizationsDelegates: AppLocalizations.localizationsDelegates,
          // supportedLocales: AppLocalizations.supportedLocales,
          routerConfig: AppRouter(
            screenFactory: screenFactory,
            authBloc: context.read<AuthBloc>(),
          ).router,
        );
      },
    );
  }
}

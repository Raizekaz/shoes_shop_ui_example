import 'package:flutter/material.dart';
import 'package:shoes_shop_ui/routes/app_navigation.dart';

class App extends StatelessWidget {
  const App({
    super.key,
    required ScreenFactory screenFactory,
    // required AuthenticationRepository authenticationRepository,
  }) :
        // _authenticationRepository = authenticationRepository,
        _screenFactory = screenFactory;

  // final AuthenticationRepository _authenticationRepository;
  final ScreenFactory _screenFactory;

  @override
  Widget build(BuildContext context) {
    return
        // RepositoryProvider.value(
        //   value: _authenticationRepository,
        //   child: BlocProvider(
        //     create: (_) => AppBloc(
        //       authenticationRepository: _authenticationRepository,
        //     ),
        //     child:
        _MateApp(_screenFactory
            // ),
            // ),
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
        return MaterialApp.router(
            // theme: AppThemes.lightTheme,
            // darkTheme: AppThemes.lightTheme,
            // localizationsDelegates: AppLocalizations.localizationsDelegates,
            // supportedLocales: AppLocalizations.supportedLocales,
            routerConfig:
                // AppRouter(context.read<AppBloc>(), screenFactory).router,
                AppRouter(screenFactory).router);
      },
    );
  }
}

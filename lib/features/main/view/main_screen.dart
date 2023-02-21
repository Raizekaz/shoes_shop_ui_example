import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoes_shop_ui/app/bloc/auth_bloc.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: Center(
            child: Column(
      children: [
        CupertinoButton(
            child: Text('asd'),
            onPressed: () {
              context.read<AuthBloc>().add(AuthLogoutRequested());
            }),
        Text('MAIN PAGE'),
      ],
    )));
  }
}

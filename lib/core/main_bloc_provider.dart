import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../presentation/logic/locale/locale_cubit.dart';
import '../presentation/logic/user/user_bloc.dart';

class MainBlocProvider extends StatelessWidget {
  const MainBlocProvider({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) =>
      MultiBlocProvider(providers: <BlocProvider<dynamic>>[
        BlocProvider<LocaleCubit>(
          create: (context) => LocaleCubit(),
        ),
        BlocProvider<UserBloc>(
          create: (context) => UserBloc(RepositoryProvider.of(context)),
        ),
      ], child: child);
}

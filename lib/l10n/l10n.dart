import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../presentation/logic/locale/locale_cubit.dart';

class L10n {
  L10n._();

  factory L10n.of(BuildContext context) =>
      _instance..tr = AppLocalizations.of(context)!;

  static L10n get _instance => L10n._();

  late final AppLocalizations tr;

  final List<Locale> locales = <Locale>[
    const Locale('en', 'US'),
  ];

  bool updateLocale(BuildContext context, Locale locale) {
    if (!locales.contains(locale)) {
      return false;
    }
    context.read<LocaleCubit>().onUpdateLocale(locale);
    return true;
  }
}

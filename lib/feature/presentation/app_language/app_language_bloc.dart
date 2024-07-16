import 'dart:developer';
import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:eti_chat/feature/data/data_sources/local_datasource.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_language_event.dart';

part 'app_language_state.dart';

class AppLanguageBloc extends Cubit<Locale> {
  final LocalDataSource _localDataSource;

  AppLanguageBloc({required final LocalDataSource localDataSource})
      : _localDataSource = localDataSource,
        super(Locale(localDataSource.getLocaleLanguage())) {
    emitAppLanguage();
  }

  void emitAppLanguage() {
    final defaultLocale = _localDataSource.getLocaleLanguage();
    _localDataSource.setLocaleLanguage(defaultLocale == "en" ? "ar" : "en");
    var locale = Locale(_localDataSource.getLocaleLanguage());
    log("CuBt: PreferAppCacheLang ${locale.languageCode}");
    emit.call(locale);
  }
}

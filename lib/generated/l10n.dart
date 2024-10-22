// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Notes`
  String get notesList {
    return Intl.message(
      'Notes',
      name: 'notesList',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Reminders`
  String get reminders {
    return Intl.message(
      'Reminders',
      name: 'reminders',
      desc: '',
      args: [],
    );
  }

  /// `Заголовок`
  String get title {
    return Intl.message(
      'Заголовок',
      name: 'title',
      desc: '',
      args: [],
    );
  }

  /// `Описание`
  String get description {
    return Intl.message(
      'Описание',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `Создание заметки`
  String get note_create {
    return Intl.message(
      'Создание заметки',
      name: 'note_create',
      desc: '',
      args: [],
    );
  }

  /// `Редактирование заметки`
  String get note_edit {
    return Intl.message(
      'Редактирование заметки',
      name: 'note_edit',
      desc: '',
      args: [],
    );
  }

  /// `Введите текст`
  String get enter_text {
    return Intl.message(
      'Введите текст',
      name: 'enter_text',
      desc: '',
      args: [],
    );
  }

  /// `Авторизоваться`
  String get auth {
    return Intl.message(
      'Авторизоваться',
      name: 'auth',
      desc: '',
      args: [],
    );
  }

  /// `Зарегистрироваться`
  String get register {
    return Intl.message(
      'Зарегистрироваться',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Email is not correct`
  String get email_text_error {
    return Intl.message(
      'Email is not correct',
      name: 'email_text_error',
      desc: '',
      args: [],
    );
  }

  /// `Password contains less than 6 characters`
  String get password_text_error {
    return Intl.message(
      'Password contains less than 6 characters',
      name: 'password_text_error',
      desc: '',
      args: [],
    );
  }

  /// `Пользователь зарегестрирован успешно`
  String get successfully_registered {
    return Intl.message(
      'Пользователь зарегестрирован успешно',
      name: 'successfully_registered',
      desc: '',
      args: [],
    );
  }

  /// `ОК`
  String get ok {
    return Intl.message(
      'ОК',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Войти`
  String get sign_in {
    return Intl.message(
      'Войти',
      name: 'sign_in',
      desc: '',
      args: [],
    );
  }

  /// `Создать аккаунт`
  String get create_account {
    return Intl.message(
      'Создать аккаунт',
      name: 'create_account',
      desc: '',
      args: [],
    );
  }

  /// `Предупреждение`
  String get save_local_data_title {
    return Intl.message(
      'Предупреждение',
      name: 'save_local_data_title',
      desc: '',
      args: [],
    );
  }

  /// `У вас есть локальные заметки, хотите ли вы иъ сохранить? `
  String get save_local_data_description {
    return Intl.message(
      'У вас есть локальные заметки, хотите ли вы иъ сохранить? ',
      name: 'save_local_data_description',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get button_yes {
    return Intl.message(
      'Yes',
      name: 'button_yes',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get button_no {
    return Intl.message(
      'No',
      name: 'button_no',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'ru'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}

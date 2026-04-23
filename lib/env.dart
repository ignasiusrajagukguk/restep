import 'package:flutter/foundation.dart';

// todo: ignore once cicd is ready
class Config {
  static const environment = String.fromEnvironment('ENV', defaultValue: 'DEV');
  static final Map<String, Map<String, dynamic>> _args = {
    'DEV': _dev,
    'STG': _stg,
    'PROD': _prod,
  };
  static const String _keyIsLogEnable = 'isLogEnable';
  static const String _keyBaseUrl = 'baseUrl';
  static const String _keyConnectTimeout = 'connectTimeout';
  static const String _keyReceiveTimeout = 'receiveTimeout';
  static const String _keyIsHttpLogEnable = 'isHttpLogInterceptorEnable';
  static const String _keyWiredashProjectId = 'wiredashProjectId';
  static const String _keyWiredashSecret = 'wiredashSecret';

  static final _dev = {
    _keyIsLogEnable: true,
    _keyIsHttpLogEnable: true,
    _keyBaseUrl: '',
    // _keyBaseUrl: 'https://api-dev.elemes.id',
    _keyConnectTimeout: 30 * 1000,
    _keyReceiveTimeout: 30 * 1000,
    _keyWiredashProjectId: '',
    _keyWiredashSecret: '',
  };

  static final _stg = {
    _keyIsLogEnable: false,
    _keyIsHttpLogEnable: false,
    _keyBaseUrl: '',
    _keyConnectTimeout: 30 * 1000,
    _keyReceiveTimeout: 30 * 1000,
    _keyWiredashProjectId: '',
    _keyWiredashSecret: '',
  };

  static final _prod = {
    _keyIsLogEnable: true,
    _keyIsHttpLogEnable: false,
    _keyBaseUrl: '',
    _keyConnectTimeout: 30 * 1000,
    _keyReceiveTimeout: 30 * 1000,
    _keyWiredashProjectId: '',
    _keyWiredashSecret: '',
  };

  static bool get isLogEnable =>
      kReleaseMode ? false : _args[environment]![_keyIsLogEnable] as bool;

  static bool get isHttpLogEnable =>
      kReleaseMode ? false : _args[environment]![_keyIsHttpLogEnable] as bool;

  static String get baseUrl => _args[environment]![_keyBaseUrl] as String;

  static int get connectTimeout =>
      _args[environment]![_keyConnectTimeout] as int;

  static int get receiveTimeout =>
      _args[environment]![_keyReceiveTimeout] as int;

  static String get wiredashProjectId =>
      _args[environment]![_keyWiredashProjectId] as String;

  static String get wiredashSecret =>
      _args[environment]![_keyWiredashSecret] as String;

  static bool get isDev => environment == "DEV";
}

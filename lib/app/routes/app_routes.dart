part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const HOME = _Paths.HOME;
  static const NAVIGATION = '/navigation';
  static const PROFILE = _Paths.PROFILE;
  static const ACCOUNT = _Paths.ACCOUNT;
  static const SEARCHING = _Paths.SEARCHING;
}

abstract class _Paths {
  _Paths._();
  static const HOME = '/home';
  static const NAVIGATION = '/navigation';
  static const PROFILE = '/profile';
  static const ACCOUNT = '/account';
  static const SEARCHING = '/searching';
}

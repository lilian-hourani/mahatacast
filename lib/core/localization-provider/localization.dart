import 'package:flutter/material.dart';
import 'package:mahatacast/services/service_fun.dart';

class LocaleNotifier extends ChangeNotifier {
  late Locale _locale = const Locale('ar');
  bool _isArabic = true;
  Locale get local => _locale;
  bool get isArabic => _isArabic;
  void setLocal(Locale locale) {
    _locale = locale;
    _isArabic = !_isArabic;
    notifyListeners();
  }

  void initLocal() async {
    final String? lan = await ServiceFunctions.getLangauge();
    print(lan);
    if (lan != null) {
      _locale = Locale(lan);
      _isArabic = (lan == 'ar') ? true : false;
    } else {
      _locale = const Locale('en');
      _isArabic = false;
    }
    notifyListeners();
  }
}

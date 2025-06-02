import 'package:flutter/material.dart';

class KinyarwandaMaterialLocalizations extends DefaultMaterialLocalizations {
  const KinyarwandaMaterialLocalizations();

  static const LocalizationsDelegate<MaterialLocalizations> delegate =
  _KinyarwandaMaterialLocalizationsDelegate();

  @override
  String get okButtonLabel => 'Yego';

  @override
  String get cancelButtonLabel => 'Hagarika';

  @override
  String get backButtonTooltip => 'Subira inyuma';

  @override
  String get closeButtonLabel => 'Funga';

  @override
  String get nextMonthTooltip => 'Ukwezi gukurikira';

  @override
  String get previousMonthTooltip => 'Ukwezi kwabanje';

  @override
  String get todayLabel => 'Uyu munsi';

  @override
  String get searchFieldLabel => 'Shakisha';

  @override
  String get viewLicensesButtonLabel => 'Reba uruhushya';
}

class _KinyarwandaMaterialLocalizationsDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const _KinyarwandaMaterialLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'rw';

  @override
  Future<MaterialLocalizations> load(Locale locale) async {
    return const KinyarwandaMaterialLocalizations();
  }

  @override
  bool shouldReload(_KinyarwandaMaterialLocalizationsDelegate old) => false;
}

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';


abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();


  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
  ];

 
  String get appTitle;

 
  String get login;

 
  String get username;

  
  String get password;

  
  String get selectRole;

 
  String get adminRole;

  
  String get userRole;

 
  String get loginButton;

 
  String get continueAsGuest;

 
  String get changeLanguage;

 
  String get spaghettiCarbonara;

 
  String get linsenCurry;

 
  String get kaesespaetzle;

  
  String get haehnchenSuessSauer;

  
  String get gemueseLasagne;

  
  String get falafelTeller;

  
  String get wienerSchnitzel;

  
  String get pizzaMargherita;

  
  String get tofuPfanne;

  
  String get rindergulasch;

  
  String get vegetarian;

  
  String get vegan;

  
  String get withMeat;

  
  String get allReviewsTitle;

  
  String get noReviewsAvailable;

  
  String reviewRating(Object rating);

  
  String foodName(Object name);

  
  String createdBy(Object user);

  
  String commentText(Object comment);

  
  String get editButton;

  
  String get deleteButton;

  
  String get deleteReviewTitle;

  
  String get deleteReviewContent;

  
  String get cancelButton;

  
  String get confirmDeleteButton;

  
  String get monday;

  
  String get tuesday;

  
  String get wednesday;

  
  String get thursday;

  
  String get friday;

  
  String get essensplanTitle;

  
  String get filterByWeek;

  
  String get week;

  
  String get addReviewTooltip;

  
  String get addPlanTooltip;

  
  String get editPlanButton;

  
  String get confirmDeleteTitle;

  
  String confirmDeletePlanContent(Object weekNumber);

 
  String get speisekarteTitle;

  
  String get addMealTooltip;

  
  String confirmDeleteMealContent(Object mealName);

  
  String get addMealTitle;

  
  String get editMealTitle;

  
  String get mealNameLabel;

  
  String get priceLabel;

  
  String get saveButton;

  
  String get addPlanTitle;

  
  String get editPlanTitle;

  
  String get weekNumberLabel;

  
  String selectedMealsLabel(Object count);

  
  String get availableMealsLabel;

  
  String get editMealTooltip;

  
  String get removeMealFromPlanTooltip;

  
  String get addMealToPlanTooltip;

  
  String get addReviewTitle;

  
  String get editReviewTitle;

  
  String get unknownMeal;

  
  String loggedInAs(Object username);

  
  String starsRating(Object count);

  
  String get yourReviewLabel;

  
  String get takeAPhoto;

  
  String get photoOnlyOnMobile;

  
  String get cameraNotAvailable;

  
  String get reviewTextRequired;

  
  String reviewBy(Object username);

  
  String get manageMenuTitle;

  
  String get manageMenuSubtitle;

  
  String get weeklyPlansTitle;

  
  String get weeklyPlansSubtitle;

  
  String get reviewsTitle;

  
  String get reviewsSubtitle;

  
  String get loginSubtitle;

  
  String loggedInAsInfo(Object username, Object role);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['de', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Meal Planner App'**
  String get appTitle;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @username.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get username;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @selectRole.
  ///
  /// In en, this message translates to:
  /// **'Select Role'**
  String get selectRole;

  /// No description provided for @adminRole.
  ///
  /// In en, this message translates to:
  /// **'Admin'**
  String get adminRole;

  /// No description provided for @userRole.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get userRole;

  /// No description provided for @loginButton.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginButton;

  /// No description provided for @continueAsGuest.
  ///
  /// In en, this message translates to:
  /// **'Continue as Guest'**
  String get continueAsGuest;

  /// No description provided for @changeLanguage.
  ///
  /// In en, this message translates to:
  /// **'Change Language'**
  String get changeLanguage;

  /// No description provided for @spaghettiCarbonara.
  ///
  /// In en, this message translates to:
  /// **'Spaghetti Carbonara'**
  String get spaghettiCarbonara;

  /// No description provided for @linsenCurry.
  ///
  /// In en, this message translates to:
  /// **'Lentil Curry'**
  String get linsenCurry;

  /// No description provided for @kaesespaetzle.
  ///
  /// In en, this message translates to:
  /// **'Cheese Spaetzle'**
  String get kaesespaetzle;

  /// No description provided for @haehnchenSuessSauer.
  ///
  /// In en, this message translates to:
  /// **'Sweet and Sour Chicken'**
  String get haehnchenSuessSauer;

  /// No description provided for @gemueseLasagne.
  ///
  /// In en, this message translates to:
  /// **'Vegetable Lasagna'**
  String get gemueseLasagne;

  /// No description provided for @falafelTeller.
  ///
  /// In en, this message translates to:
  /// **'Falafel Plate'**
  String get falafelTeller;

  /// No description provided for @wienerSchnitzel.
  ///
  /// In en, this message translates to:
  /// **'Viennese Schnitzel'**
  String get wienerSchnitzel;

  /// No description provided for @pizzaMargherita.
  ///
  /// In en, this message translates to:
  /// **'Margherita Pizza'**
  String get pizzaMargherita;

  /// No description provided for @tofuPfanne.
  ///
  /// In en, this message translates to:
  /// **'Tofu Stir-fry'**
  String get tofuPfanne;

  /// No description provided for @rindergulasch.
  ///
  /// In en, this message translates to:
  /// **'Beef Goulash'**
  String get rindergulasch;

  /// No description provided for @vegetarian.
  ///
  /// In en, this message translates to:
  /// **'Vegetarian'**
  String get vegetarian;

  /// No description provided for @vegan.
  ///
  /// In en, this message translates to:
  /// **'Vegan'**
  String get vegan;

  /// No description provided for @withMeat.
  ///
  /// In en, this message translates to:
  /// **'With Meat'**
  String get withMeat;

  /// No description provided for @allReviewsTitle.
  ///
  /// In en, this message translates to:
  /// **'All Reviews'**
  String get allReviewsTitle;

  /// No description provided for @noReviewsAvailable.
  ///
  /// In en, this message translates to:
  /// **'No reviews available.'**
  String get noReviewsAvailable;

  /// No description provided for @reviewRating.
  ///
  /// In en, this message translates to:
  /// **'Review: {rating} stars'**
  String reviewRating(Object rating);

  /// No description provided for @foodName.
  ///
  /// In en, this message translates to:
  /// **'Food: {name}'**
  String foodName(Object name);

  /// No description provided for @createdBy.
  ///
  /// In en, this message translates to:
  /// **'Created by: {user}'**
  String createdBy(Object user);

  /// No description provided for @commentText.
  ///
  /// In en, this message translates to:
  /// **'Comment: {comment}'**
  String commentText(Object comment);

  /// No description provided for @editButton.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get editButton;

  /// No description provided for @deleteButton.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get deleteButton;

  /// No description provided for @deleteReviewTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Review'**
  String get deleteReviewTitle;

  /// No description provided for @deleteReviewContent.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this review?'**
  String get deleteReviewContent;

  /// No description provided for @cancelButton.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelButton;

  /// No description provided for @confirmDeleteButton.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get confirmDeleteButton;

  /// No description provided for @monday.
  ///
  /// In en, this message translates to:
  /// **'Monday'**
  String get monday;

  /// No description provided for @tuesday.
  ///
  /// In en, this message translates to:
  /// **'Tuesday'**
  String get tuesday;

  /// No description provided for @wednesday.
  ///
  /// In en, this message translates to:
  /// **'Wednesday'**
  String get wednesday;

  /// No description provided for @thursday.
  ///
  /// In en, this message translates to:
  /// **'Thursday'**
  String get thursday;

  /// No description provided for @friday.
  ///
  /// In en, this message translates to:
  /// **'Friday'**
  String get friday;

  /// No description provided for @essensplanTitle.
  ///
  /// In en, this message translates to:
  /// **'Weekly Plans'**
  String get essensplanTitle;

  /// No description provided for @filterByWeek.
  ///
  /// In en, this message translates to:
  /// **'Filter by week...'**
  String get filterByWeek;

  /// No description provided for @week.
  ///
  /// In en, this message translates to:
  /// **'Week'**
  String get week;

  /// No description provided for @addReviewTooltip.
  ///
  /// In en, this message translates to:
  /// **'Add review'**
  String get addReviewTooltip;

  /// No description provided for @addPlanTooltip.
  ///
  /// In en, this message translates to:
  /// **'Add weekly plan'**
  String get addPlanTooltip;

  /// No description provided for @editPlanButton.
  ///
  /// In en, this message translates to:
  /// **'Edit Plan'**
  String get editPlanButton;

  /// No description provided for @confirmDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirmation'**
  String get confirmDeleteTitle;

  /// No description provided for @confirmDeletePlanContent.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete the plan for week {weekNumber}?'**
  String confirmDeletePlanContent(Object weekNumber);

  /// No description provided for @speisekarteTitle.
  ///
  /// In en, this message translates to:
  /// **'Menu'**
  String get speisekarteTitle;

  /// No description provided for @addMealTooltip.
  ///
  /// In en, this message translates to:
  /// **'Add new meal'**
  String get addMealTooltip;

  /// No description provided for @confirmDeleteMealContent.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete \"{mealName}\"?'**
  String confirmDeleteMealContent(Object mealName);

  /// No description provided for @addMealTitle.
  ///
  /// In en, this message translates to:
  /// **'Add new Meal'**
  String get addMealTitle;

  /// No description provided for @editMealTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Meal'**
  String get editMealTitle;

  /// No description provided for @mealNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Name of the meal'**
  String get mealNameLabel;

  /// No description provided for @priceLabel.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get priceLabel;

  /// No description provided for @saveButton.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get saveButton;

  /// No description provided for @addPlanTitle.
  ///
  /// In en, this message translates to:
  /// **'Create New Weekly Plan'**
  String get addPlanTitle;

  /// No description provided for @editPlanTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Weekly Plan'**
  String get editPlanTitle;

  /// No description provided for @weekNumberLabel.
  ///
  /// In en, this message translates to:
  /// **'Week Number'**
  String get weekNumberLabel;

  /// No description provided for @selectedMealsLabel.
  ///
  /// In en, this message translates to:
  /// **'Selected Meals ({count}/5) - Adjust order:'**
  String selectedMealsLabel(Object count);

  /// No description provided for @availableMealsLabel.
  ///
  /// In en, this message translates to:
  /// **'Available meals to add:'**
  String get availableMealsLabel;

  /// No description provided for @editMealTooltip.
  ///
  /// In en, this message translates to:
  /// **'Edit meal'**
  String get editMealTooltip;

  /// No description provided for @removeMealFromPlanTooltip.
  ///
  /// In en, this message translates to:
  /// **'Remove meal from plan'**
  String get removeMealFromPlanTooltip;

  /// No description provided for @addMealToPlanTooltip.
  ///
  /// In en, this message translates to:
  /// **'Add meal to plan'**
  String get addMealToPlanTooltip;

  /// No description provided for @addReviewTitle.
  ///
  /// In en, this message translates to:
  /// **'Add Review'**
  String get addReviewTitle;

  /// No description provided for @editReviewTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Review'**
  String get editReviewTitle;

  /// No description provided for @loggedInAs.
  ///
  /// In en, this message translates to:
  /// **'Logged in as: {username}'**
  String loggedInAs(Object username);

  /// No description provided for @starsRating.
  ///
  /// In en, this message translates to:
  /// **'{count} Stars'**
  String starsRating(Object count);

  /// No description provided for @yourReviewLabel.
  ///
  /// In en, this message translates to:
  /// **'Your Review'**
  String get yourReviewLabel;

  /// No description provided for @takeAPhoto.
  ///
  /// In en, this message translates to:
  /// **'Take a photo'**
  String get takeAPhoto;

  /// No description provided for @photoOnlyOnMobile.
  ///
  /// In en, this message translates to:
  /// **'Taking photos is only available on mobile devices.'**
  String get photoOnlyOnMobile;

  /// No description provided for @cameraNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'Camera not available in simulator. Please test on a real device.'**
  String get cameraNotAvailable;

  /// No description provided for @reviewTextRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter a review text.'**
  String get reviewTextRequired;

  /// No description provided for @reviewBy.
  ///
  /// In en, this message translates to:
  /// **'Review by: {username}'**
  String reviewBy(Object username);

  /// No description provided for @manageMenuTitle.
  ///
  /// In en, this message translates to:
  /// **'Manage Menu'**
  String get manageMenuTitle;

  /// No description provided for @manageMenuSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Create, edit, and delete all available meals'**
  String get manageMenuSubtitle;

  /// No description provided for @weeklyPlansTitle.
  ///
  /// In en, this message translates to:
  /// **'Weekly Plans'**
  String get weeklyPlansTitle;

  /// No description provided for @weeklyPlansSubtitle.
  ///
  /// In en, this message translates to:
  /// **'View meal plans for the upcoming weeks'**
  String get weeklyPlansSubtitle;

  /// No description provided for @reviewsTitle.
  ///
  /// In en, this message translates to:
  /// **'Reviews'**
  String get reviewsTitle;

  /// No description provided for @reviewsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'View all submitted reviews'**
  String get reviewsSubtitle;

  /// No description provided for @loginSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Log in as an admin or user'**
  String get loginSubtitle;

  /// No description provided for @loggedInAsInfo.
  ///
  /// In en, this message translates to:
  /// **'Logged in as: {username} ({role})'**
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
  // Lookup logic when only language code is specified.
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

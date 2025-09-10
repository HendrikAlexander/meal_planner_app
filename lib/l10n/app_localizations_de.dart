// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Essensplaner App';

  @override
  String get login => 'Login';

  @override
  String get username => 'Benutzername';

  @override
  String get password => 'Passwort';

  @override
  String get selectRole => 'Rolle auswählen';

  @override
  String get adminRole => 'Admin';

  @override
  String get userRole => 'Benutzer';

  @override
  String get loginButton => 'Einloggen';

  @override
  String get continueAsGuest => 'Als Gast fortfahren';

  @override
  String get changeLanguage => 'Sprache ändern';

  @override
  String get spaghettiCarbonara => 'Spaghetti Carbonara';

  @override
  String get linsenCurry => 'Linsen-Curry';

  @override
  String get kaesespaetzle => 'Käsespätzle';

  @override
  String get haehnchenSuessSauer => 'Hähnchen süß-sauer';

  @override
  String get gemueseLasagne => 'Gemüse-Lasagne';

  @override
  String get falafelTeller => 'Falafel-Teller';

  @override
  String get wienerSchnitzel => 'Wiener Schnitzel';

  @override
  String get pizzaMargherita => 'Pizza Margherita';

  @override
  String get tofuPfanne => 'Tofu-Pfanne';

  @override
  String get rindergulasch => 'Rindergulasch';

  @override
  String get vegetarian => 'Vegetarisch';

  @override
  String get vegan => 'Vegan';

  @override
  String get withMeat => 'Mit Fleisch';

  @override
  String get allReviewsTitle => 'Alle Bewertungen';

  @override
  String get noReviewsAvailable => 'Keine Bewertungen vorhanden.';

  @override
  String reviewRating(Object rating) {
    return 'Bewertung: $rating Sterne';
  }

  @override
  String foodName(Object name) {
    return 'Essen: $name';
  }

  @override
  String createdBy(Object user) {
    return 'Erstellt von: $user';
  }

  @override
  String commentText(Object comment) {
    return 'Kommentar: $comment';
  }

  @override
  String get editButton => 'Bearbeiten';

  @override
  String get deleteButton => 'Löschen';

  @override
  String get deleteReviewTitle => 'Bewertung löschen';

  @override
  String get deleteReviewContent =>
      'Möchten Sie diese Bewertung wirklich löschen?';

  @override
  String get cancelButton => 'Abbrechen';

  @override
  String get confirmDeleteButton => 'Löschen';

  @override
  String get monday => 'Montag';

  @override
  String get tuesday => 'Dienstag';

  @override
  String get wednesday => 'Mittwoch';

  @override
  String get thursday => 'Donnerstag';

  @override
  String get friday => 'Freitag';

  @override
  String get essensplanTitle => 'Wochenpläne';

  @override
  String get filterByWeek => 'Nach Woche filtern...';

  @override
  String get week => 'Woche';

  @override
  String get addReviewTooltip => 'Bewertung abgeben';

  @override
  String get addPlanTooltip => 'Wochenplan hinzufügen';

  @override
  String get editPlanButton => 'Plan bearbeiten';

  @override
  String get confirmDeleteTitle => 'Bestätigung';

  @override
  String confirmDeletePlanContent(Object weekNumber) {
    return 'Möchten Sie den Plan für Woche $weekNumber wirklich löschen?';
  }

  @override
  String get speisekarteTitle => 'Speisekarte';

  @override
  String get addMealTooltip => 'Neues Essen hinzufügen';

  @override
  String confirmDeleteMealContent(Object mealName) {
    return 'Möchten Sie \"$mealName\" wirklich löschen?';
  }

  @override
  String get addMealTitle => 'Neues Essen anlegen';

  @override
  String get editMealTitle => 'Essen bearbeiten';

  @override
  String get mealNameLabel => 'Name des Gerichts';

  @override
  String get priceLabel => 'Preis';

  @override
  String get saveButton => 'Speichern';

  @override
  String get addPlanTitle => 'Neuen Wochenplan erstellen';

  @override
  String get editPlanTitle => 'Wochenplan bearbeiten';

  @override
  String get weekNumberLabel => 'Wochennummer';

  @override
  String selectedMealsLabel(Object count) {
    return 'Ausgewählte Gerichte ($count/5) - Reihenfolge anpassen:';
  }

  @override
  String get availableMealsLabel => 'Verfügbare Gerichte zum Hinzufügen:';

  @override
  String get editMealTooltip => 'Gericht bearbeiten';

  @override
  String get removeMealFromPlanTooltip => 'Gericht aus Plan entfernen';

  @override
  String get addMealToPlanTooltip => 'Gericht zum Plan hinzufügen';

  @override
  String get addReviewTitle => 'Bewertung abgeben';

  @override
  String get editReviewTitle => 'Bewertung bearbeiten';

  @override
  String loggedInAs(Object username) {
    return 'Eingeloggt als: $username';
  }

  @override
  String starsRating(Object count) {
    return '$count Sterne';
  }

  @override
  String get yourReviewLabel => 'Deine Bewertung';

  @override
  String get takeAPhoto => 'Foto aufnehmen';

  @override
  String get photoOnlyOnMobile =>
      'Fotoaufnahme ist nur auf mobilen Geräten verfügbar.';

  @override
  String get cameraNotAvailable =>
      'Kamera im Simulator nicht verfügbar. Bitte auf einem echten Gerät testen.';

  @override
  String get reviewTextRequired => 'Bitte geben Sie einen Bewertungstext ein.';

  @override
  String reviewBy(Object username) {
    return 'Bewertung von: $username';
  }

  @override
  String get manageMenuTitle => 'Speisekarte verwalten';

  @override
  String get manageMenuSubtitle =>
      'Alle verfügbaren Essen anlegen, bearbeiten und löschen';

  @override
  String get weeklyPlansTitle => 'Wochenpläne';

  @override
  String get weeklyPlansSubtitle =>
      'Essenspläne für die nächsten Wochen anzeigen';

  @override
  String get reviewsTitle => 'Bewertungen';

  @override
  String get reviewsSubtitle => 'Alle abgegebenen Bewertungen einsehen';

  @override
  String get loginSubtitle => 'Anmelden, als Admin oder Nutzer';

  @override
  String loggedInAsInfo(Object username, Object role) {
    return 'Angemeldet als: $username ($role)';
  }
}

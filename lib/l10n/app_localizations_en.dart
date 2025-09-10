// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Meal Planner App';

  @override
  String get login => 'Login';

  @override
  String get username => 'Username';

  @override
  String get password => 'Password';

  @override
  String get selectRole => 'Select Role';

  @override
  String get adminRole => 'Admin';

  @override
  String get userRole => 'User';

  @override
  String get loginButton => 'Login';

  @override
  String get continueAsGuest => 'Continue as Guest';

  @override
  String get changeLanguage => 'Change Language';

  @override
  String get spaghettiCarbonara => 'Spaghetti Carbonara';

  @override
  String get linsenCurry => 'Lentil Curry';

  @override
  String get kaesespaetzle => 'Cheese Spaetzle';

  @override
  String get haehnchenSuessSauer => 'Sweet and Sour Chicken';

  @override
  String get gemueseLasagne => 'Vegetable Lasagna';

  @override
  String get falafelTeller => 'Falafel Plate';

  @override
  String get wienerSchnitzel => 'Viennese Schnitzel';

  @override
  String get pizzaMargherita => 'Margherita Pizza';

  @override
  String get tofuPfanne => 'Tofu Stir-fry';

  @override
  String get rindergulasch => 'Beef Goulash';

  @override
  String get vegetarian => 'Vegetarian';

  @override
  String get vegan => 'Vegan';

  @override
  String get withMeat => 'With Meat';

  @override
  String get allReviewsTitle => 'All Reviews';

  @override
  String get noReviewsAvailable => 'No reviews available.';

  @override
  String reviewRating(Object rating) {
    return 'Review: $rating stars';
  }

  @override
  String foodName(Object name) {
    return 'Food: $name';
  }

  @override
  String createdBy(Object user) {
    return 'Created by: $user';
  }

  @override
  String commentText(Object comment) {
    return 'Comment: $comment';
  }

  @override
  String get editButton => 'Edit';

  @override
  String get deleteButton => 'Delete';

  @override
  String get deleteReviewTitle => 'Delete Review';

  @override
  String get deleteReviewContent =>
      'Are you sure you want to delete this review?';

  @override
  String get cancelButton => 'Cancel';

  @override
  String get confirmDeleteButton => 'Delete';

  @override
  String get monday => 'Monday';

  @override
  String get tuesday => 'Tuesday';

  @override
  String get wednesday => 'Wednesday';

  @override
  String get thursday => 'Thursday';

  @override
  String get friday => 'Friday';

  @override
  String get essensplanTitle => 'Weekly Plans';

  @override
  String get filterByWeek => 'Filter by week...';

  @override
  String get week => 'Week';

  @override
  String get addReviewTooltip => 'Add review';

  @override
  String get addPlanTooltip => 'Add weekly plan';

  @override
  String get editPlanButton => 'Edit Plan';

  @override
  String get confirmDeleteTitle => 'Confirmation';

  @override
  String confirmDeletePlanContent(Object weekNumber) {
    return 'Are you sure you want to delete the plan for week $weekNumber?';
  }

  @override
  String get speisekarteTitle => 'Menu';

  @override
  String get addMealTooltip => 'Add new meal';

  @override
  String confirmDeleteMealContent(Object mealName) {
    return 'Are you sure you want to delete \"$mealName\"?';
  }

  @override
  String get addMealTitle => 'Add new Meal';

  @override
  String get editMealTitle => 'Edit Meal';

  @override
  String get mealNameLabel => 'Name of the meal';

  @override
  String get priceLabel => 'Price';

  @override
  String get saveButton => 'Save';

  @override
  String get addPlanTitle => 'Create New Weekly Plan';

  @override
  String get editPlanTitle => 'Edit Weekly Plan';

  @override
  String get weekNumberLabel => 'Week Number';

  @override
  String selectedMealsLabel(Object count) {
    return 'Selected Meals ($count/5) - Adjust order:';
  }

  @override
  String get availableMealsLabel => 'Available meals to add:';

  @override
  String get editMealTooltip => 'Edit meal';

  @override
  String get removeMealFromPlanTooltip => 'Remove meal from plan';

  @override
  String get addMealToPlanTooltip => 'Add meal to plan';

  @override
  String get addReviewTitle => 'Add Review';

  @override
  String get editReviewTitle => 'Edit Review';

  @override
  String loggedInAs(Object username) {
    return 'Logged in as: $username';
  }

  @override
  String starsRating(Object count) {
    return '$count Stars';
  }

  @override
  String get yourReviewLabel => 'Your Review';

  @override
  String get takeAPhoto => 'Take a photo';

  @override
  String get photoOnlyOnMobile =>
      'Taking photos is only available on mobile devices.';

  @override
  String get cameraNotAvailable =>
      'Camera not available in simulator. Please test on a real device.';

  @override
  String get reviewTextRequired => 'Please enter a review text.';

  @override
  String reviewBy(Object username) {
    return 'Review by: $username';
  }

  @override
  String get manageMenuTitle => 'Manage Menu';

  @override
  String get manageMenuSubtitle =>
      'Create, edit, and delete all available meals';

  @override
  String get weeklyPlansTitle => 'Weekly Plans';

  @override
  String get weeklyPlansSubtitle => 'View meal plans for the upcoming weeks';

  @override
  String get reviewsTitle => 'Reviews';

  @override
  String get reviewsSubtitle => 'View all submitted reviews';

  @override
  String get loginSubtitle => 'Log in as an admin or user';

  @override
  String loggedInAsInfo(Object username, Object role) {
    return 'Logged in as: $username ($role)';
  }
}

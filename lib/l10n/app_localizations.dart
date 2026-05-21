import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

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
    Locale('ar'),
    Locale('en'),
    Locale('fr'),
  ];

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @personalInformation.
  ///
  /// In en, this message translates to:
  /// **'Personal Information'**
  String get personalInformation;

  /// No description provided for @preference.
  ///
  /// In en, this message translates to:
  /// **'Preference'**
  String get preference;

  /// No description provided for @favouritePlaces.
  ///
  /// In en, this message translates to:
  /// **'Favourite Places'**
  String get favouritePlaces;

  /// No description provided for @others.
  ///
  /// In en, this message translates to:
  /// **'Others'**
  String get others;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @termsOfUse.
  ///
  /// In en, this message translates to:
  /// **'Terms of Use'**
  String get termsOfUse;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get logout;

  /// No description provided for @guestUser.
  ///
  /// In en, this message translates to:
  /// **'Guest User'**
  String get guestUser;

  /// No description provided for @noEmail.
  ///
  /// In en, this message translates to:
  /// **'No email'**
  String get noEmail;

  /// No description provided for @arabic.
  ///
  /// In en, this message translates to:
  /// **'العربية'**
  String get arabic;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @french.
  ///
  /// In en, this message translates to:
  /// **'Français'**
  String get french;

  /// No description provided for @touristAssistant.
  ///
  /// In en, this message translates to:
  /// **'Tourist Assistant'**
  String get touristAssistant;

  /// No description provided for @discoverTouristPlaces.
  ///
  /// In en, this message translates to:
  /// **'Discover Tourist Places'**
  String get discoverTouristPlaces;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @touristPlaces.
  ///
  /// In en, this message translates to:
  /// **'Tourist Places'**
  String get touristPlaces;

  /// No description provided for @services.
  ///
  /// In en, this message translates to:
  /// **'Services'**
  String get services;

  /// No description provided for @helper.
  ///
  /// In en, this message translates to:
  /// **'Helper'**
  String get helper;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @aboutThisExperience.
  ///
  /// In en, this message translates to:
  /// **'About This Experience'**
  String get aboutThisExperience;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @filter.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filter;

  /// No description provided for @budget.
  ///
  /// In en, this message translates to:
  /// **'Budget'**
  String get budget;

  /// No description provided for @selectDate.
  ///
  /// In en, this message translates to:
  /// **'Select Date'**
  String get selectDate;

  /// No description provided for @selectTime.
  ///
  /// In en, this message translates to:
  /// **'Select Time'**
  String get selectTime;

  /// No description provided for @ratingsAndReviews.
  ///
  /// In en, this message translates to:
  /// **'Ratings & Reviews'**
  String get ratingsAndReviews;

  /// No description provided for @noFavoritePlacesYet.
  ///
  /// In en, this message translates to:
  /// **'No favorite places yet'**
  String get noFavoritePlacesYet;

  /// No description provided for @emailAddress.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get emailAddress;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @firstName.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get firstName;

  /// No description provided for @lastName.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get lastName;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// No description provided for @reWritePassword.
  ///
  /// In en, this message translates to:
  /// **'Re-write password'**
  String get reWritePassword;

  /// No description provided for @noPlacesAvailable.
  ///
  /// In en, this message translates to:
  /// **'No places available right now'**
  String get noPlacesAvailable;

  /// No description provided for @wanderPlaces.
  ///
  /// In en, this message translates to:
  /// **'Wander Places'**
  String get wanderPlaces;

  /// No description provided for @couldNotOpenBookingLink.
  ///
  /// In en, this message translates to:
  /// **'Could not open the booking link'**
  String get couldNotOpenBookingLink;

  /// No description provided for @exploreDestinations.
  ///
  /// In en, this message translates to:
  /// **'Explore the most beautiful destinations in Egypt'**
  String get exploreDestinations;

  /// No description provided for @creatingAccount.
  ///
  /// In en, this message translates to:
  /// **'Creating account...'**
  String get creatingAccount;

  /// No description provided for @registrationSuccessful.
  ///
  /// In en, this message translates to:
  /// **'Registration successful.'**
  String get registrationSuccessful;

  /// No description provided for @alreadyHaveAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAnAccount;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get signUp;

  /// No description provided for @signingIn.
  ///
  /// In en, this message translates to:
  /// **'Signing in...'**
  String get signingIn;

  /// No description provided for @loginSuccessful.
  ///
  /// In en, this message translates to:
  /// **'Login Successful'**
  String get loginSuccessful;

  /// No description provided for @beginYourJourney.
  ///
  /// In en, this message translates to:
  /// **'Begin Your Journey'**
  String get beginYourJourney;

  /// No description provided for @emailIsRequired.
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get emailIsRequired;

  /// No description provided for @pleaseEnterValidEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email'**
  String get pleaseEnterValidEmail;

  /// No description provided for @passwordIsRequired.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get passwordIsRequired;

  /// No description provided for @pleaseWait.
  ///
  /// In en, this message translates to:
  /// **'Please wait'**
  String get pleaseWait;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// No description provided for @dontHaveAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get dontHaveAnAccount;

  /// No description provided for @registerNow.
  ///
  /// In en, this message translates to:
  /// **'Register now'**
  String get registerNow;

  /// No description provided for @askMeAboutTourism.
  ///
  /// In en, this message translates to:
  /// **'Ask me about Tourism'**
  String get askMeAboutTourism;

  /// No description provided for @typeYourMessage.
  ///
  /// In en, this message translates to:
  /// **'Type your message'**
  String get typeYourMessage;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// No description provided for @bookService.
  ///
  /// In en, this message translates to:
  /// **'Book Service'**
  String get bookService;

  /// No description provided for @resetAll.
  ///
  /// In en, this message translates to:
  /// **'Reset All'**
  String get resetAll;

  /// No description provided for @failedToLoadReviews.
  ///
  /// In en, this message translates to:
  /// **'Failed to load reviews'**
  String get failedToLoadReviews;

  /// No description provided for @anErrorOccurred.
  ///
  /// In en, this message translates to:
  /// **'An error occurred'**
  String get anErrorOccurred;

  /// No description provided for @noResultsFound.
  ///
  /// In en, this message translates to:
  /// **'No results found'**
  String get noResultsFound;

  /// No description provided for @tryAdjustingYourFilters.
  ///
  /// In en, this message translates to:
  /// **'Try adjusting your filters'**
  String get tryAdjustingYourFilters;

  /// No description provided for @authScreen.
  ///
  /// In en, this message translates to:
  /// **'Authentication'**
  String get authScreen;

  /// No description provided for @drawerMenu.
  ///
  /// In en, this message translates to:
  /// **'Menu'**
  String get drawerMenu;

  /// No description provided for @homeAppbar.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get homeAppbar;

  /// No description provided for @emergencySheetContent.
  ///
  /// In en, this message translates to:
  /// **'Emergency'**
  String get emergencySheetContent;

  /// No description provided for @welcomeAssistantMessage.
  ///
  /// In en, this message translates to:
  /// **'Welcome! I am your Egypt Tourism Assistant. Ask me about places, itineraries, costs, and transport.'**
  String get welcomeAssistantMessage;

  /// No description provided for @online.
  ///
  /// In en, this message translates to:
  /// **'online'**
  String get online;

  /// No description provided for @discoverEgypt.
  ///
  /// In en, this message translates to:
  /// **'Discover egypt'**
  String get discoverEgypt;

  /// No description provided for @tourismPoliceEmergency.
  ///
  /// In en, this message translates to:
  /// **'Tourism Police Number: 126\nAvailable 24 hours for tourist emergency assistance'**
  String get tourismPoliceEmergency;

  /// No description provided for @callNow.
  ///
  /// In en, this message translates to:
  /// **'Call Now'**
  String get callNow;

  /// No description provided for @callTourismPoliceInSeconds.
  ///
  /// In en, this message translates to:
  /// **'A call will be made to Tourism Police in {counter} seconds'**
  String callTourismPoliceInSeconds(Object counter);

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @viewOnMap.
  ///
  /// In en, this message translates to:
  /// **'view on map'**
  String get viewOnMap;

  /// No description provided for @distinctiveTourismServices.
  ///
  /// In en, this message translates to:
  /// **'Distinctive tourism services'**
  String get distinctiveTourismServices;

  /// No description provided for @bookGuidesPhotographersAndTours.
  ///
  /// In en, this message translates to:
  /// **'Book guides, photographers, and tours'**
  String get bookGuidesPhotographersAndTours;

  /// No description provided for @loadingPage.
  ///
  /// In en, this message translates to:
  /// **'Loading page {pageNumber}...'**
  String loadingPage(Object pageNumber);

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @sortBy.
  ///
  /// In en, this message translates to:
  /// **'sort by'**
  String get sortBy;

  /// No description provided for @book.
  ///
  /// In en, this message translates to:
  /// **'book'**
  String get book;

  /// No description provided for @evaluatePage.
  ///
  /// In en, this message translates to:
  /// **'evaluate page {current} of {total}'**
  String evaluatePage(Object current, Object total);

  /// No description provided for @startYourTravelJourney.
  ///
  /// In en, this message translates to:
  /// **'Start your travel journey with exclusive tips, guides, and offers.'**
  String get startYourTravelJourney;

  /// No description provided for @letsGetStarted.
  ///
  /// In en, this message translates to:
  /// **'Let’s get started!'**
  String get letsGetStarted;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @signUpAction.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUpAction;

  /// No description provided for @updateProfile.
  ///
  /// In en, this message translates to:
  /// **'update profile'**
  String get updateProfile;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'full name'**
  String get fullName;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'confirm password'**
  String get confirmPassword;

  /// No description provided for @applyFilters.
  ///
  /// In en, this message translates to:
  /// **'Apply Filters'**
  String get applyFilters;

  /// No description provided for @newest.
  ///
  /// In en, this message translates to:
  /// **'Newest'**
  String get newest;

  /// No description provided for @priceLowToHigh.
  ///
  /// In en, this message translates to:
  /// **'Price: Low to High'**
  String get priceLowToHigh;

  /// No description provided for @priceHighToLow.
  ///
  /// In en, this message translates to:
  /// **'Price: High to Low'**
  String get priceHighToLow;

  /// No description provided for @alphabetical.
  ///
  /// In en, this message translates to:
  /// **'Alphabetical'**
  String get alphabetical;

  /// No description provided for @loadingLocations.
  ///
  /// In en, this message translates to:
  /// **'Loading locations...'**
  String get loadingLocations;

  /// No description provided for @noLocationsAvailable.
  ///
  /// In en, this message translates to:
  /// **'No locations available'**
  String get noLocationsAvailable;

  /// No description provided for @linkNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'Link is not available for this package yet.'**
  String get linkNotAvailable;

  /// No description provided for @pageOf.
  ///
  /// In en, this message translates to:
  /// **'Page {current} of {total}'**
  String pageOf(Object current, Object total);

  /// No description provided for @loadingServices.
  ///
  /// In en, this message translates to:
  /// **'Loading services...'**
  String get loadingServices;

  /// No description provided for @evaluate.
  ///
  /// In en, this message translates to:
  /// **'evaluate'**
  String get evaluate;

  /// No description provided for @rateService.
  ///
  /// In en, this message translates to:
  /// **'Rate Service'**
  String get rateService;

  /// No description provided for @chooseYourRating.
  ///
  /// In en, this message translates to:
  /// **'Choose your rating'**
  String get chooseYourRating;

  /// No description provided for @notesOptional.
  ///
  /// In en, this message translates to:
  /// **'Notes (Optional)'**
  String get notesOptional;

  /// No description provided for @shareExperience.
  ///
  /// In en, this message translates to:
  /// **'Share your experience with this service'**
  String get shareExperience;

  /// No description provided for @submitReview.
  ///
  /// In en, this message translates to:
  /// **'Submit Review'**
  String get submitReview;

  /// No description provided for @reviewsTitle.
  ///
  /// In en, this message translates to:
  /// **'Reviews'**
  String get reviewsTitle;

  /// No description provided for @perPerson.
  ///
  /// In en, this message translates to:
  /// **'per person'**
  String get perPerson;

  /// No description provided for @whatsIncluded.
  ///
  /// In en, this message translates to:
  /// **'What\'s Included'**
  String get whatsIncluded;

  /// No description provided for @bookNow.
  ///
  /// In en, this message translates to:
  /// **'Book now'**
  String get bookNow;

  /// No description provided for @noIncludedItemsYet.
  ///
  /// In en, this message translates to:
  /// **'No included items provided yet'**
  String get noIncludedItemsYet;

  /// No description provided for @failedToLoadPackageDetails.
  ///
  /// In en, this message translates to:
  /// **'Failed to load package details'**
  String get failedToLoadPackageDetails;

  /// No description provided for @addedToFavorites.
  ///
  /// In en, this message translates to:
  /// **'Added to favorites'**
  String get addedToFavorites;

  /// No description provided for @removedFromFavorites.
  ///
  /// In en, this message translates to:
  /// **'Removed from favorites'**
  String get removedFromFavorites;

  /// No description provided for @favoriteUpdateFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not update favorite status'**
  String get favoriteUpdateFailed;

  /// No description provided for @typing.
  ///
  /// In en, this message translates to:
  /// **'Typing...'**
  String get typing;

  /// No description provided for @failedToLoadFavorites.
  ///
  /// In en, this message translates to:
  /// **'Failed to load favorites'**
  String get failedToLoadFavorites;

  /// No description provided for @noDescriptionAvailable.
  ///
  /// In en, this message translates to:
  /// **'No description available'**
  String get noDescriptionAvailable;

  /// No description provided for @nameEmailPhoneRequired.
  ///
  /// In en, this message translates to:
  /// **'Name, email and phone are required'**
  String get nameEmailPhoneRequired;

  /// No description provided for @passwordMinLength.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters'**
  String get passwordMinLength;

  /// No description provided for @passwordConfirmationMismatch.
  ///
  /// In en, this message translates to:
  /// **'Password confirmation does not match'**
  String get passwordConfirmationMismatch;

  /// No description provided for @updating.
  ///
  /// In en, this message translates to:
  /// **'Updating...'**
  String get updating;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// No description provided for @privacyInfoCollectTitle.
  ///
  /// In en, this message translates to:
  /// **'Information We Collect'**
  String get privacyInfoCollectTitle;

  /// No description provided for @privacyInfoCollectDescription.
  ///
  /// In en, this message translates to:
  /// **'We collect information that you provide directly to us when using the Tourism App, including:'**
  String get privacyInfoCollectDescription;

  /// No description provided for @privacyInfoCollectBullets.
  ///
  /// In en, this message translates to:
  /// **'Personal information (name, email address, phone number)\nLocation data to provide relevant tourist recommendations\nBooking history and preferences\nPayment information (processed securely through third-party providers)\nPhotos and reviews you share about your experiences'**
  String get privacyInfoCollectBullets;

  /// No description provided for @privacyUseInfoTitle.
  ///
  /// In en, this message translates to:
  /// **'How We Use Your Information'**
  String get privacyUseInfoTitle;

  /// No description provided for @privacyUseInfoDescription.
  ///
  /// In en, this message translates to:
  /// **'Your information helps us provide and improve our services:'**
  String get privacyUseInfoDescription;

  /// No description provided for @privacyUseInfoBullets.
  ///
  /// In en, this message translates to:
  /// **'Process bookings and payments for tours, guides, and services\nSend booking confirmations and important updates\nProvide personalized recommendations based on your preferences\nImprove our services and develop new features\nCommunicate with you about promotions and special offers\nEnsure safety through our emergency contact features'**
  String get privacyUseInfoBullets;

  /// No description provided for @privacyDataSecurityTitle.
  ///
  /// In en, this message translates to:
  /// **'Data Security'**
  String get privacyDataSecurityTitle;

  /// No description provided for @privacyDataSecurityDescription.
  ///
  /// In en, this message translates to:
  /// **'We take the security of your personal information seriously:'**
  String get privacyDataSecurityDescription;

  /// No description provided for @privacyDataSecurityBullets.
  ///
  /// In en, this message translates to:
  /// **'All data is encrypted using industry-standard SSL/TLS protocols\nPayment information is processed through PCI-compliant providers\nAccess to personal data is restricted to authorized personnel only\nRegular security audits and updates to protect against threats\nSecure backup systems to prevent data loss'**
  String get privacyDataSecurityBullets;

  /// No description provided for @privacyInfoSharingTitle.
  ///
  /// In en, this message translates to:
  /// **'Information Sharing'**
  String get privacyInfoSharingTitle;

  /// No description provided for @privacyInfoSharingDescription.
  ///
  /// In en, this message translates to:
  /// **'We do not sell your personal information. We may share data with:'**
  String get privacyInfoSharingDescription;

  /// No description provided for @privacyInfoSharingBullets.
  ///
  /// In en, this message translates to:
  /// **'Service providers (tour guides, photographers) to fulfill your bookings\nPayment processors to complete transactions securely\nLaw enforcement when required by law or to protect safety\nAnalytics partners to improve our services (anonymized data only)'**
  String get privacyInfoSharingBullets;

  /// No description provided for @privacyCookiesTitle.
  ///
  /// In en, this message translates to:
  /// **'Cookies and Tracking'**
  String get privacyCookiesTitle;

  /// No description provided for @privacyCookiesDescription.
  ///
  /// In en, this message translates to:
  /// **'We use cookies and similar technologies to enhance your experience, analyze usage patterns, and remember your preferences.'**
  String get privacyCookiesDescription;

  /// No description provided for @privacyChildrenTitle.
  ///
  /// In en, this message translates to:
  /// **'Children\'s Privacy'**
  String get privacyChildrenTitle;

  /// No description provided for @privacyChildrenDescription.
  ///
  /// In en, this message translates to:
  /// **'Our services are not intended for children under 13.'**
  String get privacyChildrenDescription;

  /// No description provided for @privacyContactTitle.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get privacyContactTitle;

  /// No description provided for @privacyContactDescription.
  ///
  /// In en, this message translates to:
  /// **'If you have questions about this Privacy Policy, please contact us:'**
  String get privacyContactDescription;

  /// No description provided for @termsAcceptanceTitle.
  ///
  /// In en, this message translates to:
  /// **'Acceptance of Terms'**
  String get termsAcceptanceTitle;

  /// No description provided for @termsAcceptanceDescription.
  ///
  /// In en, this message translates to:
  /// **'By using the Tourism App, you agree to these Terms of Use.'**
  String get termsAcceptanceDescription;

  /// No description provided for @termsUseServicesTitle.
  ///
  /// In en, this message translates to:
  /// **'Use of Services'**
  String get termsUseServicesTitle;

  /// No description provided for @termsUseServicesDescription.
  ///
  /// In en, this message translates to:
  /// **'You agree to use our services lawfully and according to these terms:'**
  String get termsUseServicesDescription;

  /// No description provided for @termsUseServicesBullets.
  ///
  /// In en, this message translates to:
  /// **'You must be at least 18 years old to make bookings\nYou are responsible for your account confidentiality\nYou must provide accurate information\nNo illegal or unauthorized use\nNo malware or harmful code\nDo not interfere with service operations'**
  String get termsUseServicesBullets;

  /// No description provided for @termsBookingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Bookings and Payments'**
  String get termsBookingsTitle;

  /// No description provided for @termsBookingsDescription.
  ///
  /// In en, this message translates to:
  /// **'When making a booking through our app:'**
  String get termsBookingsDescription;

  /// No description provided for @termsBookingsBullets.
  ///
  /// In en, this message translates to:
  /// **'All bookings are subject to availability and confirmation\nPrices are shown in USD and may change\nPayment must be completed at booking time\nYou are responsible for bank or transaction fees\nRefunds follow each provider’s cancellation policy\nWe may cancel bookings in exceptional cases'**
  String get termsBookingsBullets;

  /// No description provided for @termsCancellationTitle.
  ///
  /// In en, this message translates to:
  /// **'Cancellation Policy'**
  String get termsCancellationTitle;

  /// No description provided for @termsCancellationDescription.
  ///
  /// In en, this message translates to:
  /// **'Our cancellation policy varies by service:'**
  String get termsCancellationDescription;

  /// No description provided for @termsCancellationBullets.
  ///
  /// In en, this message translates to:
  /// **'Tour Guides & Photographers: cancel up to 24h for full refund\nDay Trips: cancel up to 48h for full refund\nMulti-day Trips: cancel up to 7 days for full refund\nLate cancellations may include fees\nNo-shows are non-refundable'**
  String get termsCancellationBullets;

  /// No description provided for @termsUserContentTitle.
  ///
  /// In en, this message translates to:
  /// **'User-Generated Content'**
  String get termsUserContentTitle;

  /// No description provided for @termsUserContentDescription.
  ///
  /// In en, this message translates to:
  /// **'When you post reviews, photos, or other content:'**
  String get termsUserContentDescription;

  /// No description provided for @termsUserContentBullets.
  ///
  /// In en, this message translates to:
  /// **'You grant us a license to use your content\nYou confirm content ownership rights\nContent must not be offensive or infringing\nWe may remove inappropriate content\nYou are responsible for review accuracy'**
  String get termsUserContentBullets;

  /// No description provided for @termsIntellectualTitle.
  ///
  /// In en, this message translates to:
  /// **'Intellectual Property Rights'**
  String get termsIntellectualTitle;

  /// No description provided for @termsIntellectualDescription.
  ///
  /// In en, this message translates to:
  /// **'All app content is protected by intellectual property laws.'**
  String get termsIntellectualDescription;

  /// No description provided for @termsEmergencyTitle.
  ///
  /// In en, this message translates to:
  /// **'Emergency Services Disclaimer'**
  String get termsEmergencyTitle;

  /// No description provided for @termsEmergencyDescription.
  ///
  /// In en, this message translates to:
  /// **'Our emergency feature is for convenience. In real emergencies:'**
  String get termsEmergencyDescription;

  /// No description provided for @termsEmergencyBullets.
  ///
  /// In en, this message translates to:
  /// **'Call local emergency services directly\nFeature connects to tourist police, not medical emergency\nWe are not responsible for authority response times'**
  String get termsEmergencyBullets;

  /// No description provided for @termsChangesTitle.
  ///
  /// In en, this message translates to:
  /// **'Changes to Terms'**
  String get termsChangesTitle;

  /// No description provided for @termsChangesDescription.
  ///
  /// In en, this message translates to:
  /// **'We may modify these terms at any time.'**
  String get termsChangesDescription;

  /// No description provided for @termsGoverningTitle.
  ///
  /// In en, this message translates to:
  /// **'Governing Law'**
  String get termsGoverningTitle;

  /// No description provided for @termsGoverningDescription.
  ///
  /// In en, this message translates to:
  /// **'These terms are governed by the laws of Egypt.'**
  String get termsGoverningDescription;

  /// No description provided for @allBookings.
  ///
  /// In en, this message translates to:
  /// **'All Bookings'**
  String get allBookings;

  /// No description provided for @cancelBooking.
  ///
  /// In en, this message translates to:
  /// **'Cancel Booking'**
  String get cancelBooking;

  /// No description provided for @firstNameRequired.
  ///
  /// In en, this message translates to:
  /// **'First name is required'**
  String get firstNameRequired;

  /// No description provided for @lastNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Last name is required'**
  String get lastNameRequired;

  /// No description provided for @lastNameMinLength.
  ///
  /// In en, this message translates to:
  /// **'Last name must be at least 2 characters'**
  String get lastNameMinLength;

  /// No description provided for @phoneNumberRequired.
  ///
  /// In en, this message translates to:
  /// **'Phone number is required'**
  String get phoneNumberRequired;

  /// No description provided for @passwordMinLengthSix.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get passwordMinLengthSix;

  /// No description provided for @passwordConfirmationRequired.
  ///
  /// In en, this message translates to:
  /// **'Password confirmation is required'**
  String get passwordConfirmationRequired;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Please make sure your passwords match'**
  String get passwordsDoNotMatch;

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'tourism app'**
  String get appTitle;

  /// No description provided for @profileUpdatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Profile updated successfully'**
  String get profileUpdatedSuccessfully;
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
      <String>['ar', 'en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}

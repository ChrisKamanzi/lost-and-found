import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_rw.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
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
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fr'),
    Locale('rw')
  ];

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @french.
  ///
  /// In en, this message translates to:
  /// **'French'**
  String get french;

  /// No description provided for @kinyarwanda.
  ///
  /// In en, this message translates to:
  /// **'KinyaRwanda'**
  String get kinyarwanda;

  /// No description provided for @loginTitle.
  ///
  /// In en, this message translates to:
  /// **'Log In.'**
  String get loginTitle;

  /// No description provided for @emailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailLabel;

  /// No description provided for @passwordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordLabel;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password'**
  String get forgotPassword;

  /// No description provided for @loginButton.
  ///
  /// In en, this message translates to:
  /// **'Log In'**
  String get loginButton;

  /// No description provided for @noAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get noAccount;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// No description provided for @signUpTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign Up.'**
  String get signUpTitle;

  /// No description provided for @nameLabel.
  ///
  /// In en, this message translates to:
  /// **'NAME'**
  String get nameLabel;

  /// No description provided for @passwordConfirmationLabel.
  ///
  /// In en, this message translates to:
  /// **'PASSWORD CONFIRMATION'**
  String get passwordConfirmationLabel;

  /// No description provided for @phoneLabel.
  ///
  /// In en, this message translates to:
  /// **'PHONE'**
  String get phoneLabel;

  /// No description provided for @villageLabel.
  ///
  /// In en, this message translates to:
  /// **'VILLAGE'**
  String get villageLabel;

  /// No description provided for @selectVillage.
  ///
  /// In en, this message translates to:
  /// **'Select a Village'**
  String get selectVillage;

  /// No description provided for @signUpButton.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUpButton;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccount;

  /// No description provided for @resetPassword.
  ///
  /// In en, this message translates to:
  /// **'reset password'**
  String get resetPassword;

  /// No description provided for @reportFoundTitle.
  ///
  /// In en, this message translates to:
  /// **'Report Found'**
  String get reportFoundTitle;

  /// No description provided for @reportFoundDescription.
  ///
  /// In en, this message translates to:
  /// **'An item lost and found can easily be reported or an ad could be created'**
  String get reportFoundDescription;

  /// No description provided for @searchMapTitle.
  ///
  /// In en, this message translates to:
  /// **'Search Map'**
  String get searchMapTitle;

  /// No description provided for @searchMapDescription.
  ///
  /// In en, this message translates to:
  /// **'Search for found items or found close to your location be showed on the map'**
  String get searchMapDescription;

  /// No description provided for @messagingTitle.
  ///
  /// In en, this message translates to:
  /// **'Messaging'**
  String get messagingTitle;

  /// No description provided for @messagingDescription.
  ///
  /// In en, this message translates to:
  /// **'last app allows interaction between users'**
  String get messagingDescription;

  /// No description provided for @aboutUsAppBarTitle.
  ///
  /// In en, this message translates to:
  /// **'About Us'**
  String get aboutUsAppBarTitle;

  /// No description provided for @aboutUsHeading.
  ///
  /// In en, this message translates to:
  /// **'ABOUT US'**
  String get aboutUsHeading;

  /// No description provided for @aboutUsDescription.
  ///
  /// In en, this message translates to:
  /// **'We believe in the power of community and compassion. Our platform connects people who have lost valuable items with those who’ve found them — making it easier than ever to reunite lost belongings with their rightful owners.'**
  String get aboutUsDescription;

  /// No description provided for @aboutUsFeaturesTitle.
  ///
  /// In en, this message translates to:
  /// **'FEATURES'**
  String get aboutUsFeaturesTitle;

  /// No description provided for @hello.
  ///
  /// In en, this message translates to:
  /// **'Hello'**
  String get hello;

  /// No description provided for @homeCreateAdvert.
  ///
  /// In en, this message translates to:
  /// **'Create an advert'**
  String get homeCreateAdvert;

  /// No description provided for @homeCreateDetail.
  ///
  /// In en, this message translates to:
  /// **' Report if you find or lost an item'**
  String get homeCreateDetail;

  /// No description provided for @homeLostFOund.
  ///
  /// In en, this message translates to:
  /// **'Losst \$ found items'**
  String get homeLostFOund;

  /// No description provided for @homeLostFoundDetail.
  ///
  /// In en, this message translates to:
  /// **' Go through the lost and'**
  String get homeLostFoundDetail;

  /// No description provided for @homeLostFoundDetailfound.
  ///
  /// In en, this message translates to:
  /// **'found items '**
  String get homeLostFoundDetailfound;

  /// No description provided for @homeSearch.
  ///
  /// In en, this message translates to:
  /// **'Search on Map'**
  String get homeSearch;

  /// No description provided for @homeSearchdetail.
  ///
  /// In en, this message translates to:
  /// **'Search for lost found Items on locations near you'**
  String get homeSearchdetail;

  /// No description provided for @homeSearchDetailNear.
  ///
  /// In en, this message translates to:
  /// **'near you'**
  String get homeSearchDetailNear;

  /// No description provided for @loadingName.
  ///
  /// In en, this message translates to:
  /// **'Loading name...'**
  String get loadingName;

  /// No description provided for @loadingPhone.
  ///
  /// In en, this message translates to:
  /// **'Loading phone...'**
  String get loadingPhone;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @favorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get favorites;

  /// No description provided for @aboutUs.
  ///
  /// In en, this message translates to:
  /// **'About us'**
  String get aboutUs;

  /// No description provided for @messages.
  ///
  /// In en, this message translates to:
  /// **'Messages'**
  String get messages;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'LogOut'**
  String get logout;

  /// No description provided for @logoutFailed.
  ///
  /// In en, this message translates to:
  /// **'Logout failed on server.'**
  String get logoutFailed;

  /// No description provided for @logoutError.
  ///
  /// In en, this message translates to:
  /// **'Logout error: {error}'**
  String logoutError(Object error);

  /// No description provided for @myItems.
  ///
  /// In en, this message translates to:
  /// **'My items'**
  String get myItems;

  /// No description provided for @chat.
  ///
  /// In en, this message translates to:
  /// **' chat'**
  String get chat;

  /// No description provided for @map.
  ///
  /// In en, this message translates to:
  /// **'map'**
  String get map;

  /// No description provided for @additionalInfo.
  ///
  /// In en, this message translates to:
  /// **'Additional information'**
  String get additionalInfo;

  /// No description provided for @brand.
  ///
  /// In en, this message translates to:
  /// **'Brand'**
  String get brand;

  /// No description provided for @posted.
  ///
  /// In en, this message translates to:
  /// **'posted'**
  String get posted;

  /// No description provided for @adPostedby.
  ///
  /// In en, this message translates to:
  /// **'Posted BY'**
  String get adPostedby;

  /// No description provided for @sendMessage.
  ///
  /// In en, this message translates to:
  /// **'Send Message'**
  String get sendMessage;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'search'**
  String get search;

  /// No description provided for @moreInfo.
  ///
  /// In en, this message translates to:
  /// **'More Info'**
  String get moreInfo;

  /// No description provided for @typeMessage.
  ///
  /// In en, this message translates to:
  /// **'Type your message'**
  String get typeMessage;

  /// No description provided for @chooseLanguage.
  ///
  /// In en, this message translates to:
  /// **' Choose Language'**
  String get chooseLanguage;

  /// No description provided for @whatLanguage.
  ///
  /// In en, this message translates to:
  /// **'What language do you want to use ? '**
  String get whatLanguage;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get next;

  /// No description provided for @reportLostItem.
  ///
  /// In en, this message translates to:
  /// **'Report Lost Item'**
  String get reportLostItem;

  /// No description provided for @locateFoundItem.
  ///
  /// In en, this message translates to:
  /// **'Locate Found Item'**
  String get locateFoundItem;

  /// No description provided for @instantMessaging.
  ///
  /// In en, this message translates to:
  /// **'Instant Messaging'**
  String get instantMessaging;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'skip'**
  String get skip;

  /// No description provided for @create_ad.
  ///
  /// In en, this message translates to:
  /// **'Create ad'**
  String get create_ad;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @post_type.
  ///
  /// In en, this message translates to:
  /// **'Post Type'**
  String get post_type;

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get title;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @village.
  ///
  /// In en, this message translates to:
  /// **'Village'**
  String get village;

  /// No description provided for @upload_image.
  ///
  /// In en, this message translates to:
  /// **'Upload Image'**
  String get upload_image;

  /// No description provided for @no_image_selected.
  ///
  /// In en, this message translates to:
  /// **'No image selected'**
  String get no_image_selected;

  /// No description provided for @press_icon.
  ///
  /// In en, this message translates to:
  /// **'Press that Icon 👆'**
  String get press_icon;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @ad_success.
  ///
  /// In en, this message translates to:
  /// **'Ad successfully created!'**
  String get ad_success;

  /// No description provided for @error_generic.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get error_generic;

  /// No description provided for @please_Connect_to_Internet.
  ///
  /// In en, this message translates to:
  /// **'Please Connect to Internet'**
  String get please_Connect_to_Internet;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'fr', 'rw'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'fr': return AppLocalizationsFr();
    case 'rw': return AppLocalizationsRw();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}

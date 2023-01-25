// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Sangathan`
  String get sangathan {
    return Intl.message(
      'Sangathan',
      name: 'sangathan',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Enter your mobile number, we will send you OTP to verify later`
  String get enterYourMobileNumber {
    return Intl.message(
      'Enter your mobile number, we will send you OTP to verify later',
      name: 'enterYourMobileNumber',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get loginButtonText {
    return Intl.message(
      'Login',
      name: 'loginButtonText',
      desc: '',
      args: [],
    );
  }

  /// `OTP Verification`
  String get otpVerification {
    return Intl.message(
      'OTP Verification',
      name: 'otpVerification',
      desc: '',
      args: [],
    );
  }

  /// `Enter OTP`
  String get enterOTP {
    return Intl.message(
      'Enter OTP',
      name: 'enterOTP',
      desc: '',
      args: [],
    );
  }

  /// `6 digit code has been sent`
  String get digitCodeHasBeenSent {
    return Intl.message(
      '6 digit code has been sent',
      name: 'digitCodeHasBeenSent',
      desc: '',
      args: [],
    );
  }

  /// `Verified..`
  String get verified {
    return Intl.message(
      'Verified..',
      name: 'verified',
      desc: '',
      args: [],
    );
  }

  /// `Verify`
  String get verify {
    return Intl.message(
      'Verify',
      name: 'verify',
      desc: '',
      args: [],
    );
  }

  /// `Resend OTP`
  String get resendOTP {
    return Intl.message(
      'Resend OTP',
      name: 'resendOTP',
      desc: '',
      args: [],
    );
  }

  /// `Resend OTP code to `
  String get resendOTPCodeTo {
    return Intl.message(
      'Resend OTP code to ',
      name: 'resendOTPCodeTo',
      desc: '',
      args: [],
    );
  }

  /// `Login to get the programs and information related to the organization`
  String get loginToGetTheProgramsAndInformationRelatedToTheOrganization {
    return Intl.message(
      'Login to get the programs and information related to the organization',
      name: 'loginToGetTheProgramsAndInformationRelatedToTheOrganization',
      desc: '',
      args: [],
    );
  }

  /// `View Tours & Events`
  String get viewToursEvents {
    return Intl.message(
      'View Tours & Events',
      name: 'viewToursEvents',
      desc: '',
      args: [],
    );
  }

  /// `Click`
  String get click {
    return Intl.message(
      'Click',
      name: 'click',
      desc: '',
      args: [],
    );
  }

  /// `Total Travel So Far`
  String get totalTravelSoFar {
    return Intl.message(
      'Total Travel So Far',
      name: 'totalTravelSoFar',
      desc: '',
      args: [],
    );
  }

  /// `Upcoming Trip`
  String get upcomingTrip {
    return Intl.message(
      'Upcoming Trip',
      name: 'upcomingTrip',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get all {
    return Intl.message(
      'All',
      name: 'all',
      desc: '',
      args: [],
    );
  }

  /// `Present`
  String get present {
    return Intl.message(
      'Present',
      name: 'present',
      desc: '',
      args: [],
    );
  }

  /// `Upcoming`
  String get upcoming {
    return Intl.message(
      'Upcoming',
      name: 'upcoming',
      desc: '',
      args: [],
    );
  }

  /// `Program`
  String get program {
    return Intl.message(
      'Program',
      name: 'program',
      desc: '',
      args: [],
    );
  }

  /// `Make a Tour`
  String get takeATour {
    return Intl.message(
      'Make a Tour',
      name: 'takeATour',
      desc: '',
      args: [],
    );
  }

  /// `View Program`
  String get viewProgram {
    return Intl.message(
      'View Program',
      name: 'viewProgram',
      desc: '',
      args: [],
    );
  }

  /// `Make a Program`
  String get makeProgram {
    return Intl.message(
      'Make a Program',
      name: 'makeProgram',
      desc: '',
      args: [],
    );
  }

  /// `Create and update program`
  String get createAndUpdateProgram {
    return Intl.message(
      'Create and update program',
      name: 'createAndUpdateProgram',
      desc: '',
      args: [],
    );
  }

  /// `Name Of Tour`
  String get nameOfTour {
    return Intl.message(
      'Name Of Tour',
      name: 'nameOfTour',
      desc: '',
      args: [],
    );
  }

  /// `Description of Tour`
  String get descriptionOfTour {
    return Intl.message(
      'Description of Tour',
      name: 'descriptionOfTour',
      desc: '',
      args: [],
    );
  }

  /// `Date (From To)`
  String get dateToFrom {
    return Intl.message(
      'Date (From To)',
      name: 'dateToFrom',
      desc: '',
      args: [],
    );
  }

  /// `Date (To)`
  String get dateTo {
    return Intl.message(
      'Date (To)',
      name: 'dateTo',
      desc: '',
      args: [],
    );
  }

  /// `Create a tour`
  String get createATour {
    return Intl.message(
      'Create a tour',
      name: 'createATour',
      desc: '',
      args: [],
    );
  }

  /// `Make tour schedule`
  String get makeTourSchedules {
    return Intl.message(
      'Make tour schedule',
      name: 'makeTourSchedules',
      desc: '',
      args: [],
    );
  }

  /// `Later`
  String get later {
    return Intl.message(
      'Later',
      name: 'later',
      desc: '',
      args: [],
    );
  }

  /// `Create program`
  String get createProgram {
    return Intl.message(
      'Create program',
      name: 'createProgram',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Mobile Number (optional)`
  String get phoneNumber {
    return Intl.message(
      'Mobile Number (optional)',
      name: 'phoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `position`
  String get position {
    return Intl.message(
      'position',
      name: 'position',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get add {
    return Intl.message(
      'Add',
      name: 'add',
      desc: '',
      args: [],
    );
  }

  /// `Tour`
  String get tour {
    return Intl.message(
      'Tour',
      name: 'tour',
      desc: '',
      args: [],
    );
  }

  /// `My events`
  String get myEvent {
    return Intl.message(
      'My events',
      name: 'myEvent',
      desc: '',
      args: [],
    );
  }

  /// `See all`
  String get seeAll {
    return Intl.message(
      'See all',
      name: 'seeAll',
      desc: '',
      args: [],
    );
  }

  /// `program name *`
  String get functionName {
    return Intl.message(
      'program name *',
      name: 'functionName',
      desc: '',
      args: [],
    );
  }

  /// `date and time *`
  String get dateAndTime {
    return Intl.message(
      'date and time *',
      name: 'dateAndTime',
      desc: '',
      args: [],
    );
  }

  /// `Program Type *`
  String get functionType {
    return Intl.message(
      'Program Type *',
      name: 'functionType',
      desc: '',
      args: [],
    );
  }

  /// `Program Level *`
  String get functionLayer {
    return Intl.message(
      'Program Level *',
      name: 'functionLayer',
      desc: '',
      args: [],
    );
  }

  /// `Lok Sabha`
  String get lokSabha {
    return Intl.message(
      'Lok Sabha',
      name: 'lokSabha',
      desc: '',
      args: [],
    );
  }

  /// `Venue (Address of the venue)`
  String get functionAdd {
    return Intl.message(
      'Venue (Address of the venue)',
      name: 'functionAdd',
      desc: '',
      args: [],
    );
  }

  /// `subject`
  String get subject {
    return Intl.message(
      'subject',
      name: 'subject',
      desc: '',
      args: [],
    );
  }

  /// `The guest / participant / activist present in the program whose name you want to add.`
  String get addGuestDetail {
    return Intl.message(
      'The guest / participant / activist present in the program whose name you want to add.',
      name: 'addGuestDetail',
      desc: '',
      args: [],
    );
  }

  /// `add tax (optional)`
  String get addOptional {
    return Intl.message(
      'add tax (optional)',
      name: 'addOptional',
      desc: '',
      args: [],
    );
  }

  /// `comment`
  String get comment {
    return Intl.message(
      'comment',
      name: 'comment',
      desc: '',
      args: [],
    );
  }

  /// `Photo ( max 2 )`
  String get photoMax {
    return Intl.message(
      'Photo ( max 2 )',
      name: 'photoMax',
      desc: '',
      args: [],
    );
  }

  /// `upload photo here`
  String get uploadPhoto {
    return Intl.message(
      'upload photo here',
      name: 'uploadPhoto',
      desc: '',
      args: [],
    );
  }

  /// `save it`
  String get save {
    return Intl.message(
      'save it',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Stay and program list`
  String get stayAndProgramList {
    return Intl.message(
      'Stay and program list',
      name: 'stayAndProgramList',
      desc: '',
      args: [],
    );
  }

  /// `Total Program`
  String get totalProgram {
    return Intl.message(
      'Total Program',
      name: 'totalProgram',
      desc: '',
      args: [],
    );
  }

  /// `Please choose location`
  String get pleaseChoosePlace {
    return Intl.message(
      'Please choose location',
      name: 'pleaseChoosePlace',
      desc: '',
      args: [],
    );
  }

  /// `No organizations available`
  String get noOrganizationsAvailable {
    return Intl.message(
      'No organizations available',
      name: 'noOrganizationsAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Entry`
  String get entry {
    return Intl.message(
      'Entry',
      name: 'entry',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get total {
    return Intl.message(
      'Total',
      name: 'total',
      desc: '',
      args: [],
    );
  }

  /// `Data Entry`
  String get dataEntry {
    return Intl.message(
      'Data Entry',
      name: 'dataEntry',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'hi'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}

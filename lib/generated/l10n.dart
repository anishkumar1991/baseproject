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

  /// `Complete`
  String get Complete {
    return Intl.message(
      'Complete',
      name: 'Complete',
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

  /// `Create and`
  String get createAndUpdateProgram {
    return Intl.message(
      'Create and',
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

  /// `Program Name *`
  String get functionName {
    return Intl.message(
      'Program Name *',
      name: 'functionName',
      desc: '',
      args: [],
    );
  }

  /// `Date and Time *`
  String get dateAndTime {
    return Intl.message(
      'Date and Time *',
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

  /// `Subject`
  String get subject {
    return Intl.message(
      'Subject',
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

  /// `Add Tax (optional)`
  String get addOptional {
    return Intl.message(
      'Add Tax (optional)',
      name: 'addOptional',
      desc: '',
      args: [],
    );
  }

  /// `Comment`
  String get comment {
    return Intl.message(
      'Comment',
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

  /// `Upload Photo Here`
  String get uploadPhoto {
    return Intl.message(
      'Upload Photo Here',
      name: 'uploadPhoto',
      desc: '',
      args: [],
    );
  }

  /// `Save it`
  String get save {
    return Intl.message(
      'Save it',
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

  /// `Program Type`
  String get typeOfFunction {
    return Intl.message(
      'Program Type',
      name: 'typeOfFunction',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `View`
  String get view {
    return Intl.message(
      'View',
      name: 'view',
      desc: '',
      args: [],
    );
  }

  /// `Select Tour Level`
  String get selectPravasLevel {
    return Intl.message(
      'Select Tour Level',
      name: 'selectPravasLevel',
      desc: '',
      args: [],
    );
  }

  /// `Select Loksabha`
  String get selectLoksabha {
    return Intl.message(
      'Select Loksabha',
      name: 'selectLoksabha',
      desc: '',
      args: [],
    );
  }

  /// `Theme and Insight`
  String get ThemeandInsight {
    return Intl.message(
      'Theme and Insight',
      name: 'ThemeandInsight',
      desc: '',
      args: [],
    );
  }

  /// `Get information and facts about political and social subjects.`
  String get ThemeDes {
    return Intl.message(
      'Get information and facts about political and social subjects.',
      name: 'ThemeDes',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get address {
    return Intl.message(
      'Address',
      name: 'address',
      desc: '',
      args: [],
    );
  }

  /// `Education`
  String get education {
    return Intl.message(
      'Education',
      name: 'education',
      desc: '',
      args: [],
    );
  }

  /// `Business`
  String get business {
    return Intl.message(
      'Business',
      name: 'business',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `See more`
  String get seeMore {
    return Intl.message(
      'See more',
      name: 'seeMore',
      desc: '',
      args: [],
    );
  }

  /// `See less`
  String get seeLess {
    return Intl.message(
      'See less',
      name: 'seeLess',
      desc: '',
      args: [],
    );
  }

  /// `Full Name`
  String get fullName {
    return Intl.message(
      'Full Name',
      name: 'fullName',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get userName {
    return Intl.message(
      'Username',
      name: 'userName',
      desc: '',
      args: [],
    );
  }

  /// `Mobile no.`
  String get mobileNumber {
    return Intl.message(
      'Mobile no.',
      name: 'mobileNumber',
      desc: '',
      args: [],
    );
  }

  /// `Date of Birth`
  String get boi {
    return Intl.message(
      'Date of Birth',
      name: 'boi',
      desc: '',
      args: [],
    );
  }

  /// `Religion`
  String get religion {
    return Intl.message(
      'Religion',
      name: 'religion',
      desc: '',
      args: [],
    );
  }

  /// `Category`
  String get grade {
    return Intl.message(
      'Category',
      name: 'grade',
      desc: '',
      args: [],
    );
  }

  /// `Caste`
  String get caste {
    return Intl.message(
      'Caste',
      name: 'caste',
      desc: '',
      args: [],
    );
  }

  /// `Flat, House no. , Building, Apartment`
  String get FlatDes {
    return Intl.message(
      'Flat, House no. , Building, Apartment',
      name: 'FlatDes',
      desc: '',
      args: [],
    );
  }

  /// `Area, Street, Sector, Village`
  String get AreaDes {
    return Intl.message(
      'Area, Street, Sector, Village',
      name: 'AreaDes',
      desc: '',
      args: [],
    );
  }

  /// `Pin Code`
  String get PinCode {
    return Intl.message(
      'Pin Code',
      name: 'PinCode',
      desc: '',
      args: [],
    );
  }

  /// `Town/City`
  String get townCity {
    return Intl.message(
      'Town/City',
      name: 'townCity',
      desc: '',
      args: [],
    );
  }

  /// `State`
  String get state {
    return Intl.message(
      'State',
      name: 'state',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get Home {
    return Intl.message(
      'Home',
      name: 'Home',
      desc: '',
      args: [],
    );
  }

  /// `Office`
  String get Office {
    return Intl.message(
      'Office',
      name: 'Office',
      desc: '',
      args: [],
    );
  }

  /// `Other`
  String get Other {
    return Intl.message(
      'Other',
      name: 'Other',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `New Entry`
  String get newEntry {
    return Intl.message(
      'New Entry',
      name: 'newEntry',
      desc: '',
      args: [],
    );
  }

  /// `Post`
  String get post {
    return Intl.message(
      'Post',
      name: 'post',
      desc: '',
      args: [],
    );
  }

  /// `Sangathan Reports`
  String get sangathanReports {
    return Intl.message(
      'Sangathan Reports',
      name: 'sangathanReports',
      desc: '',
      args: [],
    );
  }

  /// `Create Shakti Kendra`
  String get createShaktiKendra {
    return Intl.message(
      'Create Shakti Kendra',
      name: 'createShaktiKendra',
      desc: '',
      args: [],
    );
  }

  /// `Level`
  String get level {
    return Intl.message(
      'Level',
      name: 'level',
      desc: '',
      args: [],
    );
  }

  /// `Years (From)`
  String get yearFrom {
    return Intl.message(
      'Years (From)',
      name: 'yearFrom',
      desc: '',
      args: [],
    );
  }

  /// `Years (To)`
  String get yearTo {
    return Intl.message(
      'Years (To)',
      name: 'yearTo',
      desc: '',
      args: [],
    );
  }

  /// `Name of the Institute or College`
  String get clgName {
    return Intl.message(
      'Name of the Institute or College',
      name: 'clgName',
      desc: '',
      args: [],
    );
  }

  /// `Name of organization`
  String get organization {
    return Intl.message(
      'Name of organization',
      name: 'organization',
      desc: '',
      args: [],
    );
  }

  /// `Delete from profile?`
  String get dialogTitle {
    return Intl.message(
      'Delete from profile?',
      name: 'dialogTitle',
      desc: '',
      args: [],
    );
  }

  /// `This will delete profession from your profile.`
  String get dialogSubtitle {
    return Intl.message(
      'This will delete profession from your profile.',
      name: 'dialogSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `This will delete education details from your profile.`
  String get dialogSubtitle1 {
    return Intl.message(
      'This will delete education details from your profile.',
      name: 'dialogSubtitle1',
      desc: '',
      args: [],
    );
  }

  /// `This will delete address details from your profile.`
  String get dialogSubtitle2 {
    return Intl.message(
      'This will delete address details from your profile.',
      name: 'dialogSubtitle2',
      desc: '',
      args: [],
    );
  }

  /// `No thanks`
  String get noThanks {
    return Intl.message(
      'No thanks',
      name: 'noThanks',
      desc: '',
      args: [],
    );
  }

  /// `No Data Available`
  String get noDataAvailable {
    return Intl.message(
      'No Data Available',
      name: 'noDataAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Age`
  String get age {
    return Intl.message(
      'Age',
      name: 'age',
      desc: '',
      args: [],
    );
  }

  /// `Years`
  String get years {
    return Intl.message(
      'Years',
      name: 'years',
      desc: '',
      args: [],
    );
  }

  /// `Category`
  String get category {
    return Intl.message(
      'Category',
      name: 'category',
      desc: '',
      args: [],
    );
  }

  /// `Verify with OTP`
  String get verifyWithOtp {
    return Intl.message(
      'Verify with OTP',
      name: 'verifyWithOtp',
      desc: '',
      args: [],
    );
  }

  /// `Skip & Add new entry`
  String get skipAddNewEntry {
    return Intl.message(
      'Skip & Add new entry',
      name: 'skipAddNewEntry',
      desc: '',
      args: [],
    );
  }

  /// `Resend`
  String get resend {
    return Intl.message(
      'Resend',
      name: 'resend',
      desc: '',
      args: [],
    );
  }

  /// `Education Updated`
  String get educationUpdated {
    return Intl.message(
      'Education Updated',
      name: 'educationUpdated',
      desc: '',
      args: [],
    );
  }

  /// `Address Updated`
  String get addressUpdated {
    return Intl.message(
      'Address Updated',
      name: 'addressUpdated',
      desc: '',
      args: [],
    );
  }

  /// `Business Updated`
  String get businessUpdated {
    return Intl.message(
      'Business Updated',
      name: 'businessUpdated',
      desc: '',
      args: [],
    );
  }

  /// `Education Deleted`
  String get educationDeleted {
    return Intl.message(
      'Education Deleted',
      name: 'educationDeleted',
      desc: '',
      args: [],
    );
  }

  /// `Address Deleted`
  String get addressDeleted {
    return Intl.message(
      'Address Deleted',
      name: 'addressDeleted',
      desc: '',
      args: [],
    );
  }

  /// `Business Deleted`
  String get businessDeleted {
    return Intl.message(
      'Business Deleted',
      name: 'businessDeleted',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter (From) year First`
  String get somethingWentWrong {
    return Intl.message(
      'Please Enter (From) year First',
      name: 'somethingWentWrong',
      desc: '',
      args: [],
    );
  }

  /// `Please select a reason for deletion`
  String get reasonforDeletion {
    return Intl.message(
      'Please select a reason for deletion',
      name: 'reasonforDeletion',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Please Select Reason`
  String get pleaseSelectReason {
    return Intl.message(
      'Please Select Reason',
      name: 'pleaseSelectReason',
      desc: '',
      args: [],
    );
  }

  /// `Please enter data`
  String get pleaseEnterData {
    return Intl.message(
      'Please enter data',
      name: 'pleaseEnterData',
      desc: '',
      args: [],
    );
  }

  /// `Log Out`
  String get logOut {
    return Intl.message(
      'Log Out',
      name: 'logOut',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to log out?`
  String get logOutDes {
    return Intl.message(
      'Are you sure you want to log out?',
      name: 'logOutDes',
      desc: '',
      args: [],
    );
  }

  /// `Welcome`
  String get welcome {
    return Intl.message(
      'Welcome',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `Shakti Kendra Creation`
  String get shaktiKendraCreation {
    return Intl.message(
      'Shakti Kendra Creation',
      name: 'shaktiKendraCreation',
      desc: '',
      args: [],
    );
  }

  /// `Assembly`
  String get vidhanSabha {
    return Intl.message(
      'Assembly',
      name: 'vidhanSabha',
      desc: '',
      args: [],
    );
  }

  /// `Filter`
  String get filter {
    return Intl.message(
      'Filter',
      name: 'filter',
      desc: '',
      args: [],
    );
  }

  /// `Shakti kendr`
  String get shaktikendr {
    return Intl.message(
      'Shakti kendr',
      name: 'shaktikendr',
      desc: '',
      args: [],
    );
  }

  /// `Board`
  String get mandal {
    return Intl.message(
      'Board',
      name: 'mandal',
      desc: '',
      args: [],
    );
  }

  /// `Booths`
  String get buth {
    return Intl.message(
      'Booths',
      name: 'buth',
      desc: '',
      args: [],
    );
  }

  /// `Make shakti kendr`
  String get makeShaktikendr {
    return Intl.message(
      'Make shakti kendr',
      name: 'makeShaktikendr',
      desc: '',
      args: [],
    );
  }

  /// `Want to remove this shakti kendr?`
  String get deletrShaktiKendrTitle {
    return Intl.message(
      'Want to remove this shakti kendr?',
      name: 'deletrShaktiKendrTitle',
      desc: '',
      args: [],
    );
  }

  /// `entries will be deleted.`
  String get deleteShaktiKendr {
    return Intl.message(
      'entries will be deleted.',
      name: 'deleteShaktiKendr',
      desc: '',
      args: [],
    );
  }

  /// `Write the name of shakti kendr`
  String get enterShaktiKendrName {
    return Intl.message(
      'Write the name of shakti kendr',
      name: 'enterShaktiKendrName',
      desc: '',
      args: [],
    );
  }

  /// `Selected booth`
  String get selectedBooth {
    return Intl.message(
      'Selected booth',
      name: 'selectedBooth',
      desc: '',
      args: [],
    );
  }

  /// `Booths are already in other shakti kendr`
  String get boothSelectedTitle {
    return Intl.message(
      'Booths are already in other shakti kendr',
      name: 'boothSelectedTitle',
      desc: '',
      args: [],
    );
  }

  /// `By submitting all the booths will be connected to this Shakti Kendra.`
  String get boothDes {
    return Intl.message(
      'By submitting all the booths will be connected to this Shakti Kendra.',
      name: 'boothDes',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submit {
    return Intl.message(
      'Submit',
      name: 'submit',
      desc: '',
      args: [],
    );
  }

  /// `Select Booth`
  String get boothSelect {
    return Intl.message(
      'Select Booth',
      name: 'boothSelect',
      desc: '',
      args: [],
    );
  }

  /// `Add Booth`
  String get addBooth {
    return Intl.message(
      'Add Booth',
      name: 'addBooth',
      desc: '',
      args: [],
    );
  }

  /// `Add Entry`
  String get addEntry {
    return Intl.message(
      'Add Entry',
      name: 'addEntry',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get adds {
    return Intl.message(
      'Add',
      name: 'adds',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter Name`
  String get enterName {
    return Intl.message(
      'Please Enter Name',
      name: 'enterName',
      desc: '',
      args: [],
    );
  }

  /// `Please Select Designation`
  String get selectDesignation {
    return Intl.message(
      'Please Select Designation',
      name: 'selectDesignation',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number should be 10 digit`
  String get enterPhoneNumber {
    return Intl.message(
      'Phone Number should be 10 digit',
      name: 'enterPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Primary Member id should be 10 digit`
  String get primaryMemberId {
    return Intl.message(
      'Primary Member id should be 10 digit',
      name: 'primaryMemberId',
      desc: '',
      args: [],
    );
  }

  /// `Age should be 2 digit`
  String get ageError {
    return Intl.message(
      'Age should be 2 digit',
      name: 'ageError',
      desc: '',
      args: [],
    );
  }

  /// `Whatsapp Number should be 10 digit`
  String get whatsappNumber {
    return Intl.message(
      'Whatsapp Number should be 10 digit',
      name: 'whatsappNumber',
      desc: '',
      args: [],
    );
  }

  /// `STD Code Number should be 5 digit`
  String get stdCodeNumber {
    return Intl.message(
      'STD Code Number should be 5 digit',
      name: 'stdCodeNumber',
      desc: '',
      args: [],
    );
  }

  /// `Landline Number should be 8 digit`
  String get landlineNumber {
    return Intl.message(
      'Landline Number should be 8 digit',
      name: 'landlineNumber',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter Valid Email`
  String get emailAddress {
    return Intl.message(
      'Please Enter Valid Email',
      name: 'emailAddress',
      desc: '',
      args: [],
    );
  }

  /// `DOB Should be 16 or above year`
  String get dobError {
    return Intl.message(
      'DOB Should be 16 or above year',
      name: 'dobError',
      desc: '',
      args: [],
    );
  }

  /// `Pin code should be 6 digit`
  String get pincode {
    return Intl.message(
      'Pin code should be 6 digit',
      name: 'pincode',
      desc: '',
      args: [],
    );
  }

  /// `Enter valid voter id`
  String get voterId {
    return Intl.message(
      'Enter valid voter id',
      name: 'voterId',
      desc: '',
      args: [],
    );
  }

  /// `Aadhaar Number should be 12 digit`
  String get aadharNumber {
    return Intl.message(
      'Aadhaar Number should be 12 digit',
      name: 'aadharNumber',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter`
  String get pleaseEnter {
    return Intl.message(
      'Please Enter',
      name: 'pleaseEnter',
      desc: '',
      args: [],
    );
  }

  /// `Please`
  String get please {
    return Intl.message(
      'Please',
      name: 'please',
      desc: '',
      args: [],
    );
  }

  /// `Enter`
  String get enter {
    return Intl.message(
      'Enter',
      name: 'enter',
      desc: '',
      args: [],
    );
  }

  /// `No Data Unit are available`
  String get noDataUnit {
    return Intl.message(
      'No Data Unit are available',
      name: 'noDataUnit',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure to delete?`
  String get sureToDelete {
    return Intl.message(
      'Are you sure to delete?',
      name: 'sureToDelete',
      desc: '',
      args: [],
    );
  }

  /// `No booth available`
  String get noBoothAvailable {
    return Intl.message(
      'No booth available',
      name: 'noBoothAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Data Unit is empty So you can't add entry`
  String get dataUnitEmptyError {
    return Intl.message(
      'Data Unit is empty So you can\'t add entry',
      name: 'dataUnitEmptyError',
      desc: '',
      args: [],
    );
  }

  /// `Please Select Vidhansabha first`
  String get selectVidhansabhaFirst {
    return Intl.message(
      'Please Select Vidhansabha first',
      name: 'selectVidhansabhaFirst',
      desc: '',
      args: [],
    );
  }

  /// `Please Select Mandal first`
  String get selectMandalFirst {
    return Intl.message(
      'Please Select Mandal first',
      name: 'selectMandalFirst',
      desc: '',
      args: [],
    );
  }

  /// `Please Select Booth first`
  String get selectBoothFirst {
    return Intl.message(
      'Please Select Booth first',
      name: 'selectBoothFirst',
      desc: '',
      args: [],
    );
  }

  /// `Please enter shakti kendr name`
  String get enterShkatiKendrName {
    return Intl.message(
      'Please enter shakti kendr name',
      name: 'enterShkatiKendrName',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get english {
    return Intl.message(
      'English',
      name: 'english',
      desc: '',
      args: [],
    );
  }

  /// `Hindi`
  String get hindi {
    return Intl.message(
      'Hindi',
      name: 'hindi',
      desc: '',
      args: [],
    );
  }

  /// `please select category first`
  String get pleaseSelectCategory {
    return Intl.message(
      'please select category first',
      name: 'pleaseSelectCategory',
      desc: '',
      args: [],
    );
  }

  /// `Panna`
  String get panna {
    return Intl.message(
      'Panna',
      name: 'panna',
      desc: '',
      args: [],
    );
  }

  /// `Total Panna`
  String get totalPanna {
    return Intl.message(
      'Total Panna',
      name: 'totalPanna',
      desc: '',
      args: [],
    );
  }

  /// `Panna Parmukh`
  String get pannaParmukh {
    return Intl.message(
      'Panna Parmukh',
      name: 'pannaParmukh',
      desc: '',
      args: [],
    );
  }

  /// `Panaa Samiti`
  String get panaaSamiti {
    return Intl.message(
      'Panaa Samiti',
      name: 'panaaSamiti',
      desc: '',
      args: [],
    );
  }

  /// `Panna No`
  String get pannaNo {
    return Intl.message(
      'Panna No',
      name: 'pannaNo',
      desc: '',
      args: [],
    );
  }

  /// `Panna No`
  String get pannaKramaank {
    return Intl.message(
      'Panna No',
      name: 'pannaKramaank',
      desc: '',
      args: [],
    );
  }

  /// `Current Shakti Kendra`
  String get currentSk {
    return Intl.message(
      'Current Shakti Kendra',
      name: 'currentSk',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter Phone Number`
  String get enterMobileNumber {
    return Intl.message(
      'Please Enter Phone Number',
      name: 'enterMobileNumber',
      desc: '',
      args: [],
    );
  }

  /// `This Number is Not Valid Number`
  String get notValidNumber {
    return Intl.message(
      'This Number is Not Valid Number',
      name: 'notValidNumber',
      desc: '',
      args: [],
    );
  }

  /// `Person already verified`
  String get alreadyVerified {
    return Intl.message(
      'Person already verified',
      name: 'alreadyVerified',
      desc: '',
      args: [],
    );
  }

  /// `Present Guest / Participant / Worker`
  String get addAttendeesHeader {
    return Intl.message(
      'Present Guest / Participant / Worker',
      name: 'addAttendeesHeader',
      desc: '',
      args: [],
    );
  }

  /// `Day`
  String get day {
    return Intl.message(
      'Day',
      name: 'day',
      desc: '',
      args: [],
    );
  }

  /// `Time`
  String get time {
    return Intl.message(
      'Time',
      name: 'time',
      desc: '',
      args: [],
    );
  }

  /// `Uploading`
  String get uploading {
    return Intl.message(
      'Uploading',
      name: 'uploading',
      desc: '',
      args: [],
    );
  }

  /// `Please enter pincode number`
  String get enterPin {
    return Intl.message(
      'Please enter pincode number',
      name: 'enterPin',
      desc: '',
      args: [],
    );
  }

  /// `preparing`
  String get preparing {
    return Intl.message(
      'preparing',
      name: 'preparing',
      desc: '',
      args: [],
    );
  }

  /// `oops !! something went to wrong please try again later..`
  String get oopsErrorMsg {
    return Intl.message(
      'oops !! something went to wrong please try again later..',
      name: 'oopsErrorMsg',
      desc: '',
      args: [],
    );
  }

  /// `Please enter pravas name first`
  String get pravasName {
    return Intl.message(
      'Please enter pravas name first',
      name: 'pravasName',
      desc: '',
      args: [],
    );
  }

  /// `please enter start date`
  String get pravasStartDate {
    return Intl.message(
      'please enter start date',
      name: 'pravasStartDate',
      desc: '',
      args: [],
    );
  }

  /// `Please enter last date`
  String get pravasEndDate {
    return Intl.message(
      'Please enter last date',
      name: 'pravasEndDate',
      desc: '',
      args: [],
    );
  }

  /// `Please enter pravas subject`
  String get pravasSubject {
    return Intl.message(
      'Please enter pravas subject',
      name: 'pravasSubject',
      desc: '',
      args: [],
    );
  }

  /// `Getting state data`
  String get gettingStateData {
    return Intl.message(
      'Getting state data',
      name: 'gettingStateData',
      desc: '',
      args: [],
    );
  }

  /// `Downloading..`
  String get downloading {
    return Intl.message(
      'Downloading..',
      name: 'downloading',
      desc: '',
      args: [],
    );
  }

  /// `Download`
  String get download {
    return Intl.message(
      'Download',
      name: 'download',
      desc: '',
      args: [],
    );
  }

  /// `Circular`
  String get circular {
    return Intl.message(
      'Circular',
      name: 'circular',
      desc: '',
      args: [],
    );
  }

  /// `Report`
  String get report {
    return Intl.message(
      'Report',
      name: 'report',
      desc: '',
      args: [],
    );
  }

  /// `Notification`
  String get notification {
    return Intl.message(
      'Notification',
      name: 'notification',
      desc: '',
      args: [],
    );
  }

  /// `Filter by date`
  String get notificationDate {
    return Intl.message(
      'Filter by date',
      name: 'notificationDate',
      desc: '',
      args: [],
    );
  }

  /// `Something Went Wrong`
  String get notificationsomethingWentWrong {
    return Intl.message(
      'Something Went Wrong',
      name: 'notificationsomethingWentWrong',
      desc: '',
      args: [],
    );
  }

  /// `Booth`
  String get booth {
    return Intl.message(
      'Booth',
      name: 'booth',
      desc: '',
      args: [],
    );
  }

  /// `Total Groups –`
  String get totalGroups {
    return Intl.message(
      'Total Groups –',
      name: 'totalGroups',
      desc: '',
      args: [],
    );
  }

  /// `Social Media`
  String get socialMedia {
    return Intl.message(
      'Social Media',
      name: 'socialMedia',
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

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

  /// `Post And\nListen Your\nFavorite`
  String get intro1 {
    return Intl.message(
      'Post And\nListen Your\nFavorite',
      name: 'intro1',
      desc: '',
      args: [],
    );
  }

  /// `Podcaste\nAnywhere,\nAnytime`
  String get intro2 {
    return Intl.message(
      'Podcaste\nAnywhere,\nAnytime',
      name: 'intro2',
      desc: '',
      args: [],
    );
  }

  /// `Get as visiter`
  String get intro3 {
    return Intl.message(
      'Get as visiter',
      name: 'intro3',
      desc: '',
      args: [],
    );
  }

  /// `Sign up`
  String get signup {
    return Intl.message(
      'Sign up',
      name: 'signup',
      desc: '',
      args: [],
    );
  }

  /// `Let’s get\nStarted`
  String get signupTitle {
    return Intl.message(
      'Let’s get\nStarted',
      name: 'signupTitle',
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

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Already Have An Account?`
  String get arleady {
    return Intl.message(
      'Already Have An Account?',
      name: 'arleady',
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

  /// `Enter your name`
  String get EnterName {
    return Intl.message(
      'Enter your name',
      name: 'EnterName',
      desc: '',
      args: [],
    );
  }

  /// `Add valid email`
  String get validEmail {
    return Intl.message(
      'Add valid email',
      name: 'validEmail',
      desc: '',
      args: [],
    );
  }

  /// `Enter a vaild password`
  String get vaildPassword {
    return Intl.message(
      'Enter a vaild password',
      name: 'vaildPassword',
      desc: '',
      args: [],
    );
  }

  /// `your password is too short`
  String get shortPassword {
    return Intl.message(
      'your password is too short',
      name: 'shortPassword',
      desc: '',
      args: [],
    );
  }

  /// `Hey,\nWelcome\nBack`
  String get loginTitle {
    return Intl.message(
      'Hey,\nWelcome\nBack',
      name: 'loginTitle',
      desc: '',
      args: [],
    );
  }

  /// `Don’t Have An Account?`
  String get donotHaveAcount {
    return Intl.message(
      'Don’t Have An Account?',
      name: 'donotHaveAcount',
      desc: '',
      args: [],
    );
  }

  /// `What Are You Interested In?`
  String get WhatyourInterest {
    return Intl.message(
      'What Are You Interested In?',
      name: 'WhatyourInterest',
      desc: '',
      args: [],
    );
  }

  /// `Select One or More`
  String get selectOne {
    return Intl.message(
      'Select One or More',
      name: 'selectOne',
      desc: '',
      args: [],
    );
  }

  /// `Try Again`
  String get tryAgain {
    return Intl.message(
      'Try Again',
      name: 'tryAgain',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get Continue {
    return Intl.message(
      'Continue',
      name: 'Continue',
      desc: '',
      args: [],
    );
  }

  /// `Successfully select`
  String get successfullySelect {
    return Intl.message(
      'Successfully select',
      name: 'successfullySelect',
      desc: '',
      args: [],
    );
  }

  /// `Failure select`
  String get failureSelect {
    return Intl.message(
      'Failure select',
      name: 'failureSelect',
      desc: '',
      args: [],
    );
  }

  /// `Library`
  String get Library {
    return Intl.message(
      'Library',
      name: 'Library',
      desc: '',
      args: [],
    );
  }

  /// `Downloads`
  String get Downloads {
    return Intl.message(
      'Downloads',
      name: 'Downloads',
      desc: '',
      args: [],
    );
  }

  /// `Favorites`
  String get Favorites {
    return Intl.message(
      'Favorites',
      name: 'Favorites',
      desc: '',
      args: [],
    );
  }

  /// `Followed Channels`
  String get followedChannels {
    return Intl.message(
      'Followed Channels',
      name: 'followedChannels',
      desc: '',
      args: [],
    );
  }

  /// `You haven't download\nany podcasts yet!`
  String get YouHaveNotDownload {
    return Intl.message(
      'You haven\'t download\nany podcasts yet!',
      name: 'YouHaveNotDownload',
      desc: '',
      args: [],
    );
  }

  /// `Your favorite episodes\nis empty`
  String get YourFavoriteIsEmpty {
    return Intl.message(
      'Your favorite episodes\nis empty',
      name: 'YourFavoriteIsEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get Notifications {
    return Intl.message(
      'Notifications',
      name: 'Notifications',
      desc: '',
      args: [],
    );
  }

  /// `The channel `
  String get TheChannel {
    return Intl.message(
      'The channel ',
      name: 'TheChannel',
      desc: '',
      args: [],
    );
  }

  /// ` uploaded the following podcast : `
  String get UploadedFollowingPodcast {
    return Intl.message(
      ' uploaded the following podcast : ',
      name: 'UploadedFollowingPodcast',
      desc: '',
      args: [],
    );
  }

  /// `My Profile`
  String get MyProfile {
    return Intl.message(
      'My Profile',
      name: 'MyProfile',
      desc: '',
      args: [],
    );
  }

  /// `View Channel`
  String get ViewChannel {
    return Intl.message(
      'View Channel',
      name: 'ViewChannel',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get Language {
    return Intl.message(
      'Language',
      name: 'Language',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get English {
    return Intl.message(
      'English',
      name: 'English',
      desc: '',
      args: [],
    );
  }

  /// `Arabic`
  String get Arabic {
    return Intl.message(
      'Arabic',
      name: 'Arabic',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get Logout {
    return Intl.message(
      'Logout',
      name: 'Logout',
      desc: '',
      args: [],
    );
  }

  /// `Start making your\nchannel Now`
  String get startMakingChannel {
    return Intl.message(
      'Start making your\nchannel Now',
      name: 'startMakingChannel',
      desc: '',
      args: [],
    );
  }

  /// `Channel Name`
  String get ChannelName {
    return Intl.message(
      'Channel Name',
      name: 'ChannelName',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get Description {
    return Intl.message(
      'Description',
      name: 'Description',
      desc: '',
      args: [],
    );
  }

  /// `The channel created Successfully`
  String get channelCreatedSuccessfully {
    return Intl.message(
      'The channel created Successfully',
      name: 'channelCreatedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `the process failed, please try again.`
  String get processFailed {
    return Intl.message(
      'the process failed, please try again.',
      name: 'processFailed',
      desc: '',
      args: [],
    );
  }

  /// `Create Channel`
  String get CreateChannel {
    return Intl.message(
      'Create Channel',
      name: 'CreateChannel',
      desc: '',
      args: [],
    );
  }

  /// `Episodes`
  String get Episodes {
    return Intl.message(
      'Episodes',
      name: 'Episodes',
      desc: '',
      args: [],
    );
  }

  /// `Details`
  String get Details {
    return Intl.message(
      'Details',
      name: 'Details',
      desc: '',
      args: [],
    );
  }

  /// `Channel`
  String get Channel {
    return Intl.message(
      'Channel',
      name: 'Channel',
      desc: '',
      args: [],
    );
  }

  /// `Failed`
  String get failed {
    return Intl.message(
      'Failed',
      name: 'failed',
      desc: '',
      args: [],
    );
  }

  /// `Explore`
  String get Explore {
    return Intl.message(
      'Explore',
      name: 'Explore',
      desc: '',
      args: [],
    );
  }

  /// `Search for any podcast`
  String get SearchPodcast {
    return Intl.message(
      'Search for any podcast',
      name: 'SearchPodcast',
      desc: '',
      args: [],
    );
  }

  /// `Latest Podcasts`
  String get LatestPodcasts {
    return Intl.message(
      'Latest Podcasts',
      name: 'LatestPodcasts',
      desc: '',
      args: [],
    );
  }

  /// `Most Listened Podcasts`
  String get MostListened {
    return Intl.message(
      'Most Listened Podcasts',
      name: 'MostListened',
      desc: '',
      args: [],
    );
  }

  /// `Top Categories`
  String get TopCategories {
    return Intl.message(
      'Top Categories',
      name: 'TopCategories',
      desc: '',
      args: [],
    );
  }

  /// `See all`
  String get SeeAll {
    return Intl.message(
      'See all',
      name: 'SeeAll',
      desc: '',
      args: [],
    );
  }

  /// `Sorry, no search result`
  String get SorryNoResult {
    return Intl.message(
      'Sorry, no search result',
      name: 'SorryNoResult',
      desc: '',
      args: [],
    );
  }

  /// `Start publishing your podcast:`
  String get StartPublishing {
    return Intl.message(
      'Start publishing your podcast:',
      name: 'StartPublishing',
      desc: '',
      args: [],
    );
  }

  /// `gallery`
  String get gallery {
    return Intl.message(
      'gallery',
      name: 'gallery',
      desc: '',
      args: [],
    );
  }

  /// `recorded`
  String get recorded {
    return Intl.message(
      'recorded',
      name: 'recorded',
      desc: '',
      args: [],
    );
  }

  /// `written`
  String get written {
    return Intl.message(
      'written',
      name: 'written',
      desc: '',
      args: [],
    );
  }

  /// `home`
  String get home {
    return Intl.message(
      'home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `explore`
  String get explore {
    return Intl.message(
      'explore',
      name: 'explore',
      desc: '',
      args: [],
    );
  }

  /// `library`
  String get library {
    return Intl.message(
      'library',
      name: 'library',
      desc: '',
      args: [],
    );
  }

  /// `profile`
  String get profile {
    return Intl.message(
      'profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Comments`
  String get Comments {
    return Intl.message(
      'Comments',
      name: 'Comments',
      desc: '',
      args: [],
    );
  }

  /// `There is no comments\nyet on this podcast`
  String get EmptyComments {
    return Intl.message(
      'There is no comments\nyet on this podcast',
      name: 'EmptyComments',
      desc: '',
      args: [],
    );
  }

  /// `Hey there 👋🏻`
  String get HeyThere {
    return Intl.message(
      'Hey there 👋🏻',
      name: 'HeyThere',
      desc: '',
      args: [],
    );
  }

  /// `Listen to your Favorite podcasts`
  String get ListenTo {
    return Intl.message(
      'Listen to your Favorite podcasts',
      name: 'ListenTo',
      desc: '',
      args: [],
    );
  }

  /// `Recently Played :`
  String get Recently {
    return Intl.message(
      'Recently Played :',
      name: 'Recently',
      desc: '',
      args: [],
    );
  }

  /// `Podcast Details`
  String get PodcastDetails {
    return Intl.message(
      'Podcast Details',
      name: 'PodcastDetails',
      desc: '',
      args: [],
    );
  }

  /// `Followed`
  String get Followed {
    return Intl.message(
      'Followed',
      name: 'Followed',
      desc: '',
      args: [],
    );
  }

  /// `Follow`
  String get Follow {
    return Intl.message(
      'Follow',
      name: 'Follow',
      desc: '',
      args: [],
    );
  }

  /// `Podcast Player`
  String get PodcastPlayer {
    return Intl.message(
      'Podcast Player',
      name: 'PodcastPlayer',
      desc: '',
      args: [],
    );
  }

  /// `by`
  String get by {
    return Intl.message(
      'by',
      name: 'by',
      desc: '',
      args: [],
    );
  }

  /// `Add your\npodcast details`
  String get AddPodcastDetails {
    return Intl.message(
      'Add your\npodcast details',
      name: 'AddPodcastDetails',
      desc: '',
      args: [],
    );
  }

  /// `Add the podcast title`
  String get podcastAddTitle {
    return Intl.message(
      'Add the podcast title',
      name: 'podcastAddTitle',
      desc: '',
      args: [],
    );
  }

  /// `Podcast title`
  String get PodcastTitle {
    return Intl.message(
      'Podcast title',
      name: 'PodcastTitle',
      desc: '',
      args: [],
    );
  }

  /// `Content`
  String get Content {
    return Intl.message(
      'Content',
      name: 'Content',
      desc: '',
      args: [],
    );
  }

  /// `Tags`
  String get Tags {
    return Intl.message(
      'Tags',
      name: 'Tags',
      desc: '',
      args: [],
    );
  }

  /// `Your podcast Uploaded Successfully`
  String get UploadedSuccessfully {
    return Intl.message(
      'Your podcast Uploaded Successfully',
      name: 'UploadedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `The podcast didn't upload, please try again.`
  String get didnotUploaded {
    return Intl.message(
      'The podcast didn\'t upload, please try again.',
      name: 'didnotUploaded',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get Next {
    return Intl.message(
      'Next',
      name: 'Next',
      desc: '',
      args: [],
    );
  }

  /// `Rate and review :`
  String get RateAndReview {
    return Intl.message(
      'Rate and review :',
      name: 'RateAndReview',
      desc: '',
      args: [],
    );
  }

  /// `Rating`
  String get Rating {
    return Intl.message(
      'Rating',
      name: 'Rating',
      desc: '',
      args: [],
    );
  }

  /// `Review`
  String get Review {
    return Intl.message(
      'Review',
      name: 'Review',
      desc: '',
      args: [],
    );
  }

  /// `This is the most fantastic podcast..`
  String get ThisTsFantasticPodcast {
    return Intl.message(
      'This is the most fantastic podcast..',
      name: 'ThisTsFantasticPodcast',
      desc: '',
      args: [],
    );
  }

  /// `The review goes successfully`
  String get reviewSuccess {
    return Intl.message(
      'The review goes successfully',
      name: 'reviewSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Post`
  String get Post {
    return Intl.message(
      'Post',
      name: 'Post',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get Cancel {
    return Intl.message(
      'Cancel',
      name: 'Cancel',
      desc: '',
      args: [],
    );
  }

  /// `What Are You Tagging For?`
  String get WhatAreYouTagging {
    return Intl.message(
      'What Are You Tagging For?',
      name: 'WhatAreYouTagging',
      desc: '',
      args: [],
    );
  }

  /// `add your tags`
  String get AddYourTags {
    return Intl.message(
      'add your tags',
      name: 'AddYourTags',
      desc: '',
      args: [],
    );
  }

  /// `Tags Inserted Successfully`
  String get TagsSuccess {
    return Intl.message(
      'Tags Inserted Successfully',
      name: 'TagsSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Tags didn't inserted, please try again.`
  String get TagsFailed {
    return Intl.message(
      'Tags didn\'t inserted, please try again.',
      name: 'TagsFailed',
      desc: '',
      args: [],
    );
  }

  /// `add`
  String get add {
    return Intl.message(
      'add',
      name: 'add',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure about the deleting ?`
  String get AreYouSure {
    return Intl.message(
      'Are you sure about the deleting ?',
      name: 'AreYouSure',
      desc: '',
      args: [],
    );
  }

  /// `deleting success`
  String get deletingSuccess {
    return Intl.message(
      'deleting success',
      name: 'deletingSuccess',
      desc: '',
      args: [],
    );
  }

  /// `deleting failed`
  String get deletingFailed {
    return Intl.message(
      'deleting failed',
      name: 'deletingFailed',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get Yes {
    return Intl.message(
      'Yes',
      name: 'Yes',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong\nplease try again.`
  String get SomethingWentWong {
    return Intl.message(
      'Something went wrong\nplease try again.',
      name: 'SomethingWentWong',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to log out ?`
  String get wantToLogOut {
    return Intl.message(
      'Do you want to log out ?',
      name: 'wantToLogOut',
      desc: '',
      args: [],
    );
  }

  /// `Logout success`
  String get LogoutSuccess {
    return Intl.message(
      'Logout success',
      name: 'LogoutSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Logout failed`
  String get LogoutFailed {
    return Intl.message(
      'Logout failed',
      name: 'LogoutFailed',
      desc: '',
      args: [],
    );
  }

  /// `It looks you don’t have channel yet!`
  String get DonotHaveChannel {
    return Intl.message(
      'It looks you don’t have channel yet!',
      name: 'DonotHaveChannel',
      desc: '',
      args: [],
    );
  }

  /// `please make a channel to start\nposting podcasts`
  String get pleaseMakeChannel {
    return Intl.message(
      'please make a channel to start\nposting podcasts',
      name: 'pleaseMakeChannel',
      desc: '',
      args: [],
    );
  }

  /// `There’s no internet connection`
  String get NoInternetConnection {
    return Intl.message(
      'There’s no internet connection',
      name: 'NoInternetConnection',
      desc: '',
      args: [],
    );
  }

  /// `do you want to change channel image ?`
  String get changeChannelImage {
    return Intl.message(
      'do you want to change channel image ?',
      name: 'changeChannelImage',
      desc: '',
      args: [],
    );
  }

  /// `updating success`
  String get updatingSuccess {
    return Intl.message(
      'updating success',
      name: 'updatingSuccess',
      desc: '',
      args: [],
    );
  }

  /// `updating failed`
  String get updatingFailed {
    return Intl.message(
      'updating failed',
      name: 'updatingFailed',
      desc: '',
      args: [],
    );
  }

  /// `It looks you didn’t sign up yet!`
  String get DidnotSignUp {
    return Intl.message(
      'It looks you didn’t sign up yet!',
      name: 'DidnotSignUp',
      desc: '',
      args: [],
    );
  }

  /// `please sign up to start\nusing our app`
  String get PleaseSignUp {
    return Intl.message(
      'please sign up to start\nusing our app',
      name: 'PleaseSignUp',
      desc: '',
      args: [],
    );
  }

  /// `Select your app langauge :`
  String get SelectAppLangauge {
    return Intl.message(
      'Select your app langauge :',
      name: 'SelectAppLangauge',
      desc: '',
      args: [],
    );
  }

  /// `Enter here your full name`
  String get enterHereYourFullName {
    return Intl.message(
      'Enter here your full name',
      name: 'enterHereYourFullName',
      desc: '',
      args: [],
    );
  }

  /// `Enter your Email this way example@gmail.com`
  String get enterEmailLikeThis {
    return Intl.message(
      'Enter your Email this way example@gmail.com',
      name: 'enterEmailLikeThis',
      desc: '',
      args: [],
    );
  }

  /// `Enter a password of at least has 8 characters.`
  String get enterPassword {
    return Intl.message(
      'Enter a password of at least has 8 characters.',
      name: 'enterPassword',
      desc: '',
      args: [],
    );
  }

  /// `Confirm the password you entered above.`
  String get confirmYourPassword {
    return Intl.message(
      'Confirm the password you entered above.',
      name: 'confirmYourPassword',
      desc: '',
      args: [],
    );
  }

  /// `If you arleady have an acount press here to login`
  String get ifYouHaveaccout {
    return Intl.message(
      'If you arleady have an acount press here to login',
      name: 'ifYouHaveaccout',
      desc: '',
      args: [],
    );
  }

  /// `Are you going report the podcast ?`
  String get Areyougoingreport {
    return Intl.message(
      'Are you going report the podcast ?',
      name: 'Areyougoingreport',
      desc: '',
      args: [],
    );
  }

  /// `Reported successfully`
  String get reportSuccess {
    return Intl.message(
      'Reported successfully',
      name: 'reportSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Report failed`
  String get reportFailed {
    return Intl.message(
      'Report failed',
      name: 'reportFailed',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get close {
    return Intl.message(
      'Close',
      name: 'close',
      desc: '',
      args: [],
    );
  }

  /// `Write your full name in the current filed`
  String get nameExplain {
    return Intl.message(
      'Write your full name in the current filed',
      name: 'nameExplain',
      desc: '',
      args: [],
    );
  }

  /// `Write your email like this example.com`
  String get emailExplain {
    return Intl.message(
      'Write your email like this example.com',
      name: 'emailExplain',
      desc: '',
      args: [],
    );
  }

  /// `Write a strong password that is at least eight characters long.`
  String get passwordExplain {
    return Intl.message(
      'Write a strong password that is at least eight characters long.',
      name: 'passwordExplain',
      desc: '',
      args: [],
    );
  }

  /// `rewrite your password correctly`
  String get confirmpasswordExplian {
    return Intl.message(
      'rewrite your password correctly',
      name: 'confirmpasswordExplian',
      desc: '',
      args: [],
    );
  }

  /// `The password does not match.`
  String get passwordDoesnotMatch {
    return Intl.message(
      'The password does not match.',
      name: 'passwordDoesnotMatch',
      desc: '',
      args: [],
    );
  }

  /// `please choose your channel image`
  String get chooseimage {
    return Intl.message(
      'please choose your channel image',
      name: 'chooseimage',
      desc: '',
      args: [],
    );
  }

  /// `write the channel name`
  String get writechannelName {
    return Intl.message(
      'write the channel name',
      name: 'writechannelName',
      desc: '',
      args: [],
    );
  }

  /// `write the description for the channel`
  String get writedescription {
    return Intl.message(
      'write the description for the channel',
      name: 'writedescription',
      desc: '',
      args: [],
    );
  }

  /// `write a comment so you can rate the podcast`
  String get writeComment {
    return Intl.message(
      'write a comment so you can rate the podcast',
      name: 'writeComment',
      desc: '',
      args: [],
    );
  }

  /// `Publish podcasts so the channel doesn't get\ndeleted by the admin`
  String get postingpodcast {
    return Intl.message(
      'Publish podcasts so the channel doesn\'t get\ndeleted by the admin',
      name: 'postingpodcast',
      desc: '',
      args: [],
    );
  }

  /// `It seem that your channel has been\ndeleted by the admin`
  String get itseemchanneldeleted {
    return Intl.message(
      'It seem that your channel has been\ndeleted by the admin',
      name: 'itseemchanneldeleted',
      desc: '',
      args: [],
    );
  }

  /// `Please make a new one.`
  String get pleasemakenewone {
    return Intl.message(
      'Please make a new one.',
      name: 'pleasemakenewone',
      desc: '',
      args: [],
    );
  }

  /// `The channel is not approved yet! you can't publich podcasts`
  String get channelDidnotApproved {
    return Intl.message(
      'The channel is not approved yet! you can\'t publich podcasts',
      name: 'channelDidnotApproved',
      desc: '',
      args: [],
    );
  }

  /// `You forgot to choose the content`
  String get chooseContent {
    return Intl.message(
      'You forgot to choose the content',
      name: 'chooseContent',
      desc: '',
      args: [],
    );
  }

  /// `Check if you\nalready own a channel`
  String get checkifyouhave {
    return Intl.message(
      'Check if you\nalready own a channel',
      name: 'checkifyouhave',
      desc: '',
      args: [],
    );
  }

  /// `It seems you don’t have a channel`
  String get youhavenoChannel {
    return Intl.message(
      'It seems you don’t have a channel',
      name: 'youhavenoChannel',
      desc: '',
      args: [],
    );
  }

  /// `You do have a channel`
  String get youDoHaveChannel {
    return Intl.message(
      'You do have a channel',
      name: 'youDoHaveChannel',
      desc: '',
      args: [],
    );
  }

  /// `Move to channel`
  String get MoveToChannel {
    return Intl.message(
      'Move to channel',
      name: 'MoveToChannel',
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
      Locale.fromSubtags(languageCode: 'ar'),
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

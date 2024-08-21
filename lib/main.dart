import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mahatacast/core/constants/colors.dart';
import 'package:mahatacast/core/localization-provider/localization.dart';
import 'package:mahatacast/features/auth/bloc/auth_bloc.dart';
import 'package:mahatacast/features/explore/bloc/explore_bloc.dart';
import 'package:mahatacast/features/home/blocs/audio-cubit/audio_cubit.dart';
import 'package:mahatacast/features/home/blocs/home-bloc/home_bloc.dart';
import 'package:mahatacast/features/home/blocs/podcast-bloc/podcast_bloc.dart';
import 'package:mahatacast/features/home/blocs/record-cubit/record_cubit.dart';
import 'package:mahatacast/features/intro/pages/splash_page.dart';
import 'package:mahatacast/features/library/bloc/library_bloc.dart';
import 'package:mahatacast/features/library/presentation/pages/notification_page.dart';
import 'package:mahatacast/features/profile/blocs/channel-bloc/channel_bloc.dart';
import 'package:mahatacast/features/profile/blocs/profile-bloc/profile_bloc.dart';
import 'package:mahatacast/firebase_options.dart';
import 'package:mahatacast/generated/l10n.dart';
import 'package:mahatacast/services/firebase_api.dart';
import 'package:provider/provider.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await NotificationUtils().configuration();
  FirebaseMessaging.onBackgroundMessage(NotificationUtils.listenToNotification);

  await FlutterDownloader.initialize(
    debug: true,
    ignoreSsl: true,
  );
  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (context) => AuthBloc(),
    ),
    BlocProvider(
      create: (context) => HomeBloc(),
    ),
    BlocProvider(
      create: (context) => PodcastBloc(),
    ),
    BlocProvider(
      create: (context) => ChannelBloc(),
    ),
    BlocProvider(
      create: (context) => ExploreBloc(),
    ),
    BlocProvider(
      create: (context) => LibraryBloc(),
    ),
    BlocProvider(
      create: (context) => ProfileBloc(),
    ),
    BlocProvider<AudioCubit>(
      create: (context) => AudioCubit(),
    ),
    BlocProvider<RecordCubit>(
      create: (context) => RecordCubit(),
    ),
    Provider<LocaleNotifier>(
      create: (context) => LocaleNotifier(),
    ),
  ], child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) => ChangeNotifierProvider(
        create: (context) => LocaleNotifier(),
        builder: (context, child) => MaterialApp(
          locale: Provider.of<LocaleNotifier>(context).local,
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          debugShowCheckedModeBanner: false,
          builder: BotToastInit(),
          theme: ThemeData(
              scaffoldBackgroundColor: backgoundColor,
              fontFamily: Provider.of<LocaleNotifier>(context).isArabic
                  ? 'Cairo'
                  : 'Outfit'),
          home: const SplashPage(),
          routes: {
            'notification_page': (context) => const NotificationPage(),
          },
        ),
      ),
    );
  }
}

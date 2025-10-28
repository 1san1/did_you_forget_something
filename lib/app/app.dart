import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:did_you_forget_something/app/controllers/theme_controller.dart';
import 'package:did_you_forget_something/app/theme.dart';
import 'package:did_you_forget_something/app/view/app_shell.dart';

class DidYouForgetSomethingApp extends ConsumerWidget {
  const DidYouForgetSomethingApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeControllerProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Did You Forget Something?',
      theme: buildLightTheme(),
      darkTheme: buildDarkTheme(),
      themeMode: themeMode,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en')],
      home: const AppShell(),
    );
  }
}

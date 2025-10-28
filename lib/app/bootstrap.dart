import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:did_you_forget_something/app/app.dart';
import 'package:did_you_forget_something/shared/services/local_storage_service.dart';

Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();

  final localStorage = await LocalStorageService.init();

  final container = ProviderContainer(
    overrides: [
      localStorageServiceProvider.overrideWithValue(localStorage),
    ],
  );

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const DidYouForgetSomethingApp(),
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_nectia/settings/router/app_router.dart';
import 'package:front_nectia/settings/theme/app_theme.dart';

void main() => runApp(const ProviderScope(child: MyApp()));

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRouter = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'PT Nectia By CGV',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.myTheme,
      routerConfig: appRouter,
    );
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:front_nectia/features/common/views/page_not_found_screen.dart';
import 'package:front_nectia/features/providers.dart';
import 'package:front_nectia/features/views.dart';
import 'package:go_router/go_router.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authProvider);
  final authChangeNotifier = ref.watch(authChangeProvider);

  return GoRouter(
    initialLocation: '/login',
    refreshListenable: authChangeNotifier,
    redirect: (context, state) {
      final loggedIn = authState.user != null;
      final loggingIn = state.fullPath == '/login';

      if (!loggedIn && !loggingIn) return '/login';
      if (loggedIn && loggingIn) return '/vehicles';

      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/vehicles',
        builder: (context, state) => const VehiclesScreen(),
      ),
      GoRoute(
        path: '/vehicles/create',
        builder: (context, state) => const VehiclesScreen(),
      ),
    ],
    errorBuilder: (context, state) {
      return PageNotFoundScreen(route: state.fullPath ?? '');
    },
  );
});

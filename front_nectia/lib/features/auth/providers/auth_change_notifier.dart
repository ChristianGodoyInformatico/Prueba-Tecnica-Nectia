import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_nectia/features/auth/providers/auth_provider.dart';


class AuthChange extends ChangeNotifier {
  final Ref ref;

AuthChange(this.ref) {
    ref.listen<AuthState>(
      authProvider,
      (previous, next) {
        notifyListeners();
      },
    );
  }
}

final authChangeProvider = Provider<AuthChange>((ref) {
  return AuthChange(ref);
});

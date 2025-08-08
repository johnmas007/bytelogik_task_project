import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AuthStatus { loading, idle }

final authStateProvider = StateProvider<AuthStatus>((ref) => AuthStatus.idle);

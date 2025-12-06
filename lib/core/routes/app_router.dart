import 'package:go_router/go_router.dart';
import 'package:target/core/injection/injection_container.dart';
import 'package:target/core/services/session_service.dart';
import 'package:target/modules/auth/presentation/pages/login/login_page.dart';
import 'package:target/modules/listing/presentation/pages/listing_page.dart';
import 'package:target/shared/pages/privacy_policy/privacy_policy_page.dart';

final appRouter = GoRouter(
  initialLocation: '/login',
  redirect: (context, state) {
    final sessionService = getIt<SessionService>();
    final isLoggedIn = sessionService.hasActiveSession();
    final isGoingToLogin = state.matchedLocation == '/login';
    final isGoingToPrivacyPolicy = state.matchedLocation == '/privacy-policy';
    if (isLoggedIn && isGoingToLogin) {
      return '/listing-page';
    }

    // Se o usuário não está logado e tentando acessar uma rota protegida, redireciona para login
    if (!isLoggedIn && !isGoingToLogin && !isGoingToPrivacyPolicy) {
      return '/login';
    }

    return null; // Não redireciona
  },
  routes: [
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/privacy-policy',
      name: 'privacy-policy',
      builder: (context, state) => const PrivacyPolicyPage(),
    ),
    GoRoute(
      path: '/listing-page',
      name: 'listing-page',
      builder: (context, state) => const ListingPage(),
    ),
  ],
);

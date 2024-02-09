import 'dart:io';

import '../../pages/change_language/change_language_page.dart';
import '../../pages/search_page/search_page.dart';
import '../../pages/update_profil/update_profile_page.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../domain/entities/movie.dart';
import '../../../domain/entities/movie_detail.dart';
import '../../../domain/entities/transaction.dart';
import '../../pages/booking_confirmation/booking_confirmation_page.dart';
import '../../pages/change_password_page/change_password_page.dart';
import '../../pages/detail_page/detail_page.dart';
import '../../pages/forgot_password_page/forgot_password_page.dart';
import '../../pages/login_page/login_page.dart';
import '../../pages/main_page/main_page.dart';
import '../../pages/register_page/register_page.dart';
import '../../pages/seat_booking_page/seat_booking_page.dart';
import '../../pages/time_booking_page/time_booking_page.dart';
import '../../pages/wallet_page/wallet_page.dart';

part 'router_provider.g.dart';

@Riverpod(keepAlive: true)
Raw<GoRouter> router(RouterRef ref) => GoRouter(routes: [
      GoRoute(
        path: '/main',
        name: 'main',
        builder: (context, state) => MainPage(
            imageFile: state.extra != null ? state.extra as File : null),
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
          path: '/register',
          name: 'register',
          builder: (context, state) => const RegisterPage()),
      GoRoute(
        path: '/detail',
        name: 'detail',
        builder: (context, state) => DetailPage(movie: state.extra as Movie),
      ),
      GoRoute(
        path: '/time_booking',
        name: 'time_booking',
        builder: (context, state) =>
            TimeBookingPage(state.extra as MovieDetail),
      ),
      GoRoute(
        path: '/seat_booking',
        name: 'seat_booking',
        builder: (context, state) =>
            SeatBookingPage(state.extra as (MovieDetail, Transaction)),
      ),
      GoRoute(
        path: '/booking_confirmation',
        name: 'booking_confirmation',
        builder: (context, state) =>
            BookingConfirmationPage(state.extra as (MovieDetail, Transaction)),
      ),
      GoRoute(
        path: '/wallet',
        name: 'wallet',
        builder: (context, state) => const WalletPage(),
      ),
      GoRoute(
        path: '/forgot_password',
        name: 'forgot_password',
        builder: (context, state) => const ForgotPasswordPage(),
      ),
      GoRoute(
        path: '/change_password',
        name: 'change_password',
        builder: (context, state) => const ChangePasswordPage(),
      ),
      GoRoute(
        path: '/update_profile',
        name: 'update_profile',
        builder: (context, state) => const UpdateProfilePage(),
      ),
      GoRoute(
        path: '/change_language',
        name: 'change_language',
        builder: (context, state) => const ChangeLanguagePage(),
      ),
      GoRoute(
        path: '/search',
        name: 'search',
        builder: (context, state) => const SearchPage(),
      ),
    ], initialLocation: '/login', debugLogDiagnostics: false);

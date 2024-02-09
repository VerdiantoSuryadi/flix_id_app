import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../domain/entities/user.dart';
import '../../extensions/build_context_extension.dart';
import '../../providers/router/router_provider.dart';
import '../../providers/user_data/user_data_provider.dart';
import '../../widgets/bottom_nav_bar.dart';
import '../../widgets/bottom_nav_bar_item.dart';
import '../movie_page/movie_page.dart';
import '../profile_page/profile_page.dart';
import '../ticket_page/ticket_page.dart';

class MainPage extends ConsumerStatefulWidget {
  final File? imageFile;
  const MainPage({this.imageFile, super.key});

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  PageController pageController = PageController();
  int selectedPage = 0;
  @override
  void initState() {
    super.initState();
    User? user = ref.read(userDataProvider).valueOrNull;

    if (widget.imageFile != null && user != null) {
      ref
          .read(userDataProvider.notifier)
          .uploadProfilePicture(user: user, imageFile: widget.imageFile!);
    }
    FlutterNativeSplash.remove();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(userDataProvider, (previous, next) {
      if (previous != null && next is AsyncData && next.value == null) {
        ref.read(routerProvider).goNamed('login');
      } else if (next is AsyncError) {
        context.showSnackBar(next.error.toString());
      }
    });
    return Scaffold(
        body: Stack(
      children: [
        PageView(
          controller: pageController,
          onPageChanged: (value) => setState(() {
            selectedPage = value;
            // log((selectedPage == 0).toString());
          }),
          children: const [
            Center(
              child: MoviePage(),
            ),
            Center(
              child: TicketPage(),
            ),
            Center(child: ProfilePage()),
          ],
        ),
        BottomNavBar(
            items: [
              BottomNavBarItem(
                  index: 0,
                  isSelected: selectedPage == 0,
                  title: AppLocalizations.of(context)!.home,
                  image: 'assets/movie.png',
                  selectedImage: 'assets/movie-selected.png'),
              BottomNavBarItem(
                  index: 1,
                  isSelected: selectedPage == 1,
                  title: AppLocalizations.of(context)!.ticket,
                  image: 'assets/ticket.png',
                  selectedImage: 'assets/ticket-selected.png'),
              BottomNavBarItem(
                  index: 2,
                  isSelected: selectedPage == 2,
                  title: AppLocalizations.of(context)!.profile,
                  image: 'assets/profile.png',
                  selectedImage: 'assets/profile-selected.png'),
            ],
            onTap: (index) {
              selectedPage = index;
              // log(index.toString());
              pageController.animateToPage(selectedPage,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut);
            },
            selectedIndex: 0),
      ],
    ));
  }
}

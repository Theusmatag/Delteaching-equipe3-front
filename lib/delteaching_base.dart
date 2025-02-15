import 'package:dealteachingfront/modules/backoffice/home/controller/home_controller.dart';
import 'package:dealteachingfront/services/global_state_service.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'modules/backoffice/home/presenters/home_page.dart';

class DelteachingBase extends StatelessWidget {
  const DelteachingBase({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => HomePageController()),
        ],
        child: MaterialApp(
            navigatorKey: KeyGlobalContext.navigatorKey,
            theme: ThemeData(
                iconTheme: const IconThemeData(color: Colors.white),
                textTheme:
                    GoogleFonts.outfitTextTheme(Typography.whiteCupertino),
                useMaterial3: true),
            scrollBehavior:
                const MaterialScrollBehavior().copyWith(dragDevices: {
              PointerDeviceKind.touch,
              PointerDeviceKind.mouse,
            }),
            debugShowCheckedModeBanner: false,
            routes: {'/': (context) => const HomePage()}));
  }
}

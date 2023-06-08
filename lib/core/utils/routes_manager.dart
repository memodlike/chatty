import 'package:flutter/material.dart';

import '../../features/03_text_completion/presentation/pages/text_completion_page.dart';

import '../../features/01_home/home_page.dart';
import '../../features/02_image_generation/presentation/pages/image_generation_page.dart';
import '../../features/00_splash/splash_screen.dart';
import 'strings_manager.dart';

class Routes {
  static const String splashRoute = '/';
  static const String homeRoute = '/home';
  static const String imageRoute = '/image';
  static const String textRoute = '/text';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );
      case Routes.homeRoute:
        return _buildCustomPageRoute(const HomePage());
      case Routes.imageRoute:
        return _buildCustomPageRoute(const ImageGenerationPage());
      case Routes.textRoute:
        return _buildCustomPageRoute(const TextCompletionPage());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> _buildCustomPageRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOut,
        );

        return FadeTransition(
          opacity: curvedAnimation,
          child: child,
        );
      },
    );
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text(
            AppStrings.noRouteFound,
          ),
        ),
        body: const Center(
          child: Text(
            AppStrings.noRouteFound,
          ),
        ),
      ),
    );
  }
}

//нормальная анимация перехода
// class Routes {
//   static const String splashRoute = '/';
//   static const String homeRoute = '/home';
//   static const String imageRoute = '/image';
//   static const String textRoute = '/text';
//   static const String chatRoute = '/chat';
// }

// class RouteGenerator {
//   static Route<dynamic> getRoute(RouteSettings settings) {
//     switch (settings.name) {
//       case Routes.splashRoute:
//         return MaterialPageRoute(
//           builder: (_) => const SplashScreen(),
//         );
//       case Routes.homeRoute:
//         return _buildCustomPageRoute(const HomePage());
//       case Routes.imageRoute:
//         return _buildCustomPageRoute(const ImageGenerationPage());
//       case Routes.textRoute:
//         return _buildCustomPageRoute(const TextCompletionPage());
//       case Routes.chatRoute:
//         return _buildCustomPageRoute(const ChatPage());
//       default:
//         return unDefinedRoute();
//     }
//   }

//   static Route<dynamic> _buildCustomPageRoute(Widget page) {
//     return PageRouteBuilder(
//       pageBuilder: (context, animation, secondaryAnimation) => page,
//       transitionsBuilder: (context, animation, secondaryAnimation, child) {
//         return FadeTransition(
//           opacity: animation,
//           child: child,
//         );
//       },
//     );
//   }

//   static Route<dynamic> unDefinedRoute() {
//     return MaterialPageRoute(
//       builder: (_) => Scaffold(
//         appBar: AppBar(
//           title: const Text(
//             AppStrings.noRouteFound,
//           ),
//         ),
//         body: const Center(
//           child: Text(
//             AppStrings.noRouteFound,
//           ),
//         ),
//       ),
//     );
//   }
// }

//обычная переход так сказать по умалчанию
// class Routes {
//   static const String splashRoute = '/';
//   static const String homeRoute = '/home';
//   static const String imageRoute = '/image';
//   static const String textRoute = '/text';
//   static const String chatRoute = '/chat';
// }

// class RouteGenerator {
//   static Route<dynamic> getRoute(RouteSettings settings) {
//     switch (settings.name) {
//       case Routes.splashRoute:
//         return MaterialPageRoute(
//           builder: (_) => const SplashScreen(),
//         );
//         case Routes.homeRoute:
//         return MaterialPageRoute(
//           builder: (_) => const HomePage(),
//         );
//         case Routes.imageRoute:
//         return MaterialPageRoute(
//           builder: (_) => const ImageGenerationPage(),
//         );
//                 case Routes.textRoute:
//         return MaterialPageRoute(
//           builder: (_) => const TextCompletionPage(),
//         );
//         case Routes.chatRoute:
//         return MaterialPageRoute(
//           builder: (_) => const ChatPage(),
//         );

      
//       default:
//         return unDefinedRoute();
//     }
//   }

//   static Route<dynamic> unDefinedRoute() {
//     return MaterialPageRoute(
//       builder: (_) => Scaffold(
//         appBar: AppBar(
//           title: const Text(
//             AppStrings.noRouteFound,
//           ),
//         ),
//         body: const Center(
//           child: Text(
//             AppStrings.noRouteFound,
//           ),
//         ),
//       ),
//     );
//   }
// }

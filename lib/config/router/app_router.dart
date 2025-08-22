import 'package:go_router/go_router.dart';

import 'package:gemini_app/modules/chat/presentation/screens/screens.dart';
import 'package:gemini_app/modules/home/presentation/screens/screens.dart';
import 'package:gemini_app/modules/pokemon_game/presentation/screens/screens.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
    GoRoute(
      path: '/basic-prompt',
      builder: (context, state) => const BasicPromptScreen(),
    ),
    GoRoute(
      path: '/chat-stream',
      builder: (context, state) => const ChatContextScreen(),
    ),
    GoRoute(
      path: '/image-generation',
      builder: (context, state) => const ImagePlaygroundScreen(),
    ),
    GoRoute(
      path: '/pokemon',
      builder: (context, state) => const PokemonGameScreen(),
    ),
  ],
);

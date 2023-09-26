import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:role/features/new_evento/providers/new_evento_provider.dart';
import 'package:role/models/evento_theme.dart';
import 'package:role/shared/widgets/elastic_button.dart';
import 'package:role/shared/widgets/round_button.dart';

class NewEventoTheme extends StatefulWidget {
  @override
  _NewEventoThemeState createState() => _NewEventoThemeState();
}

class _NewEventoThemeState extends State<NewEventoTheme> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<NewEventoProvider>(
      builder: (context, provider, child) {
        return Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              Row(
                children: [
                  Text(
                    "agora, escolha um tema",
                    style: TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -1.5,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 400,
                child: SquareGrid(),
              ),
              SizedBox(height: 24.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: RoundButton(
                  text: "criar",
                  onPressed: () {
                    provider.create();
                  },
                  // onPressed: onSubmit,
                ),
              ),
              Spacer(),
            ],
          ),
        );
      },
    );
  }
}

class SquareGrid extends StatelessWidget {
  SquareGrid({Key? key}) : super(key: key);

  final List<EventoTheme> defaultThemes = [
    EventoTheme(
        emoji: '🎄',
        color1: Color.fromRGBO(208, 2, 13, 1),
        color2: Color.fromRGBO(253, 33, 44, 1)),
    EventoTheme(
        emoji: '🎉',
        color1: Color.fromRGBO(215, 176, 182, 1),
        color2: Color.fromRGBO(200, 164, 169, 1)),
    EventoTheme(
        emoji: '🍿',
        color1: Color.fromRGBO(244, 143, 42, 1),
        color2: Color.fromRGBO(255, 194, 128, 1)),
    EventoTheme(
        emoji: '🏕️',
        color1: Color.fromRGBO(235, 134, 71, 1),
        color2: Color.fromRGBO(184, 83, 20, 1)),
    EventoTheme(
        emoji: '🎡',
        color1: Color.fromRGBO(255, 236, 64, 1),
        color2: Color.fromRGBO(252, 243, 118, 1)),
    EventoTheme(
        emoji: '🏟️',
        color1: Color.fromRGBO(255, 192, 0, 1),
        color2: Color.fromRGBO(255, 209, 71, 1)),
    EventoTheme(
        emoji: '🎮',
        color1: Color.fromRGBO(60, 170, 9, 1),
        color2: Color.fromRGBO(88, 221, 110, 1)),
    EventoTheme(
        emoji: '🎆',
        color1: Color.fromRGBO(51, 132, 80, 1),
        color2: Color.fromRGBO(69, 176, 106, 1)),
    EventoTheme(
        emoji: '🥩',
        color1: Color.fromRGBO(207, 155, 96, 1),
        color2: Color.fromRGBO(199, 126, 58, 1)),
    EventoTheme(
        emoji: '🌱',
        color1: Color.fromRGBO(0, 53, 27, 1),
        color2: Color.fromRGBO(8, 43, 0, 1)),
    EventoTheme(
        emoji: '✨',
        color1: Color.fromRGBO(203, 186, 0, 1),
        color2: Color.fromRGBO(197, 141, 0, 1)),
    EventoTheme(
        emoji: '🏖️',
        color1: Color.fromRGBO(0, 137, 255, 1),
        color2: Color.fromRGBO(27, 186, 238, 1)),
    EventoTheme(
        emoji: '🎃',
        color1: Color.fromRGBO(177, 69, 177, 1),
        color2: Color.fromRGBO(114, 9, 119, 1)),
    EventoTheme(
        emoji: '🪩',
        color1: Color.fromRGBO(241, 242, 255, 1),
        color2: Color.fromRGBO(228, 225, 255, 1)),
    EventoTheme(
        emoji: '🎂',
        color1: Color.fromRGBO(255, 241, 250, 1),
        color2: Color.fromRGBO(239, 214, 221, 1)),
    EventoTheme(
        emoji: '🎁',
        color1: Color.fromRGBO(244, 126, 103, 1),
        color2: Color.fromRGBO(239, 46, 88, 1)),
  ];

  @override
  Widget build(BuildContext context) {
    final spacing = 8.0;

    return Container(
      padding: EdgeInsets.all(spacing),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 1,
          mainAxisSpacing: spacing,
          crossAxisSpacing: spacing,
        ),
        primary: false,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: defaultThemes.length,
        itemBuilder: (context, index) {
          final theme = defaultThemes[index];
          return ThemeGridItem(theme: theme);
        },
      ),
    );
  }
}

class ThemeGridItem extends StatelessWidget {
  const ThemeGridItem({super.key, required this.theme});

  final EventoTheme theme;

  @override
  Widget build(BuildContext context) {
    return Consumer<NewEventoProvider>(builder: (context, provider, child) {
      bool selected = provider.evento.theme.emoji == theme.emoji;

      return ElasticButton(
        onTap: () {
          provider.setTheme(theme);
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: selected
                  ? LinearGradient(
                      colors: [theme.color1, theme.color2],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                  : null,
              color: selected
                  ? CupertinoColors.white
                  : CupertinoDynamicColor.resolve(
                      CupertinoColors.quaternarySystemFill, context)),
          child: Center(
            child: Text(
              theme.emoji,
              style: TextStyle(
                  color: CupertinoColors.white, fontSize: selected ? 36 : 28),
            ),
          ),
        ),
      );
    });
  }
}

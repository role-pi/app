import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:role/features/new_evento/providers/new_evento_provider.dart';
import 'package:role/models/evento.dart';
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
        emoji: '🎮',
        color1: Color.fromRGBO(3, 119, 88, 1),
        color2: Color.fromRGBO(6, 214, 160, 1)),
    EventoTheme(
        emoji: '🎉',
        color1: Color.fromRGBO(255, 31, 68, 1),
        color2: Color.fromRGBO(255, 74, 98, 1)),
    EventoTheme(
        emoji: '🥩',
        color1: Color.fromRGBO(255, 192, 0, 1),
        color2: Color.fromRGBO(255, 209, 71, 1)),
    EventoTheme(
        emoji: '🏖️',
        color1: Color.fromRGBO(0, 137, 255, 1),
        color2: Color.fromRGBO(27, 186, 238, 1)),
    EventoTheme(
        emoji: '🎆',
        color1: Color.fromRGBO(0, 204, 31, 1),
        color2: Color.fromRGBO(112, 255, 117, 1)),
    EventoTheme(
        emoji: '🎂',
        color1: Color.fromRGBO(255, 2, 155, 1),
        color2: Color.fromRGBO(255, 115, 188, 1)),
    EventoTheme(
        emoji: '🎄',
        color1: Color.fromRGBO(208, 2, 13, 1),
        color2: Color.fromRGBO(253, 33, 44, 1)),
    EventoTheme(
        emoji: '🎃',
        color1: Color.fromRGBO(177, 69, 177, 1),
        color2: Color.fromRGBO(56, 2, 59, 1)),
    EventoTheme(
        emoji: '🎁',
        color1: Color.fromRGBO(51, 132, 80, 1),
        color2: Color.fromRGBO(69, 176, 106, 1)),
    EventoTheme(
        emoji: '✨',
        color1: Color.fromRGBO(244, 103, 134, 1),
        color2: Color.fromRGBO(239, 46, 88, 1)),
    EventoTheme(
        emoji: '🪩',
        color1: Color.fromRGBO(120, 161, 187, 1),
        color2: Color.fromRGBO(75, 121, 149, 1)),
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
                          CupertinoColors.systemGrey5, context)
                      .withOpacity(0.5)),
          child: Center(
            child: Text(
              theme.emoji,
              style: TextStyle(color: CupertinoColors.white, fontSize: 32),
            ),
          ),
        ),
      );
    });
  }
}

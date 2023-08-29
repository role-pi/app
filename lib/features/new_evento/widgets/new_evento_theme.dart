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
    EventoTheme(emoji: '🎉', color1: Colors.red, color2: Colors.yellow),
    EventoTheme(emoji: '🎊', color1: Colors.blue, color2: Colors.green),
    EventoTheme(emoji: '🎈', color1: Colors.purple, color2: Colors.pink),
    EventoTheme(emoji: '🎁', color1: Colors.green, color2: Colors.orange),
    EventoTheme(emoji: '🎂', color1: Colors.pink, color2: Colors.purple),
    EventoTheme(emoji: '🎄', color1: Colors.green, color2: Colors.red),
    EventoTheme(emoji: '🎃', color1: Colors.orange, color2: Colors.black),
    EventoTheme(emoji: '🎆', color1: Colors.blue, color2: Colors.purple),
    EventoTheme(emoji: '✨', color1: Colors.yellow, color2: Colors.white),
    EventoTheme(emoji: '🪩', color1: Colors.grey, color2: Colors.blue),
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

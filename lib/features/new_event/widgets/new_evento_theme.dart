import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:role/features/new_event/providers/new_evento_provider.dart';
import 'package:role/features/new_event/screens/emoji_evento_screen.dart';
import 'package:role/models/evento.dart';
import 'package:role/models/evento_theme.dart';
import 'package:role/shared/widgets/big_form_text_field.dart';
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
      builder: (context, value, child) {
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
                      color: CupertinoColors.black.withOpacity(0.8),
                    ),
                  )
                ],
              ),
              SingleChildScrollView(
                child: SizedBox(
                  child: SquareGrid(
                    event: value.evento,
                  ),
                ),
              ),
              SizedBox(height: 24.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: RoundButton(
                  text: "criar",
                  rectangleColor: CupertinoColors.black.withOpacity(0.8),
                  onPressed: () {
                    value.create();
                  },
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
  final Evento event;

  SquareGrid({Key? key, required this.event}) : super(key: key);

  final List<EventoTheme> defaultThemes = [
    EventoTheme(emoji: "😀", color1: Colors.blue, color2: Colors.lightBlue),
    EventoTheme(emoji: "🌞", color1: Colors.yellow, color2: Colors.orange),
    EventoTheme(emoji: "🌈", color1: Colors.red, color2: Colors.purple),
    EventoTheme(emoji: "🍀", color1: Colors.green, color2: Colors.teal),
    EventoTheme(emoji: "🌻", color1: Colors.yellow, color2: Colors.green),
    EventoTheme(emoji: "🍊", color1: Colors.orange, color2: Colors.red),
    EventoTheme(emoji: "🌸", color1: Colors.pink, color2: Colors.purple),
    EventoTheme(emoji: "🌊", color1: Colors.blue, color2: Colors.cyan),
    EventoTheme(emoji: "🌲", color1: Colors.green, color2: Colors.brown),
    EventoTheme(emoji: "🍇", color1: Colors.purple, color2: Colors.pink),
    EventoTheme(emoji: "🍋", color1: Colors.yellow, color2: Colors.green),
    EventoTheme(emoji: "🍓", color1: Colors.red, color2: Colors.pink),
    EventoTheme(emoji: "🍉", color1: Colors.red, color2: Colors.green),
    EventoTheme(emoji: "🌼", color1: Colors.yellow, color2: Colors.orange),
    EventoTheme(emoji: "🌱", color1: Colors.green, color2: Colors.lightGreen),
    EventoTheme(emoji: "🌔", color1: Colors.grey, color2: Colors.white),
  ];

  @override
  Widget build(BuildContext context) {
    final spacing = 8.0;
    final columns = 4;

    return Container(
      padding: EdgeInsets.all(spacing),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: columns,
          childAspectRatio: 1,
          mainAxisSpacing: spacing,
          crossAxisSpacing: spacing,
        ),
        itemCount: defaultThemes.length,
        itemBuilder: (context, index) {
          final theme = defaultThemes[index];
          return ThemeGridItem(theme: theme, event: event);
        },
      ),
    );
  }
}

class ThemeGridItem extends StatelessWidget {
  const ThemeGridItem({super.key, required this.theme, required this.event});

  final Evento event;
  final EventoTheme theme;

  @override
  Widget build(BuildContext context) {
    NewEventoProvider _newEventoProvider =
        Provider.of<NewEventoProvider>(context, listen: false);

    return ElasticButton(
      onTap: () {
        _newEventoProvider.setTheme(theme);
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: event.theme == theme
                ? LinearGradient(
                    colors: [theme.color1, theme.color2],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : null,
            color: CupertinoColors.white.withOpacity(0.25)),
        child: Center(
          child: Text(
            theme.emoji,
            style: TextStyle(color: CupertinoColors.white, fontSize: 32),
          ),
        ),
      ),
    );
  }
}

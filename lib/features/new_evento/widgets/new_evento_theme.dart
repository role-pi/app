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
        emoji: '🎉   ',
        color1: Color.fromRGBO(245, 66, 93, 1),
        color2: Color.fromRGBO(221, 107, 122, 1)),
    EventoTheme(
        emoji: '🍿',
        color1: Color.fromRGBO(255, 132, 9, 1),
        color2: Color.fromRGBO(255, 194, 128, 1)),
    EventoTheme(
        emoji: '🏕️',
        color1: Color.fromRGBO(189, 108, 57, 1),
        color2: Color.fromRGBO(94, 43, 11, 1)),
    EventoTheme(
        emoji: '🎡',
        color1: Color.fromRGBO(247, 223, 14, 1),
        color2: Color.fromRGBO(182, 176, 90, 1)),
    EventoTheme(
        emoji: '🏟️',
        color1: Color.fromRGBO(255, 191, 1, 1),
        color2: Color.fromRGBO(214, 188, 111, 1)),
    EventoTheme(
        emoji: '🎮',
        color1: Color.fromRGBO(43, 128, 3, 1),
        color2: Color.fromRGBO(115, 233, 135, 1)),
    EventoTheme(
        emoji: '🎆',
        color1: Color.fromRGBO(42, 194, 95, 1),
        color2: Color.fromRGBO(137, 226, 168, 1)),
    EventoTheme(
        emoji: '🥩',
        color1: Color.fromRGBO(123, 235, 216, 1),
        color2: Color.fromRGBO(63, 131, 125, 1)),
    EventoTheme(
        emoji: '🌱',
        color1: Color.fromRGBO(106, 186, 252, 1),
        color2: Color.fromRGBO(1, 42, 126, 1)),
    EventoTheme(
        emoji: '✨',
        color1: Color.fromRGBO(81, 162, 255, 1),
        color2: Color.fromRGBO(11, 82, 129, 1)),
    EventoTheme(
        emoji: '🏖️',
        color1: Color.fromRGBO(1, 120, 224, 1),
        color2: Color.fromRGBO(27, 186, 238, 1)),
    EventoTheme(
        emoji: '🎃',
        color1: Color.fromRGBO(177, 69, 177, 1),
        color2: Color.fromRGBO(114, 9, 119, 1)),
    EventoTheme(
        emoji: '🪩',
        color1: Color.fromRGBO(121, 16, 190, 1),
        color2: Color.fromRGBO(164, 88, 226, 1)),
    EventoTheme(
        emoji: '🎂',
        color1: Color.fromRGBO(243, 28, 168, 1),
        color2: Color.fromRGBO(224, 107, 141, 1)),
    EventoTheme(
        emoji: '🎁',
        color1: Color.fromRGBO(236, 104, 159, 1),
        color2: Color.fromRGBO(241, 16, 65, 1)),
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

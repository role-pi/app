import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:role/features/new_event/providers/new_event_provider.dart';
import 'package:role/models/event_theme.dart';
import 'package:role/shared/widgets/elastic_button.dart';
import 'package:role/shared/widgets/round_button.dart';

class NewEventTheme extends StatefulWidget {
  @override
  _NewEventThemeState createState() => _NewEventThemeState();
}

class _NewEventThemeState extends State<NewEventTheme> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<NewEventProvider>(
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

  final List<EventTheme> defaultThemes = [
    EventTheme(
        emoji: '🎄',
        color1: Color.fromRGBO(208, 2, 13, 1),
        color2: Color.fromRGBO(219, 86, 93, 1)),
    EventTheme(
        emoji: '🎉',
        color1: Color.fromRGBO(143, 34, 50, 1),
        color2: Color.fromRGBO(209, 137, 147, 1)),
    EventTheme(
        emoji: '🍿',
        color1: Color.fromRGBO(248, 124, 0, 1),
        color2: Color.fromRGBO(255, 194, 128, 1)),
    EventTheme(
        emoji: '🏕️',
        color1: Color.fromRGBO(175, 126, 95, 1),
        color2: Color.fromRGBO(94, 43, 11, 1)),
    EventTheme(
        emoji: '🎡',
        color1: Color.fromRGBO(255, 230, 0, 1),
        color2: Color.fromRGBO(243, 239, 183, 1)),
    EventTheme(
        emoji: '🏟️',
        color1: Color.fromRGBO(240, 220, 162, 1),
        color2: Color.fromRGBO(255, 191, 0, 1)),
    EventTheme(
        emoji: '🎮',
        color1: Color.fromRGBO(22, 68, 1, 1),
        color2: Color.fromRGBO(132, 241, 150, 1)),
    EventTheme(
        emoji: '🎆',
        color1: Color.fromRGBO(25, 204, 2, 1),
        color2: Color.fromRGBO(113, 179, 129, 1)),
    EventTheme(
        emoji: '🌱',
        color1: Color.fromRGBO(0, 119, 255, 1),
        color2: Color.fromRGBO(119, 178, 255, 1)),
    EventTheme(
        emoji: '🥩',
        color1: Color.fromRGBO(132, 171, 230, 1),
        color2: Color.fromRGBO(11, 19, 129, 1)),
    EventTheme(
        emoji: '🏖️',
        color1: Color.fromRGBO(0, 136, 255, 1),
        color2: Color.fromRGBO(152, 215, 236, 1)),
    EventTheme(
        emoji: '✨',
        color1: Color.fromRGBO(108, 40, 235, 1),
        color2: Color.fromRGBO(159, 124, 219, 1)),
    EventTheme(
        emoji: '🪩',
        color1: Color.fromRGBO(121, 16, 190, 1),
        color2: Color.fromRGBO(180, 132, 219, 1)),
    EventTheme(
        emoji: '🎃',
        color1: Color.fromRGBO(185, 120, 223, 1),
        color2: Color.fromRGBO(114, 9, 119, 1)),
    EventTheme(
        emoji: '🎂',
        color1: Color.fromRGBO(255, 1, 166, 1),
        color2: Color.fromRGBO(248, 160, 185, 1)),
    EventTheme(
        emoji: '🎁',
        color1: Color.fromRGBO(177, 107, 136, 1),
        color2: Color.fromRGBO(255, 4, 58, 1)),
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

  final EventTheme theme;

  @override
  Widget build(BuildContext context) {
    return Consumer<NewEventProvider>(builder: (context, provider, child) {
      bool selected = provider.event.theme.emoji == theme.emoji;

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

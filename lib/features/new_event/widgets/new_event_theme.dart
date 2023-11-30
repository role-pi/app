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
                    provider.create(context);
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
        emoji: '🥩',
        color1: Color.fromRGBO(129, 80, 11, 1),
        color2: Color.fromRGBO(230, 163, 132, 1)),
    EventTheme(
        emoji: '🍿',
        color1: Color.fromRGBO(248, 153, 0, 1),
        color2: Color.fromRGBO(255, 206, 128, 1)),
    EventTheme(
        emoji: '🎁',
        color1: Color.fromRGBO(255, 4, 58, 1),
        color2: Color.fromRGBO(177, 107, 136, 1)),
    EventTheme(
        emoji: '🎡',
        color1: Color.fromRGBO(123, 0, 255, 1),
        color2: Color.fromRGBO(241, 183, 243, 1)),
    EventTheme(
        emoji: '🎃',
        color1: Color.fromRGBO(185, 120, 223, 1),
        color2: Color.fromRGBO(114, 9, 119, 1)),
    EventTheme(
        emoji: '🏕️',
        color1: Color.fromRGBO(39, 94, 11, 1),
        color2: Color.fromRGBO(168, 175, 95, 1)),
    EventTheme(
        emoji: '🎉',
        color1: Color.fromRGBO(143, 59, 34, 1),
        color2: Color.fromRGBO(209, 179, 137, 1)),
    EventTheme(
        emoji: '✨',
        color1: Color.fromRGBO(121, 172, 172, 1),
        color2: Color.fromRGBO(61, 75, 83, 1)),
    EventTheme(
        emoji: '🏟️',
        color1: Color.fromRGBO(255, 191, 0, 1),
        color2: Color.fromRGBO(240, 220, 162, 1)),
    EventTheme(
        emoji: '🎄',
        color1: Color.fromRGBO(208, 2, 13, 1),
        color2: Color.fromRGBO(219, 86, 86, 1)),
    EventTheme(
        emoji: '🌱',
        color1: Color.fromRGBO(71, 105, 51, 1),
        color2: Color.fromRGBO(46, 74, 44, 1)),
    EventTheme(
        emoji: '🏖️',
        color1: Color.fromRGBO(11, 175, 148, 1),
        color2: Color.fromRGBO(152, 222, 236, 1)),
    EventTheme(
        emoji: '🎮',
        color1: Color.fromRGBO(52, 60, 47, 1),
        color2: Color.fromRGBO(10, 12, 10, 1)),
    EventTheme(
        emoji: '🎂',
        color1: Color.fromRGBO(129, 54, 103, 1),
        color2: Color.fromRGBO(102, 76, 83, 1)),
    EventTheme(
        emoji: '🎆',
        color1: Color.fromRGBO(204, 2, 154, 1),
        color2: Color.fromRGBO(179, 113, 149, 1)),
    EventTheme(
        emoji: '🪩',
        color1: Color.fromRGBO(16, 71, 190, 1),
        color2: Color.fromRGBO(139, 132, 219, 1)),
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
        onPressed: () {
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

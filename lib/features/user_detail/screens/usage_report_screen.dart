import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:role/features/event_list/widgets/event_list.dart';
import 'package:role/features/user_login/providers/user_login_provider.dart';
import 'package:role/models/item.dart';
import 'package:role/shared/utils/utils.dart';
import 'package:role/shared/widgets/container_text.dart';
import 'package:role/shared/widgets/custom_navigation_bar.dart';
import 'package:role/shared/widgets/remote_profile_picture.dart';
import 'package:role/shared/widgets/round_button.dart';
import 'package:share_plus/share_plus.dart';

class UsageReportScreen extends StatelessWidget {
  final int totalEvents;
  final double totalSpent;
  final double averageSpent;
  final ItemCategory category;

  UsageReportScreen(
      {required this.totalEvents,
      required this.totalSpent,
      required this.averageSpent,
      required this.category});

  @override
  Widget build(BuildContext context) {
    TextStyle labelStyle = TextStyle(
        color: CupertinoColors.secondaryLabel.resolveFrom(context),
        fontSize: 25,
        fontWeight: FontWeight.bold,
        letterSpacing: -1.6);

    TextStyle valueStyle = TextStyle(
        color: CupertinoColors.label.resolveFrom(context),
        fontSize: 48,
        fontWeight: FontWeight.bold,
        letterSpacing: -2);

    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemBackground.resolveFrom(context),
      child: Center(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            CustomScrollView(slivers: [
              SliverPersistentHeader(
                pinned: false,
                delegate: UsageReportHeaderDelegate(),
              ),
              SliverToBoxAdapter(
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(25, 30, 15, 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "no total você participou de",
                            style: labelStyle,
                          ),
                          SizedBox(height: 4),
                          Text(
                              "$totalEvents evento${totalEvents == 1 ? "" : "s"}",
                              style: valueStyle),
                          SizedBox(height: 24),
                          Text(
                            "os seus gastos totais foram",
                            style: labelStyle,
                          ),
                          SizedBox(height: 4),
                          Text(formatCurrency(totalSpent), style: valueStyle),
                          SizedBox(height: 4),
                          Text(
                            "${formatCurrency(averageSpent)} em média",
                            style: labelStyle,
                          ),
                          SizedBox(height: 24),
                          Text(
                            "a sua categoria de insumo mais recorrente é",
                            style: labelStyle,
                          ),
                          SizedBox(height: 4),
                          Text(category.emoji + " " + category.name,
                              style: valueStyle),
                          SizedBox(height: 200),
                        ],
                      )))
            ]),
            FadedBackgroundWidget(),
            Padding(
              padding: const EdgeInsets.all(48.0),
              child: SizedBox(
                height: 60,
                child: RoundButton(
                  onPressed: () {
                    Share.share('Compartilhar');
                  },
                  rectangleColor: CupertinoColors.black,
                  textColor: CupertinoColors.white,
                  text: "compartilhar",
                  icon: CupertinoIcons.share,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UsageReportHeaderDelegate extends SliverPersistentHeaderDelegate {
  UsageReportHeaderDelegate();

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return UsageReportHeader();
  }

  @override
  double get minExtent => 360.0;

  @override
  double get maxExtent => 360.0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

class UsageReportHeader extends StatefulWidget {
  const UsageReportHeader({
    super.key,
  });

  @override
  State<UsageReportHeader> createState() => _UsageReportHeaderState();
}

class _UsageReportHeaderState extends State<UsageReportHeader> {
  double hue = 0.0;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(milliseconds: 500), (timer) {
      setState(() {
        hue = (hue + 5) % 360.0;
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            HSLColor.fromAHSL(1.0, hue, 1.0, 0.05).toColor(),
            HSLColor.fromAHSL(1.0, hue, 1.0, 0.15).toColor(),
            HSLColor.fromAHSL(1.0, (hue + 20) % 360.0, 1.0, 0.2).toColor()
          ],
          stops: [0.5, 0.8, 1],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomNavigationBar(
            color: CupertinoColors.white.withOpacity(0.5),
            topPadding: 12,
            leadingIcon: null,
            onPressedLeading: () {
              Navigator.pop(context);
            },
          ),
          Padding(
            padding: const EdgeInsets.all(28.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset("assets/Invertida.png", height: 36),
                    SizedBox(width: 8),
                    Text("wrapped",
                        style: TextStyle(
                            color: CupertinoColors.white,
                            fontSize: 42,
                            fontWeight: FontWeight.bold,
                            letterSpacing: -1.9))
                  ],
                ),
                SizedBox(height: 32),
                Row(
                  children: [
                    Consumer<UserLoginProvider>(
                        builder: (context, provider, child) {
                      return RemoteProfilePicture(
                        url: provider.user?.profilePhoto,
                        size: 64,
                      );
                    }),
                    SizedBox(width: 16),
                    Text(
                        UserLoginProvider.shared.user?.displayName ?? "Usuário",
                        style: TextStyle(
                            color: CupertinoColors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            letterSpacing: -1.9)),
                  ],
                ),
                SizedBox(height: 16),
                ContainerText(text: "membro desde 2023")
              ],
            ),
          ),
        ],
      ),
    );
  }
}

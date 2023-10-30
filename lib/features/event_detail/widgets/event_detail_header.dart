import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:role/features/event_edit/screens/event_edit_screen.dart';
import 'package:role/features/event_detail/providers/event_detail_provider.dart';
import 'package:role/models/event.dart';
import 'package:role/shared/widgets/container_text.dart';
import 'package:role/shared/widgets/gradient_effect.dart';
import 'package:role/shared/widgets/custom_navigation_bar.dart';

class EventDetailHeader extends StatelessWidget {
  const EventDetailHeader({
    super.key,
    required this.event,
  });

  final Event event;

  @override
  Widget build(BuildContext context) {
    EventDetailProvider provider =
        Provider.of<EventDetailProvider>(context, listen: false);

    return ClipPath(
      clipper: _EventDetailHeaderClipper(),
      child: SizedBox(
          child: Container(
              child: GradientWidget(
        color1: event.color1,
        color2: event.color2,
        child: Column(
          children: [
            Opacity(
                opacity: 0.6,
                child: CustomNavigationBar(
                    leadingText: "eventos",
                    trailingIcon: CupertinoIcons.pencil,
                    onPressedLeading: () {
                      Navigator.of(context).pop();
                    },
                    onPressedTrailing: () {
                      Navigator.of(context)
                          .push(CupertinoPageRoute(builder: (context) {
                        return EventEditScreen(provider);
                      }));
                    })),
            Spacer(),
            Padding(
                padding: EdgeInsets.fromLTRB(32, 0, 32, 32),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Row(
                          crossAxisAlignment:
                              provider.event.dateDescription.isEmpty
                                  ? CrossAxisAlignment.center
                                  : CrossAxisAlignment.end,
                          children: [
                            Consumer<EventDetailProvider>(
                              builder: (context, provider, child) {
                                return Expanded(
                                  child: AutoSizeText(
                                    provider.event.name,
                                    style: TextStyle(
                                        fontSize: 52,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: -2.4,
                                        height: 1.0),
                                    maxLines: 2,
                                    wrapWords: false,
                                  ),
                                );
                              },
                            ),
                            SizedBox(width: 28),
                            event.emoji.isNotEmpty
                                ? SizedBox(
                                    // fit: BoxFit.fitWidth,
                                    width: 72,
                                    child: Text(
                                      event.emoji,
                                      style: TextStyle(
                                          fontSize: 72,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                : SizedBox(),
                          ],
                        ),
                      ),
                      Consumer<EventDetailProvider>(
                        builder: (context, provider, child) {
                          if (provider.event.dateDescription.isEmpty)
                            return SizedBox();
                          return Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: ContainerText(
                                text: provider.event.dateDescription),
                          );
                        },
                      ),
                    ]))
          ],
        ),
      ))),
    );
  }
}

class EventDetailHeaderDelegate extends SliverPersistentHeaderDelegate {
  EventDetailHeaderDelegate({required this.event});

  final Event event;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return EventDetailHeader(event: event);
  }

  @override
  double get minExtent => 300.0;

  @override
  double get maxExtent => 330.0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

class _EventDetailHeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final cornerRadius = 16.0;

    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height - cornerRadius);
    path.arcToPoint(
      Offset(size.width - cornerRadius, size.height),
      radius: Radius.circular(cornerRadius),
    );
    path.lineTo(cornerRadius, size.height);
    path.arcToPoint(
      Offset(0, size.height - cornerRadius),
      radius: Radius.circular(cornerRadius),
    );
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

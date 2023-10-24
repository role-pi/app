import 'package:flutter/cupertino.dart';
import 'package:role/features/user_login/providers/user_login_provider.dart';
import 'package:role/models/item.dart';
import 'package:role/shared/widgets/container_text.dart';
import 'package:role/shared/widgets/custom_navigation_bar.dart';
import 'package:role/shared/widgets/form/form_item_group_title.dart';
import 'package:role/shared/widgets/remote_profile_picture.dart';
import 'package:role/shared/widgets/round_button.dart';

class ItemsDetail extends StatelessWidget {
  final Item item;

  const ItemsDetail({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Column(
        children: [
          CustomNavigationBar(
            leadingText: "voltar",
            trailingText: "editar",
            onPressedLeading: () {
              Navigator.of(context).pop();
            },
            onPressedTrailing: () {},
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Column(
                    children: [
                      ClipPath(
                        clipper: TicketClipper(),
                        child: Container(
                          padding: EdgeInsets.all(24.0),
                          decoration: BoxDecoration(
                              color: CupertinoColors.systemGrey6
                                  .resolveFrom(context)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.nome,
                                    style: TextStyle(
                                        fontSize: 32,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: -1.2),
                                  ),
                                  Text(
                                    "adicionado por você",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: -1.1,
                                      color: CupertinoColors.secondaryLabel
                                          .resolveFrom(context),
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(),
                              Text(
                                item.tipo.emoji,
                                style: TextStyle(
                                  fontSize: 72,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      ClipPath(
                        clipper: TicketClipper(invert: true),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 24.0, vertical: 16.0),
                          decoration: BoxDecoration(
                              color: CupertinoColors.systemGrey5
                                  .resolveFrom(context)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "PAGO POR",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: CupertinoColors.secondaryLabel
                                        .resolveFrom(context)),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  RemoteProfilePicture(
                                    url: UserLoginProvider
                                            .shared.user?.profilePhoto ??
                                        "",
                                    size: 48,
                                  ),
                                  SizedBox(width: 12),
                                  Text("Você",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20,
                                        letterSpacing: -1.1,
                                      )),
                                  Spacer(),
                                  ContainerText(
                                    text: "RS 60",
                                    size: 18,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24),
                FormItemGroupTitle(title: "NOTAS"),
                SizedBox(height: 12),
                Container(
                    decoration: BoxDecoration(
                        color: CupertinoColors.systemGrey6.resolveFrom(context),
                        borderRadius: BorderRadius.circular(12.0)),
                    height: 200),
                SizedBox(height: 24),
                RoundButton(text: "distribuir gastos")
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TicketClipper extends CustomClipper<Path> {
  bool invert;

  TicketClipper({this.invert = false});

  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0.0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);

    double radius = 10;

    path.addOval(Rect.fromCircle(
        center: Offset(0.0, invert ? 0 : size.height), radius: radius));
    path.addOval(Rect.fromCircle(
        center: Offset(size.width, invert ? 0 : size.height), radius: radius));

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

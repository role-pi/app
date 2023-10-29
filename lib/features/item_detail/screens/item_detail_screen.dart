import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:role/features/item_detail/providers/item_detail_provider.dart';
import 'package:role/features/item_detail/widgets/item_detail_transactions.dart';
import 'package:role/shared/widgets/custom_navigation_bar.dart';
import 'package:role/shared/widgets/form/form_item_group_title.dart';
import 'package:role/shared/widgets/form/form_item_limited_textfield.dart';
import 'package:role/shared/widgets/round_button.dart';

class ItemDetailScreen extends StatelessWidget {
  ItemDetailScreen(eventId, {required this.id})
      : itemDetailProvider = ItemDetailProvider(id, eventId);

  final int id;
  final ItemDetailProvider itemDetailProvider;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: itemDetailProvider,
      child: CupertinoPageScaffold(
          child: CustomScrollView(slivers: [
        CupertinoSliverRefreshControl(onRefresh: () async {
          await itemDetailProvider.get();
        }),
        SliverToBoxAdapter(
          child: Column(
            children: [
              CustomNavigationBar(
                leadingText: "voltar",
                trailingText: "salvar",
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        itemDetailProvider.item.nome,
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
                                    itemDetailProvider.item.tipo.emoji,
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
                                  Consumer<ItemDetailProvider>(
                                    builder: (context, value, child) {
                                      return ItemDetailTransactions(
                                          transactions: value.item.transacoes);
                                    },
                                  )
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
                    LimitedTextField(
                      maxLength: 300,
                      hintText: 'Adicione suas notas aqui...',
                    ),
                    SizedBox(height: 24),
                    RoundButton(text: "distribuir gastos")
                  ],
                ),
              ),
            ],
          ),
        ),
      ])),
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

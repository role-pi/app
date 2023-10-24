import 'package:flutter/cupertino.dart';
import 'package:role/shared/widgets/custom_navigation_bar.dart';

class ItemsDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Column(
        children: [
          CustomNavigationBar(
            leadingText: "voltar",
            onPressedLeading: () {
              Navigator.of(context).pop();
            },
          ),
          Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width -60,
                height: 100,
                decoration: BoxDecoration(
                  color: CupertinoColors.systemGrey,
                  borderRadius: BorderRadius.circular(10)
                ),
              ),
              Positioned(
                left: 0,
                right: 60,
                top: 10,
                bottom: 0,
                child: Row(
                  children: [
                    Container(
                      width: 10,
                      color: CupertinoColors.systemGrey,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "coca-cola",
                            style: TextStyle(fontSize: 25),
                          ),
                          Text(
                            "adicionado por serjio",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "🎫",
                      style: TextStyle(
                        fontSize: 70,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

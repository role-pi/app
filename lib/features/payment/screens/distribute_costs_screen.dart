import 'package:flutter/cupertino.dart';


class DIstributeCostsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("Distribuir Gastos"),
        leading: CupertinoButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Icon(CupertinoIcons.back),
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 16),
              Text(
                "Distribuir Gastos",
                style:
                    CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle,
              ),



            ],
          ),
        ),
      ),
    );
  }
}

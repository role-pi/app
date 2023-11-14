
import 'package:flutter/cupertino.dart';

class CostsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Costs List'),
      ),
      child: SafeArea(
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: 50,
              color: CupertinoColors.systemGrey5,
              child: Center(
                child: Text('Item $index'),
              ),
            );
          },
        ),
      ),
    );
  }
}

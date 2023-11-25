import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:role/features/user_detail/providers/user_detail_provider.dart';
import 'package:role/features/user_detail/widgets/user_detail_info.dart';
import 'package:role/features/user_detail/widgets/user_detail_options.dart';
import 'package:role/features/user_detail/widgets/user_detail_extras.dart';
import 'package:role/shared/widgets/custom_navigation_bar.dart';

class UserDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: UserDetailProvider.shared,
      child: CupertinoPageScaffold(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Consumer<UserDetailProvider>(
                builder: (context, value, child) {
                  return CustomNavigationBar(
                    leadingIcon: null,
                    leadingText: "opções de conta",
                    trailingText: "salvar",
                    accentColor: CupertinoColors.activeBlue,
                    onPressedTrailing: value.changed && !value.loading
                        ? () {
                            value.updateUser(context);
                          }
                        : null,
                    topPadding: 0,
                  );
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      UserDetailInfo(),
                      SizedBox(height: 8),
                      Divider(),
                      SizedBox(height: 8),
                      UserDetailOptions(),
                      SizedBox(height: 8),
                      Divider(),
                      SizedBox(height: 8),
                      UserDetailExtras(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

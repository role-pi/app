import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:role/features/user_detail/providers/user_detail_provider.dart';
import 'package:role/features/user_detail/widgets/user_detail_extras.dart';
import 'package:role/features/user_detail/widgets/user_detail_info.dart';
import 'package:role/features/user_detail/widgets/user_detail_options.dart';
import 'package:role/shared/widgets/custom_navigation_bar.dart';

class UserDetailScreen extends StatelessWidget {
  UserDetailProvider get userDetailProvider => UserDetailProvider.shared;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: userDetailProvider,
      child: CupertinoPageScaffold(
        child: Center(
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
                            userDetailProvider.updateUser(context);
                          }
                        : null,
                    topPadding: 0,
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height - 250,
                  child: Column(
                    children: [
                      UserDetailInfo(),
                      SizedBox(height: 12),
                      Divider(),
                      SizedBox(height: 12),
                      UserDetailOptions(),
                      Spacer(),
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

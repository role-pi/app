import 'package:flutter/cupertino.dart';
import 'package:role/shared/widgets/default_user_icon.dart';

class RemoteProfilePicture extends StatelessWidget {
  RemoteProfilePicture({required this.url, this.size = 58});

  final String? url;
  final double size;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Image.network(
        url ?? "",
        fit: BoxFit.cover,
        width: size,
        errorBuilder: (context, error, stackTrace) {
          return DefaultUserIcon(
            size: size,
          );
        },
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:role/shared/widgets/default_user_icon.dart';

class RemoteProfilePicture extends StatelessWidget {
  RemoteProfilePicture(
      {required this.url,
      this.size = 58,
      this.colorBlendMode = BlendMode.srcIn});

  final String? url;
  final double size;
  final BlendMode colorBlendMode;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: SizedBox(
        width: size,
        height: size,
        child: Image.network(
          url ?? "",
          fit: BoxFit.fill,
          width: size,
          height: size,
          colorBlendMode: colorBlendMode,
          errorBuilder: (context, error, stackTrace) {
            return DefaultUserIcon(
              size: size,
            );
          },
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) {
              return child;
            }
            return DefaultUserIcon(
              size: size,
            );
          },
        ),
      ),
    );
  }
}

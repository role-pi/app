import 'package:cached_network_image/cached_network_image.dart';
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
        child: Builder(builder: (context) {
          if (url?.isNotEmpty == true) {
            return CachedNetworkImage(
              imageUrl: url ?? "",
              fit: BoxFit.fill,
              width: size,
              height: size,
              colorBlendMode: colorBlendMode,
              placeholder: (context, url) => DefaultUserIcon(
                size: size,
              ),
              errorWidget: (context, url, error) => DefaultUserIcon(
                size: size,
              ),
            );
          }

          return DefaultUserIcon(
            size: size,
          );
        }),
      ),
    );
  }
}

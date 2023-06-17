import 'package:tiktok_clone/features/profile/manager/profile_cubit.dart';

import '../../../../lib_exports.dart';

class ThumbnailGridViewWidget extends StatelessWidget {
  const ThumbnailGridViewWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final thumbnails = context.read<ProfileCubit>().thumbnails;
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.all(4),
      itemCount: thumbnails.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: .98,
        crossAxisSpacing: 4,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) => InteractiveViewer(
        
        child: CachedImageWidget(
          image: thumbnails[index],
        ),
      ),
    );
  }
}

import 'package:equatable/equatable.dart';
import 'package:tdd_bloc/core/constants/app_asset.dart';

class PageContent extends Equatable {
  const PageContent({
    required this.image,
    required this.title,
    required this.description,
  });

  final String image;
  final String title;
  final String description;

  const PageContent.first()
      : this(
          image: AppAssets.kImagePageContentFirst,
          title: 'Brand new curriculum',
          description:
              'This is the first online education platform designed by the '
              "world's top professors",
        );
  const PageContent.second()
      : this(
          image: AppAssets.kImagePageContentSecond,
          title: 'Brand a fun atmosphere',
          description:
              'This is the first online education platform designed by the '
              "world's top professors",
        );
  const PageContent.thrid()
      : this(
          image: AppAssets.kImagePageContentthrid,
          title: 'Easy to join the lesson',
          description:
              'This is the first online education platform designed by the '
              "world's top professors",
        );

  @override
  List<Object?> get props => [image, title, description];
}

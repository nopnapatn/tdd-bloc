import 'package:flutter/widgets.dart';

class GradientBackgroundWidget extends StatelessWidget {
  const GradientBackgroundWidget({
    required this.image,
    required this.child,
    super.key,
  });

  final String image;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover,
        ),
      ),
      child: SafeArea(child: child),
    );
  }
}

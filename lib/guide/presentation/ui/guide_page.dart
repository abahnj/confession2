import 'package:auto_route/auto_route.dart';
import 'package:confession/gen/assets.gen.dart';
import 'package:confession/router/app_router.gr.dart';
import 'package:confession/shared/widgets/app_bar.dart';
import 'package:flutter/material.dart';

@RoutePage()
class GuidePage extends StatelessWidget {
  const GuidePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ConfessionAppBar(),
      body: Column(
        children: [
          GuideCard(
            guideId: 2,
            title: 'As said by Popes',
            imageProvider: Assets.images.asSaidByPope.provider(),
          ),
          GuideCard(
            guideId: 3,
            title: 'Extracts from Frequent Confession by Fulton Sheen',
            imageProvider: Assets.images.fultonSheen.provider(),
          ),
          GuideCard(
            guideId: 5,
            title: 'How to make a good confession',
            imageProvider: Assets.images.confession.provider(),
          ),
          GuideCard(
            guideId: 4,
            title: 'Cathecism of the Catholic Church',
            imageProvider: Assets.images.ccc.provider(),
          ),
          GuideCard(
            guideId: 1,
            title: 'Frequently Asked Questions',
            imageProvider: Assets.images.faqAlt.provider(),
          ),
        ],
      ),
    );
  }
}

class GuideCard extends StatelessWidget {
  const GuideCard({
    required this.guideId,
    required this.title,
    required this.imageProvider,
    super.key,
  });

  final int guideId;
  final String title;
  final ImageProvider imageProvider;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () => context.pushRoute(GuideDetailListRoute(guideId: guideId)),
        child: Card(
          child: DecoratedBox(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.grey[300]!,
                  BlendMode.saturation,
                ),
              ),
            ),
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.6),
                  ],
                ),
              ),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          letterSpacing: 0.5,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class VintageEffect extends StatelessWidget {
  const VintageEffect({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        child: DecoratedBox(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: Assets.images.asSaidByPope.provider(),
              fit: BoxFit.cover,
              colorFilter: const ColorFilter.matrix([
                0.393, 0.769, 0.189, 0, 0,

                ///
                0.349, 0.686, 0.168, 0, 0,

                ///
                0.272, 0.534, 0.131, 0, 0,

                ///
                0, 0, 0, 1, 0,

                ///
              ]),
            ),
          ),
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFF2C3E50).withOpacity(0.6),
                  const Color(0xFF3498DB).withOpacity(0.4),
                  Colors.black.withOpacity(0.4),
                ],
                stops: const [0.3, 0.6, 1.0],
              ),
            ),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'As Said By Pope',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1,
                      ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

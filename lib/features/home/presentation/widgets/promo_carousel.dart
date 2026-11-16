import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../core/constants/app_spacing.dart';
import '../../../../core/widgets/network_image_box.dart';
import '../../../../data/mock/mock_banners.dart';
import '../../../../l10n/l10n.dart';
import '../../../product/presentation/providers/product_providers.dart';

class PromoCarousel extends ConsumerStatefulWidget {
  const PromoCarousel({super.key});

  @override
  ConsumerState<PromoCarousel> createState() => _PromoCarouselState();
}

class _PromoCarouselState extends ConsumerState<PromoCarousel> {
  final _controller = PageController(viewportFraction: 0.92);
  Timer? _timer;
  int _page = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!_controller.hasClients) return;
      final count = ref.read(bannersProvider).length;
      if (count == 0) return;
      final next = (_page + 1) % count;
      _controller.animateToPage(
        next,
        duration: const Duration(milliseconds: 450),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final banners = ref.watch(bannersProvider);
    final scheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        SizedBox(
          height: 170,
          child: PageView.builder(
            controller: _controller,
            itemCount: banners.length,
            onPageChanged: (i) => _page = i,
            itemBuilder: (_, i) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: _BannerCard(banner: banners[i]),
            ),
          ),
        ),
        const SizedBox(height: 12),
        SmoothPageIndicator(
          controller: _controller,
          count: banners.length,
          effect: ExpandingDotsEffect(
            dotHeight: 8,
            dotWidth: 8,
            expansionFactor: 3,
            activeDotColor: scheme.primary,
            dotColor: scheme.outlineVariant,
          ),
        ),
      ],
    );
  }
}

class _BannerCard extends StatelessWidget {
  const _BannerCard({required this.banner});

  final PromoBanner banner;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final texts = _bannerTexts(context.l10n, banner.id);

    return ClipRRect(
      borderRadius: BorderRadius.circular(AppSpacing.radius + 4),
      child: Stack(
        fit: StackFit.expand,
        children: [
          NetworkImageBox(url: banner.imageUrl),
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xCC000000), Color(0x11000000)],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  texts.title,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  texts.subtitle,
                  style: theme.textTheme.bodyMedium
                      ?.copyWith(color: Colors.white70),
                ),
                const SizedBox(height: 14),
                FilledButton(
                  onPressed: () {},
                  style: FilledButton.styleFrom(
                    minimumSize: const Size(0, 38),
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black87,
                  ),
                  child: Text(texts.cta),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Banner texts in the current language, chosen by the banner id.
({String title, String subtitle, String cta}) _bannerTexts(
    AppLocalizations l10n, String id) {
  return switch (id) {
    'autumn' => (
        title: l10n.bannerAutumnTitle,
        subtitle: l10n.bannerAutumnSubtitle,
        cta: l10n.shopNow,
      ),
    'new' => (
        title: l10n.bannerNewTitle,
        subtitle: l10n.bannerNewSubtitle,
        cta: l10n.explore,
      ),
    _ => (
        title: l10n.bannerShipTitle,
        subtitle: l10n.bannerShipSubtitle,
        cta: l10n.learnMore,
      ),
  };
}

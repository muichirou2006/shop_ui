/// Promo banners. The texts are translated in promo_carousel.dart by [id].
class PromoBanner {
  const PromoBanner({required this.id, required this.imageUrl});

  final String id;
  final String imageUrl;
}

const mockBanners = <PromoBanner>[
  PromoBanner(
      id: 'autumn',
      imageUrl: 'https://picsum.photos/seed/banner-autumn/900/450'),
  PromoBanner(
      id: 'new', imageUrl: 'https://picsum.photos/seed/banner-new/900/450'),
  PromoBanner(
      id: 'shipping',
      imageUrl: 'https://picsum.photos/seed/banner-ship/900/450'),
];

enum ProductSort {
  newest('newest', 'Newest'),
  priceAsc('price_asc', 'Price: low to high'),
  priceDesc('price_desc', 'Price: high to low');

  const ProductSort(this.apiValue, this.label);

  /// Value sent as `?sort=` to the API.
  final String apiValue;
  final String label;
}

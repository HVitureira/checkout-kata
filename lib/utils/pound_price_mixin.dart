mixin PoundPriceMixin {
  String getFormattedPrice(double price) {
    if (price < 100) {
      return '${price}p';
    }
    return '${price / 100}£';
  }
}

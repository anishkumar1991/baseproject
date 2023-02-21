class StringUtils {
  static String logoTitleCase(String text) {
    if (text.length <= 1) return text.toUpperCase();
    var words = text.split(' ');
    var capitalized = words.map((word) {
      var first = word.substring(0, 1).toUpperCase();
      return first;
    });
    if (capitalized.length >= 3) {
      return (capitalized.join('').toString().substring(0, 3));
    }
    return capitalized.join('');
  }
}

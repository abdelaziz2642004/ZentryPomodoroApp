String capitalizeFirstLetterOfEachWord(String input) {
  return input
      .split(' ')
      .map((word) {
        if (word.isEmpty) return word; // Skip empty words
        return word[0].toUpperCase() + word.substring(1).toLowerCase();
      })
      .join(' ');
}

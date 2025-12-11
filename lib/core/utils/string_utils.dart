String enumToTitle(String name) {
  return name
      .replaceAllMapped(RegExp(r'([A-Z])'), (match) => ' ${match.group(0)}')
      .replaceFirst(name[0], name[0].toUpperCase());
}

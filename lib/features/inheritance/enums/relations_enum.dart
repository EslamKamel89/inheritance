enum Relation {
  husband('husband', 'I am her Husbnad'),
  wife('wife', 'I am his wife'),
  none('none', 'none of them');

  final String name;
  final String display;
  const Relation(this.name, this.display);
}

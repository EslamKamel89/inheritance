enum Relation {
  husband('husband', 'i_am_her_husband'),
  wife('wife', 'i_am_his_wife'),
  none('none', 'none_of_them');

  final String name;
  final String display;
  const Relation(this.name, this.display);
}

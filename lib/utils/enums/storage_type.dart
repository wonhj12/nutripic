/// 냉장고 타입
enum StorageType {
  fridge(0, '냉장'),
  freezer(1, '냉동'),
  room(2, '실온');

  final int rawValue;
  final String name;
  const StorageType(this.rawValue, this.name);
}

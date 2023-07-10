import 'package:test/test.dart';
import 'package:testing_flutter_apps/models/favorites.dart';

void main() {
  group('Testing App Provider', () {
    var favorites = Favorites();
    test('A new item should be added', () {
      var number = 35;
      favorites.items.add(number);
      expect(favorites.items.contains(number), true);
    });
    test('A number should be removed', () {
      var number = 90;
      favorites.items.add(number);
      expect(favorites.items.contains(number), true);
      favorites.items.remove(number);
      expect(favorites.items.contains(number), false);
    });
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:testing_flutter_apps/models/favorites.dart';
import 'package:flutter/material.dart';
import 'package:testing_flutter_apps/screens/favorites.dart';

late Favorites favoritesList;

Widget createFavoritesScreen() => ChangeNotifierProvider<Favorites>(
      create: (context) {
        favoritesList = Favorites();
        return favoritesList;
      },
      child: const MaterialApp(
        home: FavoritesPage(),
      ),
    );

void addItems() {
  for (var i = 0; i < 10; i += 2) {
    favoritesList.add(i);
  }
}

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
  group('Favorites Page Widget Tests', () {
    testWidgets('Test if ListView shows up', (tester) async {
      await tester.pumpWidget(createFavoritesScreen());
      addItems();
      await tester.pumpAndSettle();
      expect(find.byType(ListView), findsOneWidget);
    });
    testWidgets('Testing Remove Button', (tester) async {
      await tester.pumpWidget(createFavoritesScreen());
      addItems();
      await tester.pumpAndSettle();
      var totalItems = tester.widgetList(find.byIcon(Icons.close)).length;
      await tester.tap(find.byIcon(Icons.close).first);
      await tester.pumpAndSettle();
      expect(tester.widgetList(find.byIcon(Icons.close)).length,
          lessThan(totalItems));
      expect(find.text('Removed from favorites'), findsOneWidget);
    });
  });
}

import 'package:flutter/material.dart';
import 'screens/favourite_quotes_screen.dart';
import 'screens/quote_screen.dart';
import 'screens/tag_filter_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;
  final List<Map<String, dynamic>> _favoriteQuotes = [];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _addToFavorites(Map<String, dynamic> quote) {
    if (!_favoriteQuotes.contains(quote)) {
      setState(() {
        _favoriteQuotes.add(quote);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _widgetOptions = [
      QuoteScreen(addToFavorites: _addToFavorites),
      TagFilterScreen(),
      FavoritesScreen(favoriteQuotes: _favoriteQuotes),
    ];

    return MaterialApp(
      title: 'Quote App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Quote App'),
        ),
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Random Quote',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.filter_list),
              label: 'Filter by Tags',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorites',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'screens/favourite_quotes_screen.dart';
import 'screens/quote_screen.dart';

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

  void _removeFromFavorites(Map<String, dynamic> quote) {
    setState(() {
      _favoriteQuotes.remove(quote);
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _widgetOptions = [
      QuoteScreen(
        addToFavorites: _addToFavorites,
        favorites: _favoriteQuotes,
      ),
      FavoritesScreen(
        favoriteQuotes: _favoriteQuotes,
        removeFromFavorites: _removeFromFavorites,
      ),
    ];

    const primaryColor = Color(0xFF00515D);
    const secondaryColor = Color(0xFFB5C7CC);
    const tertiaryColor = Color(0xFFBB9E88);
    const neutralColor = Color(0xFFF6E8E0);
    const neutralVariantColor = Color(0xFFA59382);

    return MaterialApp(
      title: 'Quote App',
        theme: ThemeData(
          useMaterial3: true, // Enables Material 3 design
          colorScheme: const ColorScheme(
          brightness: Brightness.light, // Light theme
          primary: primaryColor,
          onPrimary: Colors.white,
          secondary: secondaryColor,
          onSecondary: primaryColor,
          tertiary: tertiaryColor,
          onTertiary: Colors.black,
          background: neutralColor,
          onBackground: Colors.black,
          surface: Colors.white,
          onSurface: Colors.black,
          error: Colors.red,
          onError: Colors.white,
          surfaceVariant: neutralVariantColor,
          onSurfaceVariant: Colors.black,
          ),
        ),
      home: Scaffold(
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Random Quote',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.star),
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

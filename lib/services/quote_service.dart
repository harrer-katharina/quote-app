import 'dart:convert';
import 'package:http/http.dart' as http;

class QuoteService {
  final String _baseUrl = 'https://quoteslate.vercel.app/api/quotes/random';

  Future<Map<String, dynamic>> fetchRandomQuote() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load quote');
    }
  }
}

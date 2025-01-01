import 'dart:convert';
import 'package:http/http.dart' as http;

class QuoteService {
  static const String _baseUrl =
      'https://quoteslate.vercel.app/api/quotes/random';
  static const String _tagsUrl = 'https://quoteslate.vercel.app/api/tags';

  Future<Map<String, dynamic>> fetchRandomQuote({String? tags}) async {
    String url = _baseUrl;
    if (tags != null) {
      url = '$_baseUrl?tags=$tags';
    }

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load quote');
    }
  }

  Future<List<String>> fetchAvailableTags() async {
    final response = await http.get(Uri.parse(_tagsUrl));

    if (response.statusCode == 200) {
      List<dynamic> tagsData = json.decode(response.body);
      return tagsData.map((tag) => tag.toString()).toList();
    } else {
      throw Exception('Failed to load tags');
    }
  }

  Future<List<Map<String, dynamic>>> fetchQuotesByTags(
      List<String> tags) async {
    final String tagsString = tags.join(',');
    final String url = '$_baseUrl?tags=$tagsString';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      return [
        {
          'quote': responseData['quote'],
          'author': responseData['author'],
          'tags': responseData['tags'],
        }
      ];
    } else {
      throw Exception('Failed to load quotes by tags');
    }
  }
}

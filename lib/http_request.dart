import 'dart:convert';
import 'package:http/http.dart' as http;
import 'product_model.dart'; // Import the model class

Future<ProductResponse> fetchProducts() async {
  final String apiKey = 'f29bd80c92c2450b9c1a50e8949142d620240706140028992626';
  final String appId = '8KQ9BJ5K0T69D27';
  final String organizationId = '72e52bb29284485da5062323af99c1dc';

  final Uri url = Uri.parse(
      'https://api.timbu.cloud/products?organization_id=72e52bb29284485da5062323af99c1dc&Appid=8KQ9BJ5K0T69D27&Apikey=f29bd80c92c2450b9c1a50e8949142d620240706140028992626');

  try {
    final response = await http.get(
      url,
      headers: {
        'APP_ID': appId,
        'API_KEY': apiKey,
      },
    );

    if (response.statusCode == 200) {
      return ProductResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load products');
    }
  } catch (error) {
    throw Exception('Failed to load products');
  }
}

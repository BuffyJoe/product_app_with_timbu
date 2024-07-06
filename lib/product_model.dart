import 'photo_model.dart';

class Product {
  final String name;
  final String? description;
  final String uniqueId;
  final String? urlSlug;
  final bool isAvailable;
  final bool isService;
  final bool unavailable;
  final String id;
  final String organizationId;
  final DateTime dateCreated;
  final DateTime lastUpdated;
  final List<Photo> photos;
  final List<dynamic>? currentPrice; // Changed currentPrice to List

  Product({
    required this.name,
    this.description,
    required this.uniqueId,
    this.urlSlug,
    required this.isAvailable,
    required this.isService,
    required this.unavailable,
    required this.id,
    required this.organizationId,
    required this.dateCreated,
    required this.lastUpdated,
    required this.photos,
    this.currentPrice, // Initialize currentPrice as List
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    var photoList = json['photos'] as List;
    List<Photo> photosList = photoList.map((i) => Photo.fromJson(i)).toList();

    return Product(
      name: json['name'],
      description: json['description'],
      uniqueId: json['unique_id'],
      urlSlug: json['url_slug'],
      isAvailable: json['is_available'],
      isService: json['is_service'],
      unavailable: json['unavailable'],
      id: json['id'],
      organizationId: json['organization_id'],
      dateCreated: DateTime.parse(json['date_created']),
      lastUpdated: DateTime.parse(json['last_updated']),
      photos: photosList,
      currentPrice: json['current_price'], // Parse currentPrice as List
    );
  }
}

class ProductResponse {
  final int page;
  final int size;
  final int total;
  final String? previousPage;
  final String? nextPage;
  final List<Product> items;

  ProductResponse({
    required this.page,
    required this.size,
    required this.total,
    this.previousPage,
    this.nextPage,
    required this.items,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    var list = json['items'] as List;
    List<Product> itemsList = list.map((i) => Product.fromJson(i)).toList();

    return ProductResponse(
      page: json['page'],
      size: json['size'],
      total: json['total'],
      previousPage: json['previous_page'],
      nextPage: json['next_page'],
      items: itemsList,
    );
  }
}

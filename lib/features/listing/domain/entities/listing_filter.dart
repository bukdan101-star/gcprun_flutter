class ListingFilter {
  final String? search;
  final String? category;
  final String? condition;
  final String? location;
  final int? minPrice;
  final int? maxPrice;
  final String sortBy;
  final String sortOrder;
  final int page;
  final int limit;

  const ListingFilter({
    this.search,
    this.category,
    this.condition,
    this.location,
    this.minPrice,
    this.maxPrice,
    this.sortBy = 'createdAt',
    this.sortOrder = 'desc',
    this.page = 1,
    this.limit = 20,
  });

  Map<String, dynamic> toQuery() {
    return {
      if (search != null) 'search': search,
      if (category != null) 'category': category,
      if (condition != null) 'condition': condition,
      if (location != null) 'location': location,
      if (minPrice != null) 'minPrice': minPrice,
      if (maxPrice != null) 'maxPrice': maxPrice,
      'sortBy': sortBy,
      'sortOrder': sortOrder,
      'page': page,
      'limit': limit,
    };
  }

  ListingFilter copyWith({
    String? search,
    String? category,
    String? condition,
    String? location,
    int? minPrice,
    int? maxPrice,
    String? sortBy,
    String? sortOrder,
    int? page,
    int? limit,
  }) {
    return ListingFilter(
      search: search ?? this.search,
      category: category ?? this.category,
      condition: condition ?? this.condition,
      location: location ?? this.location,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      sortBy: sortBy ?? this.sortBy,
      sortOrder: sortOrder ?? this.sortOrder,
      page: page ?? this.page,
      limit: limit ?? this.limit,
    );
  }
}

import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_response.dart';
import '../../../../core/constants/api_constants.dart';
import '../../domain/entities/listing_entity.dart';
import '../../domain/entities/listing_filter.dart';
import '../models/listing_model.dart';

class ListingRemoteDatasource {
  final ApiClient _apiClient;

  ListingRemoteDatasource(this._apiClient);

  Future<ApiResponse<List<ListingEntity>>> getListings({ListingFilter? filter}) async {
    return _apiClient.get<List<ListingEntity>>(
      ApiConstants.listings,
      queryParameters: filter?.toQuery(),
      fromJson: (data) {
        if (data is List) {
          return data.map((e) => ListingModel.fromJson(e as Map<String, dynamic>).toEntity()).toList();
        }
        final items = data['items'] as List? ?? [];
        return items.map((e) => ListingModel.fromJson(e as Map<String, dynamic>).toEntity()).toList();
      },
    );
  }

  Future<ApiResponse<ListingEntity>> getListingById(String id) async {
    return _apiClient.get<ListingEntity>(
      '${ApiConstants.listingDetail}$id',
      fromJson: (data) => ListingModel.fromJson(data as Map<String, dynamic>).toEntity(),
    );
  }

  Future<ApiResponse<List<ListingEntity>>> getMyListings({int page = 1, int limit = 20}) async {
    return _apiClient.get<List<ListingEntity>>(
      ApiConstants.myListings,
      queryParameters: {'page': page, 'limit': limit},
      fromJson: (data) {
        if (data is List) {
          return data.map((e) => ListingModel.fromJson(e as Map<String, dynamic>).toEntity()).toList();
        }
        final items = data['items'] as List? ?? [];
        return items.map((e) => ListingModel.fromJson(e as Map<String, dynamic>).toEntity()).toList();
      },
    );
  }

  Future<ApiResponse<ListingEntity>> createListing(Map<String, dynamic> data) async {
    return _apiClient.post<ListingEntity>(
      ApiConstants.createListing,
      data: data,
      fromJson: (data) => ListingModel.fromJson(data as Map<String, dynamic>).toEntity(),
    );
  }

  Future<ApiResponse<ListingEntity>> updateListing(String id, Map<String, dynamic> data) async {
    return _apiClient.put<ListingEntity>(
      '${ApiConstants.updateListing}$id',
      data: data,
      fromJson: (data) => ListingModel.fromJson(data as Map<String, dynamic>).toEntity(),
    );
  }

  Future<ApiResponse<void>> deleteListing(String id) async {
    return _apiClient.delete<void>('${ApiConstants.deleteListing}$id');
  }

  Future<ApiResponse<void>> toggleWishlist(String listingId) async {
    return _apiClient.post<void>(
      '${ApiConstants.addToWishlist}',
      data: {'listingId': listingId},
    );
  }

  Future<ApiResponse<List<ListingEntity>>> getWishlist() async {
    return _apiClient.get<List<ListingEntity>>(
      ApiConstants.wishlist,
      fromJson: (data) {
        if (data is List) {
          return data.map((e) => ListingModel.fromJson(e as Map<String, dynamic>).toEntity()).toList();
        }
        final items = data['items'] as List? ?? [];
        return items.map((e) => ListingModel.fromJson(e as Map<String, dynamic>).toEntity()).toList();
      },
    );
  }

  Future<ApiResponse<List<String>>> getCategories() async {
    return _apiClient.get<List<String>>(
      ApiConstants.listingCategories,
      fromJson: (data) {
        if (data is List) {
          return data.map((e) => e.toString()).toList();
        }
        return [];
      },
    );
  }
}

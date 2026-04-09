import '../entities/listing_entity.dart';
import '../entities/listing_filter.dart';

abstract class ListingRepository {
  Future<List<ListingEntity>> getListings({ListingFilter? filter});
  Future<ListingEntity?> getListingById(String id);
  Future<List<ListingEntity>> getMyListings({int page = 1, int limit = 20});
  Future<ListingEntity> createListing(Map<String, dynamic> data);
  Future<ListingEntity> updateListing(String id, Map<String, dynamic> data);
  Future<void> deleteListing(String id);
  Future<void> toggleWishlist(String listingId);
  Future<List<ListingEntity>> getWishlist();
  Future<List<String>> getCategories();
}

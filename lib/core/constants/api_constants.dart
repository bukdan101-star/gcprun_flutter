class ApiConstants {
  ApiConstants._();

  static const String baseUrl = 'https://api.gcprun.com/v1';

  // Auth
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String logout = '/auth/logout';
  static const String forgotPassword = '/auth/forgot-password';
  static const String resetPassword = '/auth/reset-password';
  static const String verifyEmail = '/auth/verify-email';
  static const String refreshToken = '/auth/refresh-token';

  // User / Profile
  static const String getMe = '/users/me';
  static const String updateProfile = '/users/me';
  static const String updateAvatar = '/users/me/avatar';
  static const String getUserByUsername = '/users/';
  static const String changePassword = '/users/me/password';

  // KYC
  static const String submitKyc = '/kyc/submit';
  static const String getKycStatus = '/kyc/status';
  static const String uploadKycDocument = '/kyc/documents';

  // Listings
  static const String listings = '/listings';
  static const String listingDetail = '/listings/';
  static const String createListing = '/listings';
  static const String updateListing = '/listings/';
  static const String deleteListing = '/listings/';
  static const String myListings = '/listings/mine';
  static const String searchListings = '/listings/search';
  static const String listingCategories = '/listings/categories';

  // Orders
  static const String orders = '/orders';
  static const String orderDetail = '/orders/';
  static const String createOrder = '/orders';
  static const String cancelOrder = '/orders/';
  static const String confirmOrder = '/orders/';
  static const String completeOrder = '/orders/';
  static const String myOrders = '/orders/mine';
  static const String sellerOrders = '/orders/seller';

  // Wallet
  static const String wallet = '/wallet';
  static const String walletTransactions = '/wallet/transactions';
  static const String topUp = '/wallet/top-up';
  static const String withdraw = '/wallet/withdraw';
  static const String withdrawHistory = '/wallet/withdraw/history';

  // Messages
  static const String conversations = '/messages/conversations';
  static const String messages = '/messages/';
  static const String sendMessage = '/messages/';

  // Notifications
  static const String notifications = '/notifications';
  static const String markNotificationRead = '/notifications/';
  static const String markAllNotificationsRead = '/notifications/read-all';

  // Wishlist
  static const String wishlist = '/wishlist';
  static const String addToWishlist = '/wishlist';
  static const String removeFromWishlist = '/wishlist/';

  // Coupons
  static const String coupons = '/coupons';
  static const String applyCoupon = '/coupons/apply';
  static const String myCoupons = '/coupons/mine';

  // AI Credit Score
  static const String creditScore = '/ai/credit-score';
  static const String creditScoreHistory = '/ai/credit-score/history';

  // Reviews
  static const String reviews = '/reviews';
  static const String createReview = '/reviews';

  // Support
  static const String supportTickets = '/support/tickets';
  static const String createTicket = '/support/tickets';
  static const String ticketMessages = '/support/tickets/';

  // Upload
  static const String uploadImage = '/upload/image';
  static const String uploadDocument = '/upload/document';
}

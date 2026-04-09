class UserEntity {
  final String id;
  final String name;
  final String email;
  final String? phone;
  final String? username;
  final String? avatar;
  final String? bio;
  final String? location;
  final String? nik;
  final bool isVerified;
  final bool kycVerified;
  final double creditScore;
  final String? createdAt;

  const UserEntity({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.username,
    this.avatar,
    this.bio,
    this.location,
    this.nik,
    this.isVerified = false,
    this.kycVerified = false,
    this.creditScore = 0,
    this.createdAt,
  });

  String get displayName => username ?? name;
  String get initials {
    final parts = name.trim().split(' ');
    if (parts.length >= 2) return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    return name.isNotEmpty ? name[0].toUpperCase() : '?';
  }
}

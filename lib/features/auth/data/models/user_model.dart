class UserModel {
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
  final String? updatedAt;

  const UserModel({
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
    this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      phone: json['phone'] as String?,
      username: json['username'] as String?,
      avatar: json['avatar'] as String?,
      bio: json['bio'] as String?,
      location: json['location'] as String?,
      nik: json['nik'] as String?,
      isVerified: json['isVerified'] as bool? ?? false,
      kycVerified: json['kycVerified'] as bool? ?? false,
      creditScore: (json['creditScore'] as num?)?.toDouble() ?? 0,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'username': username,
      'avatar': avatar,
      'bio': bio,
      'location': location,
      'nik': nik,
      'isVerified': isVerified,
      'kycVerified': kycVerified,
      'creditScore': creditScore,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? username,
    String? avatar,
    String? bio,
    String? location,
    String? nik,
    bool? isVerified,
    bool? kycVerified,
    double? creditScore,
    String? createdAt,
    String? updatedAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      username: username ?? this.username,
      avatar: avatar ?? this.avatar,
      bio: bio ?? this.bio,
      location: location ?? this.location,
      nik: nik ?? this.nik,
      isVerified: isVerified ?? this.isVerified,
      kycVerified: kycVerified ?? this.kycVerified,
      creditScore: creditScore ?? this.creditScore,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  String get displayName => username ?? name;

  String get initials {
    final parts = name.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return name.isNotEmpty ? name[0].toUpperCase() : '?';
  }
}

enum KycStatus { notSubmitted, pending, approved, rejected, needsRevision }

class KycEntity {
  final String id;
  final String userId;
  final String? nik;
  final String? fullName;
  final String? dateOfBirth;
  final String? placeOfBirth;
  final String? gender;
  final String? address;
  final String? ktpImageUrl;
  final String? selfieImageUrl;
  final KycStatus status;
  final String? rejectionReason;
  final String? submittedAt;
  final String? verifiedAt;

  const KycEntity({
    required this.id,
    required this.userId,
    this.nik,
    this.fullName,
    this.dateOfBirth,
    this.placeOfBirth,
    this.gender,
    this.address,
    this.ktpImageUrl,
    this.selfieImageUrl,
    this.status = KycStatus.notSubmitted,
    this.rejectionReason,
    this.submittedAt,
    this.verifiedAt,
  });

  String get statusDisplay {
    switch (status) {
      case KycStatus.notSubmitted: return 'Belum Diajukan';
      case KycStatus.pending: return 'Menunggu Verifikasi';
      case KycStatus.approved: return 'Terverifikasi';
      case KycStatus.rejected: return 'Ditolak';
      case KycStatus.needsRevision: return 'Perlu Revisi';
    }
  }
}

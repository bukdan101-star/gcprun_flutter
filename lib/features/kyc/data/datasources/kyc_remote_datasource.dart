import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_response.dart';
import '../../../../core/constants/api_constants.dart';
import '../../domain/entities/kyc_entity.dart';

class KycRemoteDatasource {
  final ApiClient _apiClient;

  KycRemoteDatasource(this._apiClient);

  Future<ApiResponse<KycEntity>> getKycStatus() async {
    return _apiClient.get<KycEntity>(
      ApiConstants.getKycStatus,
      fromJson: (data) => _parseKyc(data as Map<String, dynamic>? ?? {}),
    );
  }

  Future<ApiResponse<KycEntity>> submitKyc({
    required String nik,
    required String fullName,
    required String dateOfBirth,
    required String placeOfBirth,
    required String gender,
    required String address,
    required String ktpImagePath,
    required String selfieImagePath,
  }) async {
    return _apiClient.post<KycEntity>(
      ApiConstants.submitKyc,
      data: {
        'nik': nik,
        'fullName': fullName,
        'dateOfBirth': dateOfBirth,
        'placeOfBirth': placeOfBirth,
        'gender': gender,
        'address': address,
        'ktpImage': ktpImagePath,
        'selfieImage': selfieImagePath,
      },
      fromJson: (data) => _parseKyc(data as Map<String, dynamic>),
    );
  }

  Future<ApiResponse<String>> uploadKycDocument(String filePath, String documentType) async {
    return _apiClient.upload<String>(
      ApiConstants.uploadKycDocument,
      filePath: filePath,
      fieldName: 'document',
      extraFields: {'type': documentType},
      fromJson: (data) => (data as Map<String, dynamic>)['url'] as String? ?? '',
    );
  }

  KycEntity _parseKyc(Map<String, dynamic> json) {
    return KycEntity(
      id: json['id'] as String? ?? '',
      userId: json['userId'] as String? ?? '',
      nik: json['nik'] as String?,
      fullName: json['fullName'] as String?,
      dateOfBirth: json['dateOfBirth'] as String?,
      placeOfBirth: json['placeOfBirth'] as String?,
      gender: json['gender'] as String?,
      address: json['address'] as String?,
      ktpImageUrl: json['ktpImageUrl'] as String?,
      selfieImageUrl: json['selfieImageUrl'] as String?,
      status: _parseKycStatus(json['status'] as String?),
      rejectionReason: json['rejectionReason'] as String?,
      submittedAt: json['submittedAt'] as String?,
      verifiedAt: json['verifiedAt'] as String?,
    );
  }

  KycStatus _parseKycStatus(String? status) {
    switch (status) {
      case 'pending': return KycStatus.pending;
      case 'approved': return KycStatus.approved;
      case 'rejected': return KycStatus.rejected;
      case 'needs_revision': return KycStatus.needsRevision;
      default: return KycStatus.notSubmitted;
    }
  }
}

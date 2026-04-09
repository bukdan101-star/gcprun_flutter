import '../entities/kyc_entity.dart';

abstract class KycRepository {
  Future<KycEntity> getKycStatus();
  Future<KycEntity> submitKyc({
    required String nik,
    required String fullName,
    required String dateOfBirth,
    required String placeOfBirth,
    required String gender,
    required String address,
    required String ktpImagePath,
    required String selfieImagePath,
  });
  Future<String> uploadKycDocument(String filePath, String documentType);
}

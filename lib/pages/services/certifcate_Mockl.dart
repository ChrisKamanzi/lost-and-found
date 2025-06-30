abstract class ICertificatePinningService {
  Future<bool> checkServerCertificate({
    required String serverURL,
    required List<String> allowedFingerprints,
  });
}
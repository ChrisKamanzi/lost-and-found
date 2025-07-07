import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lost_and_found/pages/certificate.dart';
import 'package:lost_and_found/pages/services/certifcate_Mockl.dart';
import 'package:lost_and_found/stateManagment/Notifier/user_notifier.dart';
import 'package:mocktail/mocktail.dart';

class MockCertPinningService extends Mock
    implements ICertificatePinningService {
}

void main() {
  late MockCertPinningService mockService;

  setUpAll(() async {
    await dotenv.load(fileName: "apii.env");
    mockService = MockCertPinningService();
  });

  test('returns true when certificate check passes', () async {
    when(
      () => mockService.checkServerCertificate(
        serverURL: apiUrl,
        allowedFingerprints: [CERTIFICATE],
      ),
    ).thenAnswer((_) async => true);

    final result = await mockService.checkServerCertificate(
      serverURL: apiUrl,
      allowedFingerprints: [CERTIFICATE],
    );
    expect(result, isTrue);
  });

  test('returns false when certificate check fails', () async {
    when(
      () => mockService.checkServerCertificate(
        serverURL: apiUrl,
        allowedFingerprints: [CERTIFICATE],
      ),
    ).thenThrow(Exception('Invalid Certificate'));
    expect(
      () async => await mockService.checkServerCertificate(
        serverURL: apiUrl,
        allowedFingerprints: [CERTIFICATE],
      ),
      throwsA(isA<Exception>()),
    );
  });
}

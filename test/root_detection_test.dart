import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:jailbreak_root_detection/jailbreak_root_detection.dart';
import 'package:lost_and_found/pages/services/root_detection.dart';

// 🔹 Mock Class
class MockJailbreakRootDetection extends Mock implements JailbreakRootDetection {}

void main() {
  late MockJailbreakRootDetection mockDetection;
  late DeviceSecurityService service;

  setUp(() {
    mockDetection = MockJailbreakRootDetection();
    service = DeviceSecurityService(detection: mockDetection);
  });

  test('returns true when device is jailbroken', () async {
    when(() => mockDetection.isJailBroken).thenAnswer((_) async => true);
    when(() => mockDetection.isRealDevice).thenAnswer((_) async => true);
    when(() => mockDetection.isNotTrust).thenAnswer((_) async => false);

    final result = await service.isDeviceCompromised();
    expect(result, isTrue);
  });

  test('returns true when device is not real', () async {
    when(() => mockDetection.isJailBroken).thenAnswer((_) async => false);
    when(() => mockDetection.isRealDevice).thenAnswer((_) async => false);
    when(() => mockDetection.isNotTrust).thenAnswer((_) async => false);

    final result = await service.isDeviceCompromised();
    expect(result, isTrue);
  });

  test('returns true when device is not trusted', () async {
    when(() => mockDetection.isJailBroken).thenAnswer((_) async => false);
    when(() => mockDetection.isRealDevice).thenAnswer((_) async => true);
    when(() => mockDetection.isNotTrust).thenAnswer((_) async => true);

    final result = await service.isDeviceCompromised();
    expect(result, isTrue);
  });

  test('returns false when device is secure', () async {
    when(() => mockDetection.isJailBroken).thenAnswer((_) async => false);
    when(() => mockDetection.isRealDevice).thenAnswer((_) async => true);
    when(() => mockDetection.isNotTrust).thenAnswer((_) async => false);

    final result = await service.isDeviceCompromised();
    expect(result, isFalse);
  });

  test('returns false when exception is thrown', () async {
    when(() => mockDetection.isJailBroken).thenThrow(Exception('Unexpected error'));
    when(() => mockDetection.isRealDevice).thenAnswer((_) async => true);
    when(() => mockDetection.isNotTrust).thenAnswer((_) async => false);

    final result = await service.isDeviceCompromised();
    expect(result, isFalse);
  });
}

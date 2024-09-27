import 'package:uuid/uuid.dart';

mixin UuidGenerator {
  Uuid get _uuid => const Uuid();

  String get uuidV1 => _uuid.v1();
}

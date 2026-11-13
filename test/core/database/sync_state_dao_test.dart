import 'package:donuts/core/database/app_database.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;

  setUp(() => db = AppDatabase.forTesting(NativeDatabase.memory()));
  tearDown(() => db.close());

  test('save then find returns the stored version', () async {
    final at = DateTime.utc(2026, 11, 12, 9);
    await db.syncStateDao.save(key: 'catalog', version: 2, fetchedAt: at);

    final state = await db.syncStateDao.find('catalog');

    expect(state?.version, 2);
    expect(state?.fetchedAt.toUtc(), at);
  });

  test('save twice keeps one row', () async {
    final at = DateTime.utc(2026, 11, 12);
    await db.syncStateDao.save(key: 'catalog', version: 1, fetchedAt: at);
    await db.syncStateDao.save(key: 'catalog', version: 2, fetchedAt: at);

    final rows = await db.select(db.syncStateTable).get();

    expect(rows, hasLength(1));
    expect(rows.single.version, 2);
  });

  test('find returns null for a key never saved', () async {
    expect(await db.syncStateDao.find('member'), isNull);
  });
}

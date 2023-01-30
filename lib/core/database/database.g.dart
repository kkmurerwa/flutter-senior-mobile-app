// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  OrdersDao? _ordersDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `orders` (`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `pickUpPoint` TEXT NOT NULL, `dropOffPoint` TEXT NOT NULL, `weight` REAL NOT NULL, `instructions` TEXT NOT NULL, `createdAt` INTEGER NOT NULL, `createdBy` TEXT NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  OrdersDao get ordersDao {
    return _ordersDaoInstance ??= _$OrdersDao(database, changeListener);
  }
}

class _$OrdersDao extends OrdersDao {
  _$OrdersDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _orderItemInsertionAdapter = InsertionAdapter(
            database,
            'orders',
            (OrderItem item) => <String, Object?>{
                  'id': item.id,
                  'pickUpPoint': item.pickUpPoint,
                  'dropOffPoint': item.dropOffPoint,
                  'weight': item.weight,
                  'instructions': item.instructions,
                  'createdAt': item.createdAt,
                  'createdBy': item.createdBy
                },
            changeListener),
        _orderItemUpdateAdapter = UpdateAdapter(
            database,
            'orders',
            ['id'],
            (OrderItem item) => <String, Object?>{
                  'id': item.id,
                  'pickUpPoint': item.pickUpPoint,
                  'dropOffPoint': item.dropOffPoint,
                  'weight': item.weight,
                  'instructions': item.instructions,
                  'createdAt': item.createdAt,
                  'createdBy': item.createdBy
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<OrderItem> _orderItemInsertionAdapter;

  final UpdateAdapter<OrderItem> _orderItemUpdateAdapter;

  @override
  Future<List<OrderItem>> getOrders() async {
    return _queryAdapter.queryList('SELECT * FROM orders',
        mapper: (Map<String, Object?> row) => OrderItem(
            id: row['id'] as int,
            pickUpPoint: row['pickUpPoint'] as String,
            dropOffPoint: row['dropOffPoint'] as String,
            weight: row['weight'] as double,
            instructions: row['instructions'] as String,
            createdAt: row['createdAt'] as int,
            createdBy: row['createdBy'] as String));
  }

  @override
  Stream<OrderItem?> getOrderById(int id) {
    return _queryAdapter.queryStream('SELECT * FROM orders WHERE id = ?1',
        mapper: (Map<String, Object?> row) => OrderItem(
            id: row['id'] as int,
            pickUpPoint: row['pickUpPoint'] as String,
            dropOffPoint: row['dropOffPoint'] as String,
            weight: row['weight'] as double,
            instructions: row['instructions'] as String,
            createdAt: row['createdAt'] as int,
            createdBy: row['createdBy'] as String),
        arguments: [id],
        queryableName: 'orders',
        isView: false);
  }

  @override
  Future<void> deleteOrder(int id) async {
    await _queryAdapter
        .queryNoReturn('DELETE FROM orders WHERE id = ?1', arguments: [id]);
  }

  @override
  Future<void> createOrder(OrderItem order) async {
    await _orderItemInsertionAdapter.insert(order, OnConflictStrategy.ignore);
  }

  @override
  Future<void> updateOrderItem(OrderItem order) async {
    await _orderItemUpdateAdapter.update(order, OnConflictStrategy.replace);
  }
}

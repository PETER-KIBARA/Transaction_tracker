// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $SmsTransactionsTable extends SmsTransactions
    with TableInfo<$SmsTransactionsTable, SmsTransaction> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SmsTransactionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _senderMeta = const VerificationMeta('sender');
  @override
  late final GeneratedColumn<String> sender = GeneratedColumn<String>(
    'sender',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _messageBodyMeta = const VerificationMeta(
    'messageBody',
  );
  @override
  late final GeneratedColumn<String> messageBody = GeneratedColumn<String>(
    'message_body',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _transactionTypeMeta = const VerificationMeta(
    'transactionType',
  );
  @override
  late final GeneratedColumn<String> transactionType = GeneratedColumn<String>(
    'transaction_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _transactionDateMeta = const VerificationMeta(
    'transactionDate',
  );
  @override
  late final GeneratedColumn<DateTime> transactionDate =
      GeneratedColumn<DateTime>(
        'transaction_date',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _balanceMeta = const VerificationMeta(
    'balance',
  );
  @override
  late final GeneratedColumn<double> balance = GeneratedColumn<double>(
    'balance',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _referenceNumberMeta = const VerificationMeta(
    'referenceNumber',
  );
  @override
  late final GeneratedColumn<String> referenceNumber = GeneratedColumn<String>(
    'reference_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    sender,
    messageBody,
    amount,
    transactionType,
    category,
    transactionDate,
    balance,
    referenceNumber,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sms_transactions';
  @override
  VerificationContext validateIntegrity(
    Insertable<SmsTransaction> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('sender')) {
      context.handle(
        _senderMeta,
        sender.isAcceptableOrUnknown(data['sender']!, _senderMeta),
      );
    } else if (isInserting) {
      context.missing(_senderMeta);
    }
    if (data.containsKey('message_body')) {
      context.handle(
        _messageBodyMeta,
        messageBody.isAcceptableOrUnknown(
          data['message_body']!,
          _messageBodyMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_messageBodyMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('transaction_type')) {
      context.handle(
        _transactionTypeMeta,
        transactionType.isAcceptableOrUnknown(
          data['transaction_type']!,
          _transactionTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_transactionTypeMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('transaction_date')) {
      context.handle(
        _transactionDateMeta,
        transactionDate.isAcceptableOrUnknown(
          data['transaction_date']!,
          _transactionDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_transactionDateMeta);
    }
    if (data.containsKey('balance')) {
      context.handle(
        _balanceMeta,
        balance.isAcceptableOrUnknown(data['balance']!, _balanceMeta),
      );
    }
    if (data.containsKey('reference_number')) {
      context.handle(
        _referenceNumberMeta,
        referenceNumber.isAcceptableOrUnknown(
          data['reference_number']!,
          _referenceNumberMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {sender, messageBody, amount, transactionDate},
  ];
  @override
  SmsTransaction map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SmsTransaction(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      sender: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sender'],
      )!,
      messageBody: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}message_body'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      transactionType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}transaction_type'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      transactionDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}transaction_date'],
      )!,
      balance: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}balance'],
      ),
      referenceNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reference_number'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $SmsTransactionsTable createAlias(String alias) {
    return $SmsTransactionsTable(attachedDatabase, alias);
  }
}

class SmsTransaction extends DataClass implements Insertable<SmsTransaction> {
  final String id;
  final String sender;
  final String messageBody;
  final double amount;
  final String transactionType;
  final String category;
  final DateTime transactionDate;
  final double? balance;
  final String? referenceNumber;
  final DateTime createdAt;
  const SmsTransaction({
    required this.id,
    required this.sender,
    required this.messageBody,
    required this.amount,
    required this.transactionType,
    required this.category,
    required this.transactionDate,
    this.balance,
    this.referenceNumber,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['sender'] = Variable<String>(sender);
    map['message_body'] = Variable<String>(messageBody);
    map['amount'] = Variable<double>(amount);
    map['transaction_type'] = Variable<String>(transactionType);
    map['category'] = Variable<String>(category);
    map['transaction_date'] = Variable<DateTime>(transactionDate);
    if (!nullToAbsent || balance != null) {
      map['balance'] = Variable<double>(balance);
    }
    if (!nullToAbsent || referenceNumber != null) {
      map['reference_number'] = Variable<String>(referenceNumber);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  SmsTransactionsCompanion toCompanion(bool nullToAbsent) {
    return SmsTransactionsCompanion(
      id: Value(id),
      sender: Value(sender),
      messageBody: Value(messageBody),
      amount: Value(amount),
      transactionType: Value(transactionType),
      category: Value(category),
      transactionDate: Value(transactionDate),
      balance: balance == null && nullToAbsent
          ? const Value.absent()
          : Value(balance),
      referenceNumber: referenceNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(referenceNumber),
      createdAt: Value(createdAt),
    );
  }

  factory SmsTransaction.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SmsTransaction(
      id: serializer.fromJson<String>(json['id']),
      sender: serializer.fromJson<String>(json['sender']),
      messageBody: serializer.fromJson<String>(json['messageBody']),
      amount: serializer.fromJson<double>(json['amount']),
      transactionType: serializer.fromJson<String>(json['transactionType']),
      category: serializer.fromJson<String>(json['category']),
      transactionDate: serializer.fromJson<DateTime>(json['transactionDate']),
      balance: serializer.fromJson<double?>(json['balance']),
      referenceNumber: serializer.fromJson<String?>(json['referenceNumber']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'sender': serializer.toJson<String>(sender),
      'messageBody': serializer.toJson<String>(messageBody),
      'amount': serializer.toJson<double>(amount),
      'transactionType': serializer.toJson<String>(transactionType),
      'category': serializer.toJson<String>(category),
      'transactionDate': serializer.toJson<DateTime>(transactionDate),
      'balance': serializer.toJson<double?>(balance),
      'referenceNumber': serializer.toJson<String?>(referenceNumber),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  SmsTransaction copyWith({
    String? id,
    String? sender,
    String? messageBody,
    double? amount,
    String? transactionType,
    String? category,
    DateTime? transactionDate,
    Value<double?> balance = const Value.absent(),
    Value<String?> referenceNumber = const Value.absent(),
    DateTime? createdAt,
  }) => SmsTransaction(
    id: id ?? this.id,
    sender: sender ?? this.sender,
    messageBody: messageBody ?? this.messageBody,
    amount: amount ?? this.amount,
    transactionType: transactionType ?? this.transactionType,
    category: category ?? this.category,
    transactionDate: transactionDate ?? this.transactionDate,
    balance: balance.present ? balance.value : this.balance,
    referenceNumber: referenceNumber.present
        ? referenceNumber.value
        : this.referenceNumber,
    createdAt: createdAt ?? this.createdAt,
  );
  SmsTransaction copyWithCompanion(SmsTransactionsCompanion data) {
    return SmsTransaction(
      id: data.id.present ? data.id.value : this.id,
      sender: data.sender.present ? data.sender.value : this.sender,
      messageBody: data.messageBody.present
          ? data.messageBody.value
          : this.messageBody,
      amount: data.amount.present ? data.amount.value : this.amount,
      transactionType: data.transactionType.present
          ? data.transactionType.value
          : this.transactionType,
      category: data.category.present ? data.category.value : this.category,
      transactionDate: data.transactionDate.present
          ? data.transactionDate.value
          : this.transactionDate,
      balance: data.balance.present ? data.balance.value : this.balance,
      referenceNumber: data.referenceNumber.present
          ? data.referenceNumber.value
          : this.referenceNumber,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SmsTransaction(')
          ..write('id: $id, ')
          ..write('sender: $sender, ')
          ..write('messageBody: $messageBody, ')
          ..write('amount: $amount, ')
          ..write('transactionType: $transactionType, ')
          ..write('category: $category, ')
          ..write('transactionDate: $transactionDate, ')
          ..write('balance: $balance, ')
          ..write('referenceNumber: $referenceNumber, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    sender,
    messageBody,
    amount,
    transactionType,
    category,
    transactionDate,
    balance,
    referenceNumber,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SmsTransaction &&
          other.id == this.id &&
          other.sender == this.sender &&
          other.messageBody == this.messageBody &&
          other.amount == this.amount &&
          other.transactionType == this.transactionType &&
          other.category == this.category &&
          other.transactionDate == this.transactionDate &&
          other.balance == this.balance &&
          other.referenceNumber == this.referenceNumber &&
          other.createdAt == this.createdAt);
}

class SmsTransactionsCompanion extends UpdateCompanion<SmsTransaction> {
  final Value<String> id;
  final Value<String> sender;
  final Value<String> messageBody;
  final Value<double> amount;
  final Value<String> transactionType;
  final Value<String> category;
  final Value<DateTime> transactionDate;
  final Value<double?> balance;
  final Value<String?> referenceNumber;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const SmsTransactionsCompanion({
    this.id = const Value.absent(),
    this.sender = const Value.absent(),
    this.messageBody = const Value.absent(),
    this.amount = const Value.absent(),
    this.transactionType = const Value.absent(),
    this.category = const Value.absent(),
    this.transactionDate = const Value.absent(),
    this.balance = const Value.absent(),
    this.referenceNumber = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SmsTransactionsCompanion.insert({
    required String id,
    required String sender,
    required String messageBody,
    required double amount,
    required String transactionType,
    required String category,
    required DateTime transactionDate,
    this.balance = const Value.absent(),
    this.referenceNumber = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       sender = Value(sender),
       messageBody = Value(messageBody),
       amount = Value(amount),
       transactionType = Value(transactionType),
       category = Value(category),
       transactionDate = Value(transactionDate),
       createdAt = Value(createdAt);
  static Insertable<SmsTransaction> custom({
    Expression<String>? id,
    Expression<String>? sender,
    Expression<String>? messageBody,
    Expression<double>? amount,
    Expression<String>? transactionType,
    Expression<String>? category,
    Expression<DateTime>? transactionDate,
    Expression<double>? balance,
    Expression<String>? referenceNumber,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sender != null) 'sender': sender,
      if (messageBody != null) 'message_body': messageBody,
      if (amount != null) 'amount': amount,
      if (transactionType != null) 'transaction_type': transactionType,
      if (category != null) 'category': category,
      if (transactionDate != null) 'transaction_date': transactionDate,
      if (balance != null) 'balance': balance,
      if (referenceNumber != null) 'reference_number': referenceNumber,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SmsTransactionsCompanion copyWith({
    Value<String>? id,
    Value<String>? sender,
    Value<String>? messageBody,
    Value<double>? amount,
    Value<String>? transactionType,
    Value<String>? category,
    Value<DateTime>? transactionDate,
    Value<double?>? balance,
    Value<String?>? referenceNumber,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return SmsTransactionsCompanion(
      id: id ?? this.id,
      sender: sender ?? this.sender,
      messageBody: messageBody ?? this.messageBody,
      amount: amount ?? this.amount,
      transactionType: transactionType ?? this.transactionType,
      category: category ?? this.category,
      transactionDate: transactionDate ?? this.transactionDate,
      balance: balance ?? this.balance,
      referenceNumber: referenceNumber ?? this.referenceNumber,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (sender.present) {
      map['sender'] = Variable<String>(sender.value);
    }
    if (messageBody.present) {
      map['message_body'] = Variable<String>(messageBody.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (transactionType.present) {
      map['transaction_type'] = Variable<String>(transactionType.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (transactionDate.present) {
      map['transaction_date'] = Variable<DateTime>(transactionDate.value);
    }
    if (balance.present) {
      map['balance'] = Variable<double>(balance.value);
    }
    if (referenceNumber.present) {
      map['reference_number'] = Variable<String>(referenceNumber.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SmsTransactionsCompanion(')
          ..write('id: $id, ')
          ..write('sender: $sender, ')
          ..write('messageBody: $messageBody, ')
          ..write('amount: $amount, ')
          ..write('transactionType: $transactionType, ')
          ..write('category: $category, ')
          ..write('transactionDate: $transactionDate, ')
          ..write('balance: $balance, ')
          ..write('referenceNumber: $referenceNumber, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CategoriesTable extends Categories
    with TableInfo<$CategoriesTable, Category> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _iconMeta = const VerificationMeta('icon');
  @override
  late final GeneratedColumn<String> icon = GeneratedColumn<String>(
    'icon',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<String> color = GeneratedColumn<String>(
    'color',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, icon, color, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'categories';
  @override
  VerificationContext validateIntegrity(
    Insertable<Category> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('icon')) {
      context.handle(
        _iconMeta,
        icon.isAcceptableOrUnknown(data['icon']!, _iconMeta),
      );
    } else if (isInserting) {
      context.missing(_iconMeta);
    }
    if (data.containsKey('color')) {
      context.handle(
        _colorMeta,
        color.isAcceptableOrUnknown(data['color']!, _colorMeta),
      );
    } else if (isInserting) {
      context.missing(_colorMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Category map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Category(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      icon: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon'],
      )!,
      color: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}color'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $CategoriesTable createAlias(String alias) {
    return $CategoriesTable(attachedDatabase, alias);
  }
}

class Category extends DataClass implements Insertable<Category> {
  final int id;
  final String name;
  final String icon;
  final String color;
  final DateTime createdAt;
  const Category({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['icon'] = Variable<String>(icon);
    map['color'] = Variable<String>(color);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  CategoriesCompanion toCompanion(bool nullToAbsent) {
    return CategoriesCompanion(
      id: Value(id),
      name: Value(name),
      icon: Value(icon),
      color: Value(color),
      createdAt: Value(createdAt),
    );
  }

  factory Category.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Category(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      icon: serializer.fromJson<String>(json['icon']),
      color: serializer.fromJson<String>(json['color']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'icon': serializer.toJson<String>(icon),
      'color': serializer.toJson<String>(color),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Category copyWith({
    int? id,
    String? name,
    String? icon,
    String? color,
    DateTime? createdAt,
  }) => Category(
    id: id ?? this.id,
    name: name ?? this.name,
    icon: icon ?? this.icon,
    color: color ?? this.color,
    createdAt: createdAt ?? this.createdAt,
  );
  Category copyWithCompanion(CategoriesCompanion data) {
    return Category(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      icon: data.icon.present ? data.icon.value : this.icon,
      color: data.color.present ? data.color.value : this.color,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Category(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('icon: $icon, ')
          ..write('color: $color, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, icon, color, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Category &&
          other.id == this.id &&
          other.name == this.name &&
          other.icon == this.icon &&
          other.color == this.color &&
          other.createdAt == this.createdAt);
}

class CategoriesCompanion extends UpdateCompanion<Category> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> icon;
  final Value<String> color;
  final Value<DateTime> createdAt;
  const CategoriesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.icon = const Value.absent(),
    this.color = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  CategoriesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String icon,
    required String color,
    required DateTime createdAt,
  }) : name = Value(name),
       icon = Value(icon),
       color = Value(color),
       createdAt = Value(createdAt);
  static Insertable<Category> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? icon,
    Expression<String>? color,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (icon != null) 'icon': icon,
      if (color != null) 'color': color,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  CategoriesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? icon,
    Value<String>? color,
    Value<DateTime>? createdAt,
  }) {
    return CategoriesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (icon.present) {
      map['icon'] = Variable<String>(icon.value);
    }
    if (color.present) {
      map['color'] = Variable<String>(color.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('icon: $icon, ')
          ..write('color: $color, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $AnalyticsCacheTable extends AnalyticsCache
    with TableInfo<$AnalyticsCacheTable, AnalyticsCacheData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AnalyticsCacheTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _monthMeta = const VerificationMeta('month');
  @override
  late final GeneratedColumn<DateTime> month = GeneratedColumn<DateTime>(
    'month',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalIncomeMeta = const VerificationMeta(
    'totalIncome',
  );
  @override
  late final GeneratedColumn<double> totalIncome = GeneratedColumn<double>(
    'total_income',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _totalExpensesMeta = const VerificationMeta(
    'totalExpenses',
  );
  @override
  late final GeneratedColumn<double> totalExpenses = GeneratedColumn<double>(
    'total_expenses',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _savingsMeta = const VerificationMeta(
    'savings',
  );
  @override
  late final GeneratedColumn<double> savings = GeneratedColumn<double>(
    'savings',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    month,
    totalIncome,
    totalExpenses,
    savings,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'analytics_cache';
  @override
  VerificationContext validateIntegrity(
    Insertable<AnalyticsCacheData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('month')) {
      context.handle(
        _monthMeta,
        month.isAcceptableOrUnknown(data['month']!, _monthMeta),
      );
    } else if (isInserting) {
      context.missing(_monthMeta);
    }
    if (data.containsKey('total_income')) {
      context.handle(
        _totalIncomeMeta,
        totalIncome.isAcceptableOrUnknown(
          data['total_income']!,
          _totalIncomeMeta,
        ),
      );
    }
    if (data.containsKey('total_expenses')) {
      context.handle(
        _totalExpensesMeta,
        totalExpenses.isAcceptableOrUnknown(
          data['total_expenses']!,
          _totalExpensesMeta,
        ),
      );
    }
    if (data.containsKey('savings')) {
      context.handle(
        _savingsMeta,
        savings.isAcceptableOrUnknown(data['savings']!, _savingsMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {month},
  ];
  @override
  AnalyticsCacheData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AnalyticsCacheData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      month: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}month'],
      )!,
      totalIncome: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_income'],
      )!,
      totalExpenses: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_expenses'],
      )!,
      savings: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}savings'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $AnalyticsCacheTable createAlias(String alias) {
    return $AnalyticsCacheTable(attachedDatabase, alias);
  }
}

class AnalyticsCacheData extends DataClass
    implements Insertable<AnalyticsCacheData> {
  final int id;
  final DateTime month;
  final double totalIncome;
  final double totalExpenses;
  final double savings;
  final DateTime updatedAt;
  const AnalyticsCacheData({
    required this.id,
    required this.month,
    required this.totalIncome,
    required this.totalExpenses,
    required this.savings,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['month'] = Variable<DateTime>(month);
    map['total_income'] = Variable<double>(totalIncome);
    map['total_expenses'] = Variable<double>(totalExpenses);
    map['savings'] = Variable<double>(savings);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  AnalyticsCacheCompanion toCompanion(bool nullToAbsent) {
    return AnalyticsCacheCompanion(
      id: Value(id),
      month: Value(month),
      totalIncome: Value(totalIncome),
      totalExpenses: Value(totalExpenses),
      savings: Value(savings),
      updatedAt: Value(updatedAt),
    );
  }

  factory AnalyticsCacheData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AnalyticsCacheData(
      id: serializer.fromJson<int>(json['id']),
      month: serializer.fromJson<DateTime>(json['month']),
      totalIncome: serializer.fromJson<double>(json['totalIncome']),
      totalExpenses: serializer.fromJson<double>(json['totalExpenses']),
      savings: serializer.fromJson<double>(json['savings']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'month': serializer.toJson<DateTime>(month),
      'totalIncome': serializer.toJson<double>(totalIncome),
      'totalExpenses': serializer.toJson<double>(totalExpenses),
      'savings': serializer.toJson<double>(savings),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  AnalyticsCacheData copyWith({
    int? id,
    DateTime? month,
    double? totalIncome,
    double? totalExpenses,
    double? savings,
    DateTime? updatedAt,
  }) => AnalyticsCacheData(
    id: id ?? this.id,
    month: month ?? this.month,
    totalIncome: totalIncome ?? this.totalIncome,
    totalExpenses: totalExpenses ?? this.totalExpenses,
    savings: savings ?? this.savings,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  AnalyticsCacheData copyWithCompanion(AnalyticsCacheCompanion data) {
    return AnalyticsCacheData(
      id: data.id.present ? data.id.value : this.id,
      month: data.month.present ? data.month.value : this.month,
      totalIncome: data.totalIncome.present
          ? data.totalIncome.value
          : this.totalIncome,
      totalExpenses: data.totalExpenses.present
          ? data.totalExpenses.value
          : this.totalExpenses,
      savings: data.savings.present ? data.savings.value : this.savings,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AnalyticsCacheData(')
          ..write('id: $id, ')
          ..write('month: $month, ')
          ..write('totalIncome: $totalIncome, ')
          ..write('totalExpenses: $totalExpenses, ')
          ..write('savings: $savings, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, month, totalIncome, totalExpenses, savings, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AnalyticsCacheData &&
          other.id == this.id &&
          other.month == this.month &&
          other.totalIncome == this.totalIncome &&
          other.totalExpenses == this.totalExpenses &&
          other.savings == this.savings &&
          other.updatedAt == this.updatedAt);
}

class AnalyticsCacheCompanion extends UpdateCompanion<AnalyticsCacheData> {
  final Value<int> id;
  final Value<DateTime> month;
  final Value<double> totalIncome;
  final Value<double> totalExpenses;
  final Value<double> savings;
  final Value<DateTime> updatedAt;
  const AnalyticsCacheCompanion({
    this.id = const Value.absent(),
    this.month = const Value.absent(),
    this.totalIncome = const Value.absent(),
    this.totalExpenses = const Value.absent(),
    this.savings = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  AnalyticsCacheCompanion.insert({
    this.id = const Value.absent(),
    required DateTime month,
    this.totalIncome = const Value.absent(),
    this.totalExpenses = const Value.absent(),
    this.savings = const Value.absent(),
    required DateTime updatedAt,
  }) : month = Value(month),
       updatedAt = Value(updatedAt);
  static Insertable<AnalyticsCacheData> custom({
    Expression<int>? id,
    Expression<DateTime>? month,
    Expression<double>? totalIncome,
    Expression<double>? totalExpenses,
    Expression<double>? savings,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (month != null) 'month': month,
      if (totalIncome != null) 'total_income': totalIncome,
      if (totalExpenses != null) 'total_expenses': totalExpenses,
      if (savings != null) 'savings': savings,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  AnalyticsCacheCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? month,
    Value<double>? totalIncome,
    Value<double>? totalExpenses,
    Value<double>? savings,
    Value<DateTime>? updatedAt,
  }) {
    return AnalyticsCacheCompanion(
      id: id ?? this.id,
      month: month ?? this.month,
      totalIncome: totalIncome ?? this.totalIncome,
      totalExpenses: totalExpenses ?? this.totalExpenses,
      savings: savings ?? this.savings,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (month.present) {
      map['month'] = Variable<DateTime>(month.value);
    }
    if (totalIncome.present) {
      map['total_income'] = Variable<double>(totalIncome.value);
    }
    if (totalExpenses.present) {
      map['total_expenses'] = Variable<double>(totalExpenses.value);
    }
    if (savings.present) {
      map['savings'] = Variable<double>(savings.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AnalyticsCacheCompanion(')
          ..write('id: $id, ')
          ..write('month: $month, ')
          ..write('totalIncome: $totalIncome, ')
          ..write('totalExpenses: $totalExpenses, ')
          ..write('savings: $savings, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $SmsTransactionsTable smsTransactions = $SmsTransactionsTable(
    this,
  );
  late final $CategoriesTable categories = $CategoriesTable(this);
  late final $AnalyticsCacheTable analyticsCache = $AnalyticsCacheTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    smsTransactions,
    categories,
    analyticsCache,
  ];
}

typedef $$SmsTransactionsTableCreateCompanionBuilder =
    SmsTransactionsCompanion Function({
      required String id,
      required String sender,
      required String messageBody,
      required double amount,
      required String transactionType,
      required String category,
      required DateTime transactionDate,
      Value<double?> balance,
      Value<String?> referenceNumber,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$SmsTransactionsTableUpdateCompanionBuilder =
    SmsTransactionsCompanion Function({
      Value<String> id,
      Value<String> sender,
      Value<String> messageBody,
      Value<double> amount,
      Value<String> transactionType,
      Value<String> category,
      Value<DateTime> transactionDate,
      Value<double?> balance,
      Value<String?> referenceNumber,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$SmsTransactionsTableFilterComposer
    extends Composer<_$AppDatabase, $SmsTransactionsTable> {
  $$SmsTransactionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sender => $composableBuilder(
    column: $table.sender,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get messageBody => $composableBuilder(
    column: $table.messageBody,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get transactionType => $composableBuilder(
    column: $table.transactionType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get transactionDate => $composableBuilder(
    column: $table.transactionDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get balance => $composableBuilder(
    column: $table.balance,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get referenceNumber => $composableBuilder(
    column: $table.referenceNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SmsTransactionsTableOrderingComposer
    extends Composer<_$AppDatabase, $SmsTransactionsTable> {
  $$SmsTransactionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sender => $composableBuilder(
    column: $table.sender,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get messageBody => $composableBuilder(
    column: $table.messageBody,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get transactionType => $composableBuilder(
    column: $table.transactionType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get transactionDate => $composableBuilder(
    column: $table.transactionDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get balance => $composableBuilder(
    column: $table.balance,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get referenceNumber => $composableBuilder(
    column: $table.referenceNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SmsTransactionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SmsTransactionsTable> {
  $$SmsTransactionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get sender =>
      $composableBuilder(column: $table.sender, builder: (column) => column);

  GeneratedColumn<String> get messageBody => $composableBuilder(
    column: $table.messageBody,
    builder: (column) => column,
  );

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get transactionType => $composableBuilder(
    column: $table.transactionType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<DateTime> get transactionDate => $composableBuilder(
    column: $table.transactionDate,
    builder: (column) => column,
  );

  GeneratedColumn<double> get balance =>
      $composableBuilder(column: $table.balance, builder: (column) => column);

  GeneratedColumn<String> get referenceNumber => $composableBuilder(
    column: $table.referenceNumber,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$SmsTransactionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SmsTransactionsTable,
          SmsTransaction,
          $$SmsTransactionsTableFilterComposer,
          $$SmsTransactionsTableOrderingComposer,
          $$SmsTransactionsTableAnnotationComposer,
          $$SmsTransactionsTableCreateCompanionBuilder,
          $$SmsTransactionsTableUpdateCompanionBuilder,
          (
            SmsTransaction,
            BaseReferences<
              _$AppDatabase,
              $SmsTransactionsTable,
              SmsTransaction
            >,
          ),
          SmsTransaction,
          PrefetchHooks Function()
        > {
  $$SmsTransactionsTableTableManager(
    _$AppDatabase db,
    $SmsTransactionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SmsTransactionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SmsTransactionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SmsTransactionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> sender = const Value.absent(),
                Value<String> messageBody = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<String> transactionType = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<DateTime> transactionDate = const Value.absent(),
                Value<double?> balance = const Value.absent(),
                Value<String?> referenceNumber = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SmsTransactionsCompanion(
                id: id,
                sender: sender,
                messageBody: messageBody,
                amount: amount,
                transactionType: transactionType,
                category: category,
                transactionDate: transactionDate,
                balance: balance,
                referenceNumber: referenceNumber,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String sender,
                required String messageBody,
                required double amount,
                required String transactionType,
                required String category,
                required DateTime transactionDate,
                Value<double?> balance = const Value.absent(),
                Value<String?> referenceNumber = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => SmsTransactionsCompanion.insert(
                id: id,
                sender: sender,
                messageBody: messageBody,
                amount: amount,
                transactionType: transactionType,
                category: category,
                transactionDate: transactionDate,
                balance: balance,
                referenceNumber: referenceNumber,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SmsTransactionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SmsTransactionsTable,
      SmsTransaction,
      $$SmsTransactionsTableFilterComposer,
      $$SmsTransactionsTableOrderingComposer,
      $$SmsTransactionsTableAnnotationComposer,
      $$SmsTransactionsTableCreateCompanionBuilder,
      $$SmsTransactionsTableUpdateCompanionBuilder,
      (
        SmsTransaction,
        BaseReferences<_$AppDatabase, $SmsTransactionsTable, SmsTransaction>,
      ),
      SmsTransaction,
      PrefetchHooks Function()
    >;
typedef $$CategoriesTableCreateCompanionBuilder =
    CategoriesCompanion Function({
      Value<int> id,
      required String name,
      required String icon,
      required String color,
      required DateTime createdAt,
    });
typedef $$CategoriesTableUpdateCompanionBuilder =
    CategoriesCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> icon,
      Value<String> color,
      Value<DateTime> createdAt,
    });

class $$CategoriesTableFilterComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get icon => $composableBuilder(
    column: $table.icon,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CategoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get icon => $composableBuilder(
    column: $table.icon,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CategoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get icon =>
      $composableBuilder(column: $table.icon, builder: (column) => column);

  GeneratedColumn<String> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$CategoriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CategoriesTable,
          Category,
          $$CategoriesTableFilterComposer,
          $$CategoriesTableOrderingComposer,
          $$CategoriesTableAnnotationComposer,
          $$CategoriesTableCreateCompanionBuilder,
          $$CategoriesTableUpdateCompanionBuilder,
          (Category, BaseReferences<_$AppDatabase, $CategoriesTable, Category>),
          Category,
          PrefetchHooks Function()
        > {
  $$CategoriesTableTableManager(_$AppDatabase db, $CategoriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CategoriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> icon = const Value.absent(),
                Value<String> color = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => CategoriesCompanion(
                id: id,
                name: name,
                icon: icon,
                color: color,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String icon,
                required String color,
                required DateTime createdAt,
              }) => CategoriesCompanion.insert(
                id: id,
                name: name,
                icon: icon,
                color: color,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CategoriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CategoriesTable,
      Category,
      $$CategoriesTableFilterComposer,
      $$CategoriesTableOrderingComposer,
      $$CategoriesTableAnnotationComposer,
      $$CategoriesTableCreateCompanionBuilder,
      $$CategoriesTableUpdateCompanionBuilder,
      (Category, BaseReferences<_$AppDatabase, $CategoriesTable, Category>),
      Category,
      PrefetchHooks Function()
    >;
typedef $$AnalyticsCacheTableCreateCompanionBuilder =
    AnalyticsCacheCompanion Function({
      Value<int> id,
      required DateTime month,
      Value<double> totalIncome,
      Value<double> totalExpenses,
      Value<double> savings,
      required DateTime updatedAt,
    });
typedef $$AnalyticsCacheTableUpdateCompanionBuilder =
    AnalyticsCacheCompanion Function({
      Value<int> id,
      Value<DateTime> month,
      Value<double> totalIncome,
      Value<double> totalExpenses,
      Value<double> savings,
      Value<DateTime> updatedAt,
    });

class $$AnalyticsCacheTableFilterComposer
    extends Composer<_$AppDatabase, $AnalyticsCacheTable> {
  $$AnalyticsCacheTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get month => $composableBuilder(
    column: $table.month,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalIncome => $composableBuilder(
    column: $table.totalIncome,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalExpenses => $composableBuilder(
    column: $table.totalExpenses,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get savings => $composableBuilder(
    column: $table.savings,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AnalyticsCacheTableOrderingComposer
    extends Composer<_$AppDatabase, $AnalyticsCacheTable> {
  $$AnalyticsCacheTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get month => $composableBuilder(
    column: $table.month,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalIncome => $composableBuilder(
    column: $table.totalIncome,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalExpenses => $composableBuilder(
    column: $table.totalExpenses,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get savings => $composableBuilder(
    column: $table.savings,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AnalyticsCacheTableAnnotationComposer
    extends Composer<_$AppDatabase, $AnalyticsCacheTable> {
  $$AnalyticsCacheTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get month =>
      $composableBuilder(column: $table.month, builder: (column) => column);

  GeneratedColumn<double> get totalIncome => $composableBuilder(
    column: $table.totalIncome,
    builder: (column) => column,
  );

  GeneratedColumn<double> get totalExpenses => $composableBuilder(
    column: $table.totalExpenses,
    builder: (column) => column,
  );

  GeneratedColumn<double> get savings =>
      $composableBuilder(column: $table.savings, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$AnalyticsCacheTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AnalyticsCacheTable,
          AnalyticsCacheData,
          $$AnalyticsCacheTableFilterComposer,
          $$AnalyticsCacheTableOrderingComposer,
          $$AnalyticsCacheTableAnnotationComposer,
          $$AnalyticsCacheTableCreateCompanionBuilder,
          $$AnalyticsCacheTableUpdateCompanionBuilder,
          (
            AnalyticsCacheData,
            BaseReferences<
              _$AppDatabase,
              $AnalyticsCacheTable,
              AnalyticsCacheData
            >,
          ),
          AnalyticsCacheData,
          PrefetchHooks Function()
        > {
  $$AnalyticsCacheTableTableManager(
    _$AppDatabase db,
    $AnalyticsCacheTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AnalyticsCacheTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AnalyticsCacheTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AnalyticsCacheTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> month = const Value.absent(),
                Value<double> totalIncome = const Value.absent(),
                Value<double> totalExpenses = const Value.absent(),
                Value<double> savings = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => AnalyticsCacheCompanion(
                id: id,
                month: month,
                totalIncome: totalIncome,
                totalExpenses: totalExpenses,
                savings: savings,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required DateTime month,
                Value<double> totalIncome = const Value.absent(),
                Value<double> totalExpenses = const Value.absent(),
                Value<double> savings = const Value.absent(),
                required DateTime updatedAt,
              }) => AnalyticsCacheCompanion.insert(
                id: id,
                month: month,
                totalIncome: totalIncome,
                totalExpenses: totalExpenses,
                savings: savings,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AnalyticsCacheTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AnalyticsCacheTable,
      AnalyticsCacheData,
      $$AnalyticsCacheTableFilterComposer,
      $$AnalyticsCacheTableOrderingComposer,
      $$AnalyticsCacheTableAnnotationComposer,
      $$AnalyticsCacheTableCreateCompanionBuilder,
      $$AnalyticsCacheTableUpdateCompanionBuilder,
      (
        AnalyticsCacheData,
        BaseReferences<_$AppDatabase, $AnalyticsCacheTable, AnalyticsCacheData>,
      ),
      AnalyticsCacheData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$SmsTransactionsTableTableManager get smsTransactions =>
      $$SmsTransactionsTableTableManager(_db, _db.smsTransactions);
  $$CategoriesTableTableManager get categories =>
      $$CategoriesTableTableManager(_db, _db.categories);
  $$AnalyticsCacheTableTableManager get analyticsCache =>
      $$AnalyticsCacheTableTableManager(_db, _db.analyticsCache);
}

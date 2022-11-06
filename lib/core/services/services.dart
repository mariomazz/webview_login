import 'package:faker/faker.dart';

class UsersService {
  Future<List<User>> getAll() async {
    await Future.delayed(const Duration(seconds: 1));
    return User.fakerGenerate();
  }

  Future<UserDetail> getById(String userId) async {
    await Future.delayed(const Duration(seconds: 1));
    return UserDetail.faker(id: userId);
  }
}

class User {
  final String id;
  final String name;
  final String surname;
  final int age;
  final DateTime birthDate;

  User({
    required this.id,
    required this.name,
    required this.surname,
    required this.age,
    required this.birthDate,
  });

  static List<User> fakerGenerate() {
    return List<User>.generate(
      faker.randomGenerator.integer(100),
      (index) => User.faker(),
    );
  }

  factory User.faker() {
    return User(
      id: faker.guid.guid(),
      age: faker.date.random.integer(100),
      name: faker.person.firstName(),
      surname: faker.person.lastName(),
      birthDate: faker.date.dateTime(),
    );
  }
}

class UserDetail extends User {
  final String userDescription;
  final String userAvatar;
  UserDetail({
    required this.userDescription,
    required this.userAvatar,
    required super.id,
    required super.name,
    required super.surname,
    required super.age,
    required super.birthDate,
  });

  factory UserDetail.faker({String? id}) {
    return UserDetail(
      userDescription: faker.lorem.words(20).toString(),
      userAvatar: faker.image.image(),
      id: id ?? faker.guid.guid(),
      age: faker.date.random.integer(100),
      name: faker.person.firstName(),
      surname: faker.person.lastName(),
      birthDate: faker.date.dateTime(),
    );
  }

  UserDetail copyWith({
    String? userDescription,
    String? userAvatar,
    String? id,
    int? age,
    String? name,
    String? surname,
    DateTime? birthDate,
  }) {
    return UserDetail(
      userDescription: userDescription ?? this.userDescription,
      userAvatar: userAvatar ?? this.userAvatar,
      id: id ?? this.id,
      age: age ?? this.age,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      birthDate: birthDate ?? this.birthDate,
    );
  }
}

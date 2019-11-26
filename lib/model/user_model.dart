class User {
  String _id;
  String _email;
  String _password;

  User(
    this._id,
    this._email,
    this._password,
  );

  String get id => _id;
  String get email => _email;
  String get password => _password;
}
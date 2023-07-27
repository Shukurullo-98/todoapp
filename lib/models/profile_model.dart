class ProfileModel {
  ProfileModel({
    required this.firstName,
    required this.lastName,
    required this.imagePath,
    required this.userAge,
    required this.password,
    required this.userEmail,
  });

  final String firstName;
  final String lastName;
  final String imagePath;
  final int userAge;
  final String password;
  final String userEmail;
}

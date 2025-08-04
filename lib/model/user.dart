enum UserRole { admin, user }

class AppUser {
  final String username;
  final UserRole role;

  AppUser({required this.username, required this.role});
}
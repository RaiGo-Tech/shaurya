enum UserRole { student, teacher }

class AppUser {
  const AppUser({
    required this.id,
    required this.name,
    required this.role,
    required this.school,
    this.subtitle,
  });

  final String id;
  final String name;
  final UserRole role;
  final String school;
  final String? subtitle;

  bool get isTeacher => role == UserRole.teacher;
}

class AuthResult {
  const AuthResult.success(this.user) : error = null;
  const AuthResult.failure(this.error) : user = null;

  final AppUser? user;
  final String? error;

  bool get ok => user != null;
}

abstract final class DemoCredentials {
  static const studentId = 'STU-26-HR-00001245';
  static const studentPassword = 'Shaurya@Student1';

  static const teacherId = 'TCH-26-HR-00000891';
  static const teacherPassword = 'Shaurya@Teacher1';

  static const _accounts = {
    studentId: (
      password: studentPassword,
      user: AppUser(
        id: studentId,
        name: 'Aarav Sharma',
        role: UserRole.student,
        school: 'Green Valley School',
        subtitle: 'Class 8 · Haryana',
      ),
    ),
    teacherId: (
      password: teacherPassword,
      user: AppUser(
        id: teacherId,
        name: 'Priya Mehta',
        role: UserRole.teacher,
        school: 'Green Valley School',
        subtitle: 'Mathematics & Science',
      ),
    ),
  };

  static AuthResult signIn({
    required String userId,
    required String password,
    required UserRole role,
  }) {
    final id = userId.trim();
    final pass = password.trim();

    if (id.isEmpty || pass.isEmpty) {
      return const AuthResult.failure('Please enter your ID and password.');
    }

    final account = _accounts[id];
    if (account == null) {
      return const AuthResult.failure('Invalid ID or password.');
    }
    if (account.password != pass) {
      return const AuthResult.failure('Invalid ID or password.');
    }
    if (account.user.role != role) {
      return AuthResult.failure(
        role == UserRole.student
            ? 'This account is not a student account.'
            : 'This account is not a teacher account.',
      );
    }

    return AuthResult.success(account.user);
  }
}

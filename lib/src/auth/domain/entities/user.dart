import 'package:equatable/equatable.dart';

class LocalUser extends Equatable {
  const LocalUser({
    required this.uid,
    required this.email,
    required this.points,
    required this.fullName,
    this.groupId = const [],
    this.enrolledCourseId = const [],
    this.following = const [],
    this.followers = const [],
    this.profileImage,
    this.bio,
  });

  final String uid;
  final String email;
  final String? profileImage;
  final String? bio;
  final int points;
  final String fullName;
  final List<String> groupId;
  final List<String> enrolledCourseId;
  final List<String> following;
  final List<String> followers;

  const LocalUser.empty()
      : this(
          uid: '',
          email: '',
          points: 0,
          fullName: '',
          profileImage: '',
          bio: '',
          groupId: const [],
          enrolledCourseId: const [],
          following: const [],
          followers: const [],
        );

  @override
  List<Object?> get props => [
        uid,
        email,
        profileImage,
        bio,
        points,
        fullName,
        groupId.length,
        enrolledCourseId.length,
        followers.length,
        following.length,
      ];

  @override
  String toString() {
    return 'LocalUser{uid: $uid, email: $email, bio: $bio, '
        'points: $points, fullName: $fullName}';
  }
}

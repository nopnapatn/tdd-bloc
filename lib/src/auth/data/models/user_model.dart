import 'package:tdd_bloc/core/utils/typedefs.dart';
import 'package:tdd_bloc/src/auth/domain/entities/user.dart';

class LocalUserModel extends LocalUser {
  const LocalUserModel({
    required super.uid,
    required super.email,
    required super.points,
    required super.fullName,
    super.groupId,
    super.enrolledCourseId,
    super.following,
    super.followers,
    super.profileImage,
    super.bio,
  });

  const LocalUserModel.empty()
      : this(
          uid: '',
          email: '',
          points: 0,
          fullName: '',
        );

  LocalUserModel.fromMap(DataMap map)
      : super(
          uid: map['uid'] as String,
          email: map['email'] as String,
          points: (map['points'] as num).toInt(),
          fullName: map['fullName'] as String,
          profileImage: map['profileImage'] as String?,
          bio: map['bio'] as String?,
          groupId: (map['groupId'] as List<dynamic>).cast<String>(),
          enrolledCourseId:
              (map['enrolledCourseId'] as List<dynamic>).cast<String>(),
          following: (map['following'] as List<dynamic>).cast<String>(),
          followers: (map['followers'] as List<dynamic>).cast<String>(),
        );

  LocalUser copyWith({
    String? uid,
    String? email,
    int? points,
    String? fullName,
    String? profileImage,
    String? bio,
    List<String>? groupId,
    List<String>? enrolledCourseId,
    List<String>? following,
    List<String>? followers,
  }) {
    return LocalUser(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      points: points ?? this.points,
      fullName: fullName ?? this.fullName,
      profileImage: profileImage ?? this.profileImage,
      bio: bio ?? this.bio,
      groupId: groupId ?? this.groupId,
      enrolledCourseId: enrolledCourseId ?? this.enrolledCourseId,
      following: following ?? this.following,
      followers: followers ?? this.followers,
    );
  }

  DataMap toMap() {
    return {
      'uid': uid,
      'email': email,
      'bio': bio,
      'points': points,
      'fullName': fullName,
      'profileImage': profileImage,
      'groupId': groupId,
      'enrolledCourseId': enrolledCourseId,
      'following': following,
      'followers': followers,
    };
  }
}

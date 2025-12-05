/// User Profile Model
/// Represents a user in the ConnectMe app
class UserProfile {
  final String id;
  final String name;
  final int age;
  final String location;
  final String distance;
  final String bio;
  final List<String> interests;
  final String work;
  final String education;
  final String memberSince;
  final String email;
  final String phone;
  final String instagram;
  final List<String> languages;
  final String lookingFor;
  final List<String> favoriteSpots;
  final String image;
  final List<String> photos;

  UserProfile({
    required this.id,
    required this.name,
    required this.age,
    required this.location,
    required this.distance,
    required this.bio,
    required this.interests,
    required this.work,
    required this.education,
    required this.memberSince,
    required this.email,
    required this.phone,
    required this.instagram,
    required this.languages,
    required this.lookingFor,
    required this.favoriteSpots,
    required this.image,
    required this.photos,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'] as String,
      name: json['name'] as String,
      age: json['age'] as int,
      location: json['location'] as String,
      distance: json['distance'] as String,
      bio: json['bio'] as String,
      interests: List<String>.from(json['interests'] as List),
      work: json['work'] as String,
      education: json['education'] as String,
      memberSince: json['memberSince'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      instagram: json['instagram'] as String,
      languages: List<String>.from(json['languages'] as List),
      lookingFor: json['lookingFor'] as String,
      favoriteSpots: List<String>.from(json['favoriteSpots'] as List),
      image: json['image'] as String,
      photos: List<String>.from(json['photos'] as List),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'location': location,
      'distance': distance,
      'bio': bio,
      'interests': interests,
      'work': work,
      'education': education,
      'memberSince': memberSince,
      'email': email,
      'phone': phone,
      'instagram': instagram,
      'languages': languages,
      'lookingFor': lookingFor,
      'favoriteSpots': favoriteSpots,
      'image': image,
      'photos': photos,
    };
  }
}

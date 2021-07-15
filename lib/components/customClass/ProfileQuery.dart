class ProfileQuery {
  // userID:string
  // userName:string
  // accessToken:string
  // pictureURL?:string
  // email?:string
  // firstName?:string
  // lastName?:string
  // type?:userType

  final String userID;
  final String userName;
  final String accessToken;
  final String pictureURL;
  final String email;
  final String firstName;
  final String lastName;
  final String type;
  final String role;

  ProfileQuery({
    required String this.userID,
    required String this.userName,
    required String this.accessToken,
    required String this.pictureURL,
    required String this.email,
    required String this.firstName,
    required String this.lastName,
    required String this.type,
    required String this.role,
  });

  factory ProfileQuery.fromJson(Map<String, dynamic> json) {
    return ProfileQuery(
      userID: "${json['userID']}",
      userName: json['userName'] ,
      accessToken: json['accessToken'],
      pictureURL: json['pictureURL'],
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      type: json['type'],
      role: json['role']
    );
  }

}
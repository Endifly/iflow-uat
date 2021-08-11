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
    var general = json['general']!;
    var profile = json['profile']!;

    print("### general : ${general['userID']}");
    print("### profile : ${profile}");

    return ProfileQuery(
      userID: "${general['userID'] ?? ""}",
      userName: general['userName'] ?? "",
      accessToken: general['accessToken'] ?? "",
      pictureURL: "",
      email: profile['email'] ?? "",
      firstName: profile['firstName'] ?? "",
      lastName: profile['lastName'] ?? "",
      type: general['accountType'] ?? "", //user, admin
      role: general['userType']  ?? "", //premium,freemium
    );
  }

  factory ProfileQuery.invalid() {
    return ProfileQuery(
        userID: "",
        userName: "" ,
        accessToken: "",
        pictureURL: "",
        email: "",
        firstName: "",
        lastName: "",
        type: "",
        role: ""
    );
  }

}
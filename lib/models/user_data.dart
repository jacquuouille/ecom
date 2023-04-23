class UserData {
  String email;
  String uid; 

  UserData({
    required this.email, required this.uid
  });

  UserData.fromMap(Map<String, dynamic> map) 
    : email = map['email'] ?? "", 
    uid = map ['uid'] ?? "";

    Map<String, dynamic> toMap() {
      return {
        'email' : email, 
        'uid' : uid,
      };
    }

// then, create a function that takes in a User Data as a parameters into firestore_service.dart

}


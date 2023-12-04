class UserDateAuth{
  String? id;
  String? message;
  String? isAuthenticated;
  String? displayName;
  String? email;
  String? roles;
  String? token;
  String? expiresOn;
  String? refreshToken;
  String? refreshTokenExpiration;


  UserDateAuth(
      { this.id,
         this.message,
          this.isAuthenticated,
            this.displayName,
           this.email,
           this.roles,
           this.token,
           this.expiresOn,
          this.refreshToken,
          this.refreshTokenExpiration});

  factory UserDateAuth.fromJson(Map<String, dynamic> json) {

    return  UserDateAuth(
    id :  json['id'],
    message : json['message'] ,
    isAuthenticated : json['isAuthenticated'] ,
    displayName : json['displayName'] ,
    email : json['email'] ,
    roles : json['roles'],
    token : json['token'],
    expiresOn : json['expiresOn'],
    refreshToken : json['refreshToken'],
    refreshTokenExpiration : json['refreshTokenExpiration']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['message'] = this.message;
    data['isAuthenticated'] = this.isAuthenticated;
    data['displayName'] = this.displayName;
    data['email'] = this.email;
    data['roles'] = this.roles;
    data['token'] = this.token;
    data['expiresOn'] = this.expiresOn;
    data['refreshToken'] = this.refreshToken;
    data['refreshTokenExpiration'] = this.refreshTokenExpiration;
    return data;
  }
}
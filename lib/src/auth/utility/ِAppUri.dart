class AppUri {
  static String BaseUri = 'http://newsappnew.somee.com/';
  static String Userlogin = 'api/UserAuth/UserLogin';
  static String LoginAuthor = 'api/AuthorAuth/AutherLogin';
  static String LoginAdmin = 'AdminLogin';
  static String RegisterUser = 'api/UserAuth/UserRegister';
  static String NewsAll = 'api/Article?pageNumber=1&pageSize=10';
  static String SetLike = 'api/Article/';
  static String reportAuthor =
      'api/AuthorLog/GetAllAuthorLog?pageNumber=1&pageSize=200';
  static String reportUser =
      'api/UserLog/GetAllUsersLog?pageNumber=1&pageSize=200';
  static String Users = 'api/User?pageNumber=1&pageSize=200';
  static String Authors = 'api/Author';
  static String profileuser = 'api/User/';
  static String SetComment = 'api/Article/';
  static String RegisterAuthor = 'api/AuthorAuth/AuthorRegister';
  static String AddCategory = 'api/Category';
}

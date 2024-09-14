import 'package:googleapis_auth/auth_io.dart';

class ServerService {
  Future<String> getServiceKey() async {
    try{
    final scopes = [
      'https://www.googleapis.com/auth/userinfo.email',
      'https://www.googleapis.com/auth/firebase.database',
      'https://www.googleapis.com/auth/firebase.messaging'
    ];


    final client = await clientViaServiceAccount(
//this is downloaded json
        ServiceAccountCredentials.fromJson({
          "type": "service_account",
          "project_id": "fire-notifications-b065c",
          "private_key_id": "9f1124ba254fb3ac0bebc09593af18107b41c402",
          "private_key":
          "-----BEGIN PRIVATE KEY-----\nMIIEugIBADANBgkqhkiG9w0BAQEFAASCBKQwggSgAgEAAoIBAQCkjXJoshbjLilP\nUAx6oefQUUoNzHYmcBjuK95cD4YPt3Cnyc9QVBeQJlMdoMJhQccqjx8ojQrCvzVB\nJiNLkcIAmQ5fhX6iWl3FuFvvyjkzRU3JpPwCR9YPVLL1+PiC1506lzDopMzM1iOS\nEAp048/CnJzoRvW5bC2ZiZrRnrJ9/DiE9PfvjDqndnagACnQp2j6zq2Fk95m4TFT\nuZloCFmy6LcxLWKCwX2D6Cv9N8cH/d+GAhV+xi/hY+ZncjkMIQN7Cq4erawy1KtH\nFfJcjRDiFS1nzrMi/bAkMqAQJ7A2cohO5gUslBRIKkfb9+8YTjvFzutokYHxFfqP\n1u9RDkD3AgMBAAECggEAJg97a4Dpr1FRh8FNqZ3CRxpORSPKHjjmY0xtSaDjksYM\nvhp9I6jXrGVY6yzwWNuEjDD/dXsuBn6AfFmsZ0HG/ClqvChd8oJxVxa92RhOo6+/\nfsj06zgfaHtgS2lzXZwuh0tKKj1YC3bqUlH4gTHiL7LWzhj/pAxD/dPopdyNj3sE\nteBlio6PRc4Qz6nWmii6TcEICKfzzdQx+KMv2YGJnS+ZLBo/+Sp7d+kOEg3L0+3e\nYwmQBKv3oZyrOQIYaKOYB8v+T5cdThk6Umi+GsJ9zqnL73vNg+7tPFNEC0g2XqKt\n7wg4QeoCI/3Z6qLq1OSyH0Pf+ml+xeQ9Jg65cYG18QKBgQDWD4wHon3rV12buaVW\nQ1DwYBfj9u84Y6kfT20np3WnpzL7rF3S5HE3ChX6tRlXlFZBSz2IFdbwKGii6i/o\n+aBjIyso0u5ff0hx4T68jippH5h6O854HLMYMWniwAoDB5ndJJ4R69Q/HfJohCtz\npqBUeYf1SmqMC3rA+0a7Q8uKkQKBgQDEysLaWNvrEz4+Xhb3DRmZIaDYPQOjDWk8\nP6Qgz+0jZ3OXmkTBaAKhJF3GH8ich/N5f9DsDCjOqcBvsxw0t8U9g+ijdPKDz/yo\nqdtbIzaXw5Mb38NzLITSPgM+E4rBQdhDGte29bGR1OQD+251JeBH4d+ABagCOipa\nE6HioTuHBwKBgGegExvHD8oT+x7d2ipOYCpdenNDIT9dD4w2uRLPQGeuy0GGic0E\nBcKtQUKi1OfOyYrGT71HRUvxY+YqFJNl9LzJU6VppzfXuExYzDQfZmyJfRj/Rs5i\nplh541Z/vNkGnvetOFBYp+D+MFFkWlycN1Vtl+Go6rds/znY6r7Q7QHhAoGADhti\n4HgiO7XDboEcMFWWEi4g859cFWIuuwzs3RVKsJEH7kQ2zY6BMcADoOJCZUYxo/IP\nrfwpKLdufhNe4ECUORatpJoLkHtmZ0jV2rCphzOT5hmiTy1P0Cp13QtVlQj9UcIo\n2IrAUe3q8oYhovA2JbEBbpH5Oz+kLZTes/pO5B0Cfz15ZVbLvbh8rcEgEBdXqUVB\ntCJ1/CTUV7uI19L8L9q/SxbbZCVq91HfzCJnMJOW9S07uUJTppyzL9Sc4nKiPmyK\nGLK0VLtQGpqQQAKwNJOBdP0ZWkzMUxdijiOy8YL1X5uR3Rhox68/rD8rprEjIdF5\nL7V5Ky1masOKXEKzotE=\n-----END PRIVATE KEY-----\n",
          "client_email": "firebase-adminsdk-tf24z@fire-notifications-b065c.iam.gserviceaccount.com",
          "client_id": "107536208266138831901",
          "auth_uri": "https://accounts.google.com/o/oauth2/auth",
          "token_uri": "https://oauth2.googleapis.com/token",
          "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
          "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-tf24z%40fire-notifications-b065c.iam.gserviceaccount.com",
          "universe_domain": "googleapis.com"
        }),
        scopes);
    final serverKey = client.credentials.accessToken.data;
    return serverKey;}catch(e){
      print('ERROR is $e');
      return '';

    }
  }
}
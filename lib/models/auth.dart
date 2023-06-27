import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/exceptions/exception.dart';

class Auth with ChangeNotifier{
    static const _url = 
      'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyA-KCKm8gO6vz9oN9Nu8bChyAu_G06nqKc';
    
  
    Future<void> signup(String email, String password) async{
      return authenticate(email, password, 'signUp');
    }

    Future<void> login(String email, String password) async{
      return authenticate(email, password, 'signInWithPassword');
    }

    Future<void> authenticate(String email, String password, String urlFragment) async {
      final url = 'https://identitytoolkit.googleapis.com/v1/accounts:$urlFragment?key=AIzaSyA-KCKm8gO6vz9oN9Nu8bChyAu_G06nqKc';
      final response = await http.post(
        Uri.parse(url),
        body: jsonEncode({
          'email': email,
          'password': password,
          'returnSecureToken': true,
        })
      );

      final body = jsonDecode(response.body);

      if(body['error'] != null){
        throw AuthException(body['error']['message']);
      }
      
      print(body);
    }
}
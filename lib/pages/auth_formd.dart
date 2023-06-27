import 'package:flutter/material.dart';

enum AuthMode {SignUp, Login}

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  AuthMode _authMode = AuthMode.Login;
  final _passWordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  bool _isLogin() => _authMode == AuthMode.Login;
  bool _isSignup() => _authMode == AuthMode.SignUp;

  void switchAuthMode(){
    setState(() {
      if(_isLogin()){
        _authMode = AuthMode.SignUp;
      }else{
        _authMode = AuthMode.Login;
      }
    });
  }

  void _submit(){
    final isValid = _formKey.currentState?.validate() ?? false;

    if(!isValid){
      return;
    }

    setState(() => _isLoading = true);

    if(_isLogin()){

    }else{
      
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: const EdgeInsets.all(10),
        height: _isLogin()? 310 : 400,
        width: deviceSize.width * 0.75,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'E-mail'),
                keyboardType: TextInputType.emailAddress,
                obscureText: true,
                onSaved: (email) => _authData['email'] = email ?? '',
                validator: (_email) {
                  final email = _email ?? '';
                  if(email.trim().isEmpty || !email.contains('@')){
                    return 'Informe um e-mail válido';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Senha'),
                keyboardType: TextInputType.emailAddress,
                obscureText: true,
                controller: _passWordController,
                onSaved: (password) => _authData['password'] = password ?? '',
                validator: (_password){
                  final password = _password ?? '';
                  if(password.isEmpty || password.length < 5){
                    return 'Informa uma senha válida';
                  }
                  return null;
                },
              ),
              Visibility(
                visible: _isSignup(),
                child: TextFormField(
                  decoration: const InputDecoration(labelText: 'Confirmar Senha'),
                  keyboardType: TextInputType.emailAddress,
                  obscureText: true,
                  validator: _isLogin() ? 
                    null 
                  : (_password) {
                    final password = _password ?? '';
                    if(password != _passWordController){
                      return 'Senhas informadas não conferem';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20,),
              if(_isLoading)
                const CircularProgressIndicator()
              else 
                ElevatedButton(
                  onPressed: _submit, 
                  child: Text(
                    _authMode == AuthMode.Login ? 'ENTRAR' : 'REGISTRAR',
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 8,
                    )
                  ),
                ),
                Spacer(),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    _isLogin() ? 'Deseja Registrar?' : 'Já Possui Conta?'
                  ),
                )
            ],
          )
        )
      )
    );
  }
}
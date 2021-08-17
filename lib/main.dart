import 'package:flutter/material.dart';
import 'package:hng_8/util.dart';

import 'model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const UserInfo(),
    );
  }
}

class UserInfo extends StatefulWidget {
  const UserInfo({Key? key}) : super(key: key);

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  late String _currentName;
  late String _currentEmail;
  late Icon _currentIcon;
  late final List<User> _userInput = [];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool checkMe = false;
  bool showMessage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inyene Etoedia'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(
            top: 30,
            left: 30,
            right: 30,
          ),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: 'Enter your name',
                        labelStyle: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w300,
                            color: Colors.black)),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Name is required';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _currentName = value!;
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: 'Enter email',
                        labelStyle: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w300,
                            color: Colors.black)),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Email is required';
                      }
                      // return null;

                      if (!value.contains("@")) {
                        return 'This is not an email address';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _currentEmail = value!;
                    },
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text('Accept Terms and Conditions',
                          style: TextStyle(
                            fontSize: 12,
                          )),
                      Checkbox(
                          focusColor: Colors.lightBlue,
                          activeColor: Colors.orange,
                          value: checkMe,
                          onChanged: (newValue) {
                            setState(() {
                              checkMe = newValue!;
                            });
                          })
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 150,
                    child: ListView.builder(
                      itemBuilder: (context, index) => Container(
                        child: ListTile(
                          title: Text(_userInput[index].name),
                          subtitle: Text(_userInput[index].email),
                        ),
                      ),
                      itemCount: _userInput.length,
                    ),
                  ),
                  showMessage
                      ? Container()
                      : ElevatedButton(
                          onPressed: () {
                            if (!_formKey.currentState!.validate()) {
                              if (checkMe != true) {
                                setState(() {
                                  showMessage = true;
                                });
                              } else {
                                setState(() => showMessage = false);
                              }
                            }

                            if (checkMe != true) {
                              setState(() {
                                showMessage = true;
                                showMessage = false;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'Please accept Terms and conditions'),
                                  ),
                                );
                              });
                            } else {
                              setState(() {
                                _formKey.currentState!.save();
                                _userInput.add(User(
                                  _currentName,
                                  _currentEmail,
                                ));
                              });
                            }
                          },
                          child: const Text(
                            'Enter',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitlife/Reposetory/Firebase/FireStore/Fetchdata.dart';
import 'package:fitlife/Utility/alertbox.dart';
import 'package:fitlife/Utility/custom.dart';
import 'package:fitlife/Utility/richtext.dart';
import 'package:fitlife/Utility/textpadding.dart';
import 'package:fitlife/View/LoginPage.dart';
import 'package:fitlife/ViewModel/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  bool isSelected = true;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) return;

      final FirebaseUser = FirebaseAuth.instance.currentUser;

      if (FirebaseUser != null) {
        context.read<CurrentUserProvider>().fetchCurrentUser(FirebaseUser.uid);
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Setting")),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            Consumer<CurrentUserProvider>(
              builder: (_, provider, __) {
                if (provider.currentUser.toString().isEmpty ||
                    provider.currentUser == null) {
                  return Center(child: Text("Data is not Found"!));
                }
                return Column(
                  children: [
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: CircleAvatar(
                        backgroundColor: Colors.lightBlueAccent,
                        child: textpadding.TextPadding(
                          padding: 2,
                          text: provider.currentUser!.name
                              .toString()
                              .substring(0, 1)
                              .toUpperCase(),
                          isBold: true,
                          isLines: false,
                          fontSize: 40,
                        ),
                      ),
                    ),

                    textpadding.TextPadding(
                      padding: 2,
                      text: provider.currentUser!.name.toString(),
                      isBold: true,
                      isLines: false,
                      fontSize: 30,
                    ),
                    textpadding.TextPadding(
                      padding: 2,
                      text: provider.currentUser!.email.toString(),
                      isBold: false,
                      isLines: false,
                      fontSize: 18,
                    ),
                  ],
                );
              },
            ),

            SizedBox(height: 20),
            Card(
              child: SwitchListTile.adaptive(
                title: Text("Theme Mode"),
                subtitle: Text("Theme mode only have dark and light mode"),
                value: isSelected,
                onChanged: (value) {},
              ),
            ),
            InkWell(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return UserInfo();
                  },
                );
              },
              child: Card(
                child: ListTile(
                  leading: Icon(Icons.supervised_user_circle_sharp, size: 30),
                  title: Text(
                    "User Info",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),

                  subtitle: Text("Check your Information"),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
              ),
            ),
            InkWell(
              onTap: (){
                showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context){
                      return ConformPass();
                    });
              },
              child: Card(
                child: ListTile(
                  leading: Icon(Icons.lock, size: 30),
                  title: Text(
                    "Conform PassWord",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text("For Conform your Password"),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.email, size: 30),
                title: Text(
                  "Forgot password",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text("Message will send to youe email"),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ),

            SizedBox(height: 10),

            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: customWidget.elevatedButton(
                  callback: () async {
                    await FirebaseAuth.instance.signOut().then((value) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => loginpage()),
                      );
                    });
                  },
                  text: "Log Out",
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UserInfo extends StatelessWidget {
  const UserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: double.infinity,
      color: Colors.grey,
      child: Consumer<CurrentUserProvider>(
        builder: (_, provider, __) {
          return Center(
              child:  Padding(
                padding: const EdgeInsets.all(25.0),
                child: Card(
                  surfaceTintColor: Colors.lightBlue,
                  elevation: 8,
                  shadowColor: Colors.lightBlue,
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          richText(
                            text1: "User : ",
                            text2: provider.currentUser!.name.toString(),
                            text1Size: 22,
                            text2Size: 20,
                            color1: Colors.black,
                            color2: Colors.black,
                          ),
                          SizedBox(height: 15,),
                          richText(
                            text1: "E-Mail ID: : ",
                            text2: provider.currentUser!.email.toString(),
                            text1Size: 22,
                            text2Size: 20,
                            color1: Colors.black,
                            color2: Colors.black,
                          ),
                          SizedBox(height: 15,),
                          richText(
                            text1: "Account Created At : ",
                            text2: provider.currentUser!.createAt.toString().substring(0,10).split("-").reversed.join("-"),
                            text1Size: 22,
                            text2Size: 20,
                            color1: Colors.black,
                            color2: Colors.black,
                          ), richText(
                            text1: "At Time : ",
                            text2: provider.currentUser!.createAt.toString().substring(11,19),
                            text1Size: 22,
                            text2Size: 20,
                            color1: Colors.black,
                            color2: Colors.black,
                          ),
                        ],
                      ),
                  ),
                ),
              ),
          );
        },
      ),
    );
  }
}

class ConformPass extends StatelessWidget {
   ConformPass({super.key});
  TextEditingController ConformController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            textpadding.TextPadding(padding: 10, text: "Conform Password", isBold: true, isLines: false,color: Colors.green,fontSize: 35),
            customWidget.textField(controller: ConformController, istrue: false,label: "Enter Password",icon: Icons.password_outlined),
            customWidget.elevatedButton(callback: (){
              final userPass = Provider.of<CurrentUserProvider>(context,listen: false).currentUser!.password;

              if(ConformController.text.toString().isEmpty){
                 ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Fill requirment")));
              }else{
                    if(ConformController == userPass){
                      alert.AlertBox(context: context, title: "CONFORM", Decre: "Your Password is Up to Date", btnText:"ok");
                    }else{
                      alert.AlertBox(context: context, title: "Error", Decre: "Somthing went wrong you password dosen't match ", btnText:"ok");
                    }
              }
            }, text: "CONFORM",color: Colors.lightBlue)
          ],
        ),
      ),
    );
  }
}


import 'package:ergata/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:ergata/constants/colors.dart';
import 'package:ergata/models/patient_model.dart';
import 'package:ergata/screens/signIn/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePatient extends StatelessWidget {
  const ProfilePatient({super.key, required this.patient});

  final MyPatient patient;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        color: Colors.white54,
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  maxRadius: 50,
                  backgroundColor: ColorsManager.secondaryColor,
                  child: Image.asset(
                    "assets/images/profile.png",
                    height: 60,
                    width: 60,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "You",
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
                )
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Diagnosed with: ${patient.diagnosedWith}",
                  style: const TextStyle(fontSize: 15),
                )
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
                child: ListView(
              children: [
                Card(
                  elevation: 1,
                  shadowColor: ColorsManager.primaryColor,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  child: const ListTile(
                    leading: Icon(
                      Icons.privacy_tip_sharp,
                      color: Colors.black54,
                    ),
                    title: Text(
                      'Privacy',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: Colors.black54,
                    ),
                  ),
                ),
                Card(
                  elevation: 1,
                  shadowColor: ColorsManager.primaryColor,
                  color: Colors.white,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  child: const ListTile(
                    leading: Icon(Icons.help_outline, color: Colors.black54),
                    title: Text(
                      'Help & Support',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: Colors.black54,
                    ),
                  ),
                ),
                Card(
                  elevation: 1,
                  shadowColor: ColorsManager.primaryColor,
                  color: Colors.white,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  child: const ListTile(
                    leading: Icon(
                      Icons.privacy_tip_sharp,
                      color: Colors.black54,
                    ),
                    title: Text(
                      'Settings',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios_outlined),
                  ),
                ),
                Card(
                  elevation: 1,
                  shadowColor: ColorsManager.primaryColor,
                  color: Colors.white,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  child: const ListTile(
                    leading: Icon(
                      Icons.add_reaction_sharp,
                      color: Colors.black54,
                    ),
                    title: Text(
                      'Invite a Friend',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: Colors.black54,
                    ),
                  ),
                ),
                BlocConsumer<AuthenticationBloc, AuthenticationState>(
                    listener: (context, state) {
                  if (state is UnAuthenticated) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()));
                  }
                }, builder: (context, state) {
                  return GestureDetector(
                    onTap: () {
                      BlocProvider.of<AuthenticationBloc>(context)
                          .add(SignOut());
                    },
                    child: Card(
                      elevation: 1,
                      shadowColor: ColorsManager.primaryColor,
                      color: Colors.white,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 5),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      child: const ListTile(
                        leading: Icon(
                          Icons.logout,
                          color: Colors.black54,
                        ),
                        title: Text(
                          'Logout',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios_outlined),
                      ),
                    ),
                  );
                })
              ],
            ))
          ],
        ),
      ),
    ));
  }
}

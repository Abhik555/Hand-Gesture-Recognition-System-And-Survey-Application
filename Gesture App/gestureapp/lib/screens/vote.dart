import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestureapp/widgets/VoteListItem.dart';

class VotePage extends ConsumerStatefulWidget {
  const VotePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _VotePageState();
}

class _VotePageState extends ConsumerState<VotePage> {
  late final userCredential;
  bool isAuth = false;

  final item = [
    const CircleAvatar(
      backgroundColor: Colors.lightBlue,
      radius: 25,
      child: Icon(
        Icons.how_to_vote_rounded,
        color: Colors.white,
      ),
    ),
    const CircleAvatar(
      backgroundColor: Colors.blue,
      radius: 25,
      child: Icon(
        Icons.how_to_vote_rounded,
        color: Colors.white,
      ),
    ),
    const CircleAvatar(
      backgroundColor: Colors.indigo,
      radius: 25,
      child: Icon(
        Icons.how_to_vote_rounded,
        color: Colors.white,
      ),
    ),
    const CircleAvatar(
      backgroundColor: Colors.purple,
      radius: 25,
      child: Icon(
        Icons.how_to_vote_rounded,
        color: Colors.white,
      ),
    ),
  ];

  void doAuth() async {
    try {
      userCredential = await FirebaseAuth.instance.signInAnonymously();
      setState(() {
        isAuth = true;
      }); // Annymous sign in
    } on FirebaseAuthException catch (e) {
      setState(() {
        isAuth = false;
      });
      switch (e.code) {
        case "operation-not-allowed":
          print("Anonymous auth hasn't been enabled for this project.");
          break;
        default:
          print("Unknown error has occured.");
      }
    }
  }

  @override
  void initState() {
    super.initState();
    doAuth();
  }

  void addVote(int model) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print("User not authenticated");
      return;
    }

    String model_name = "";

    switch (model) {
      case 0:
        model_name = "Simple CNN";
        break;
      case 1:
        model_name = "Complex CNN";
        break;
      case 2:
        model_name = "ResNET Model";
        break;
      case 3:
        model_name = "Trainable Machine Model";
        break;
      default:
        model_name = "Fallback";
        break;
    }

    final voteRef =
        FirebaseFirestore.instance.collection('votes').doc(model_name);

    await FirebaseFirestore.instance.runTransaction((transaction) async {
      final snapshot = await transaction.get(voteRef);

      if (!snapshot.exists) {
        transaction.set(voteRef, {'count': 1});
      } else {
        final newCount = snapshot.get('count') + 1;
        transaction.update(voteRef, {'count': newCount});
      }
    }).then((_) {
      print("Vote added successfully");
    }).catchError((error) {
      print("Failed to add vote: $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!isAuth) {
      return const Expanded(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text("Initializing Session..."),
          ],
        ),
      ));
    } else {
      return Expanded(
          child: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            InfoCard(
              title: "Simple CNN",
              onMoreTap: () {},
              onVoteTap: () {
                addVote(0);
              },
              body: "Simple CNN Model click more to learn more",
              subInfoTitle: "I prefer",
              subInfoText: "Simple CNN",
              main: Colors.lightBlue,
              mainAccent: Colors.lightBlueAccent,
              subIcon: item[0],
            ),
            const SizedBox(height: 20),
            InfoCard(
              title: "Complex CNN",
              onMoreTap: () {},
              onVoteTap: () {
                addVote(1);
              },
              body: "Complex CNN Model click more to learn more",
              subInfoTitle: "I prefer",
              subInfoText: "Complex CNN",
              main: Colors.blue,
              mainAccent: Colors.blueAccent,
              subIcon: item[1],
            ),
            const SizedBox(height: 20),
            InfoCard(
              title: "ResNET Model",
              onMoreTap: () {},
              onVoteTap: () {
                addVote(2);
              },
              body: "ResNET Model click more to learn more",
              subInfoTitle: "I prefer",
              subInfoText: "ResNET Model",
              main: Colors.indigo,
              mainAccent: Colors.indigoAccent,
              subIcon: item[2],
            ),
            const SizedBox(height: 20),
            InfoCard(
              title: "TrainableMachine",
              onMoreTap: () {},
              onVoteTap: () {
                addVote(3);
              },
              body: "Model from Trainable Machine click more to learn more",
              subInfoTitle: "I prefer",
              subInfoText: "Trainable Machine",
              main: Colors.purple,
              mainAccent: Colors.purpleAccent,
              subIcon: item[3],
            ),
          ],
        ),
      ));
    }
  }
}

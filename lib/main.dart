import 'package:ecom/app/pages/auth/sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'app/pages/auth/auth_widget.dart';
import 'app/pages/portal/admin_page.dart';
import 'app/pages/portal/client_home.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp(ProviderScope(
    child: MyApp()));
}

final counterProvider = StateNotifierProvider((ref) {
  return Counter();
});

class Counter extends StateNotifier<int> {
  Counter() : super(0);

  void increment() => state++;
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(counterProvider); 
    
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ), 
      home: AuthWidget(
        signedInBuilder: (context) => const UserHome(),
        nonSignedInBuilder: (_) => const SignInPage(),
        adminSignedInBuilder: (context) => const AdminHome(),
        ),
      );
  }
}

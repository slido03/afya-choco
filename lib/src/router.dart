// import 'package:firebase_ui_auth/firebase_ui_auth.dart';
// import 'package:go_router/go_router.dart';
// import 'package:flutter/material.dart';

// final router = GoRouter(
//   routes: [
//     GoRoute(
//       path: '/',
//       builder: (context, state) => const HomePage(),
//       routes: [
//         GoRoute(
//           path: 'sign-in',
//           builder: (context, state) {
//             return SignInScreen(
//               actions: [
//                 ForgotPasswordAction(((context, email) {
//                   final uri = Uri(
//                     path: '/sign-in/forgot-password',
//                     queryParameters: <String, String?>{
//                       'email': email,
//                     },
//                   );
//                   context.push(uri.toString());
//                 })),
//                 AuthStateChangeAction(((context, state) {
//                   if (state is SignedIn || state is UserCreated) {
//                     var user = (state is SignedIn)
//                         ? state.user
//                         : (state as UserCreated).credential.user;
//                     if (user == null) {
//                       return;
//                     }
//                     if (state is UserCreated) {
//                       user.updateDisplayName(user.email!.split('@')[0]);
//                     }
//                     if (!user.emailVerified) {
//                       user.sendEmailVerification();
//                       const snackBar = SnackBar(
//                           content: Text(
//                               'Please check your email to verify your email address'));
//                       ScaffoldMessenger.of(context).showSnackBar(snackBar);
//                     }
//                     context.pushReplacement('/');
//                   }
//                 })),
//               ],
//             );
//           },
//           routes: [
//             GoRoute(
//               path: 'forgot-password',
//               builder: (context, state) {
//                 final arguments = state.queryParams;
//                 return ForgotPasswordScreen(
//                   email: arguments['email'],
//                   headerMaxExtent: 200,
//                 );
//               },
//             ),
//           ],
//         ),
//         GoRoute(
//           path: 'profile',
//           builder: (context, state) {
//             return ProfileScreen(
//               providers: const [],
//               actions: [
//                 SignedOutAction((context) {
//                   context.pushReplacement('/');
//                 }),
//               ],
//             );
//           },
//         ),
//       ],
//     ),
//   ],
// );

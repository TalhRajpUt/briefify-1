import 'package:auto_orientation/auto_orientation.dart';
import 'package:briefify/models/category_model.dart';
import 'package:briefify/models/comment_model.dart';
import 'package:briefify/models/post_model.dart';
import 'package:briefify/models/user_model.dart';
import 'package:briefify/providers/home_posts_provider.dart';
import 'package:briefify/providers/post_observer_provider.dart';
import 'package:briefify/providers/user_provider.dart';
import 'package:briefify/screens/categories_screen.dart';
import 'package:briefify/screens/comments_screen.dart';
import 'package:briefify/screens/create_post_screen.dart';
import 'package:briefify/screens/edit_post_screen.dart';
import 'package:briefify/screens/followers_screen.dart';
import 'package:briefify/screens/following_screen.dart';
import 'package:briefify/screens/forgot_password_screen.dart';
import 'package:briefify/screens/home_screen.dart';
import 'package:briefify/screens/login_screen.dart';
import 'package:briefify/screens/my_profile_screen.dart';
import 'package:briefify/screens/otp_screen.dart';
import 'package:briefify/screens/posts_by_category_screen.dart';
import 'package:briefify/screens/profile_verification_screen.dart';
import 'package:briefify/screens/register_screen.dart';
import 'package:briefify/screens/replies_screen.dart';
import 'package:briefify/screens/report_user.dart';
import 'package:briefify/screens/show_user_img.dart';
import 'package:briefify/screens/show_user_screen.dart';
import 'package:briefify/screens/splash_screen.dart';
import 'package:briefify/screens/term_and_condition.dart';
import 'package:briefify/screens/update_profile_screen.dart';
import 'package:briefify/screens/webview_screen.dart';
import 'package:briefify/screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data/routes.dart';
import 'models/edit_post_argument.dart';
import 'models/route_argument.dart';
import 'screens/play_youtube_screen.dart';

// Errors in C:\src\flutter\.pub-cache\hosted\pub.dartlang.org\flutter_quill-3.9.9\lib\src\widgets\raw_editor.dart
// // ihavecommented TextEditingActionTarget,
// // ihavecommented super.copySelection(cause);
// // ihavecommented super.cutSelection(cause);
// ihavecommented super.pasteText(cause);
// ihavecommented super.selectAll(cause);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    AutoOrientation.portraitUpMode();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomePostsProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => PostObserverProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SplashScreen(),
        onGenerateRoute: (RouteSettings settings) {
          /// Welcome Route
          if (settings.name == welcomeRoute) {
            return MaterialPageRoute(
                builder: (context) => const WelcomeScreen());
          }

          /// Login Route
          if (settings.name == loginRoute) {
            return MaterialPageRoute(builder: (context) => const LoginScreen());
          }
          // Cover Photo Display Route
          if (settings.name == ImgeScreen) {
            return MaterialPageRoute(builder: (context) => const ImgScreen());
          }
          // Profile Picture Display Route

          if (settings.name == ProfileeImgScreen) {
            return MaterialPageRoute(
                builder: (context) => const ProfileImgScreen());
          }

          // Other User Cover Picture Display Route
          if (settings.name == OtherUserCoverImg) {
            final results = settings.arguments as Map;
            var modelSendToshowimg = results['user'];
            return MaterialPageRoute(
                builder: (context) => ShowOtherUserCoverPhoto(
                      user: modelSendToshowimg,
                    ));
          }
          // Other User Profile Picture Display Route
          if (settings.name == OtherUserProfileImg) {
            final results = settings.arguments as Map;
            var user = results['user'];
            return MaterialPageRoute(
                builder: (context) => OtherUserProfilePhoto(
                      user: user,
                    ));
          }

          /// Register Route
          if (settings.name == registerRoute) {
            return MaterialPageRoute(
                builder: (context) => const RegisterScreen());
          }

          /// Term & Condition Route
          if (settings.name == termandconditionRoute) {
            return MaterialPageRoute(
                builder: (context) => const TermAndConditionScreen());
          }

          /// Forgot Password Route
          if (settings.name == forgotPasswordRoute) {
            return MaterialPageRoute(
                builder: (context) => const ForgotPasswordScreen());
          }

          /// Update Profile Route
          if (settings.name == updateProfileRoute) {
            return MaterialPageRoute(
                builder: (context) => const UpdateProfileScreen());
          }

          /// Home Route
          if (settings.name == homeRoute) {
            return MaterialPageRoute(builder: (context) => const HomeScreen());
          }

          /// Create Post Route
          if (settings.name == createPostRoute) {
            return MaterialPageRoute(
                builder: (context) => const CreatePostScreen());
          }

          /// Edit Post Route
          if (settings.name == editPostRoute) {
            final results = settings.arguments as EditPostArgument;
            int userId = results.userId ?? 0;
            int postId = results.postId ?? 0;
            String heading = results.heading ?? " ";
            String summary = results.summary ?? " ";
            String videolink = results.videolink ?? " ";
            String ariclelink = results.ariclelink ?? " ";
            // String category = results.category ?? "";
            return MaterialPageRoute(
                builder: (context) => EditPostScreen(
                      userId: userId,
                      postId: postId,
                      heading: heading,
                      summary: summary,
                      videolink: videolink,
                      ariclelink: ariclelink,
                      // category: category,
                    ));
          }

          /// My Profile Route
          if (settings.name == myProfileRoute) {
            return MaterialPageRoute(
                builder: (context) => const MyProfileScreen());
          }

          /// Categories Route
          if (settings.name == categoriesRoute) {
            return MaterialPageRoute(
                builder: (context) => const CategoriesScreen());
          }

          /// Profile Verification Route
          if (settings.name == profileVerificationRoute) {
            return MaterialPageRoute(
                builder: (context) => const ProfileVerificationScreen());
          }

          /// Comments Route
          if (settings.name == commentsRoute) {
            final results = settings.arguments as Map;
            PostModel post = results['post'];
            return MaterialPageRoute(
                builder: (context) => CommentsScreen(post: post));
          }

          /// OTP Route
          if (settings.name == otpRoute) {
            final results = settings.arguments as Map;
            final String name = results['name'];
            final String email = results['email'];
            final String phoneNumber = results['phoneNumber'];
            final String password = results['password'];
            final String credibility = results['credibility'];
            final String date = results['date'];
            return MaterialPageRoute(
                builder: (context) => OTPScreen(
                    name: name,
                    email: email,
                    phoneNumber: phoneNumber,
                    password: password,
                    credibility: credibility,
                    date: date));
          }

          /// Replies Route
          if (settings.name == repliesRoute) {
            final results = settings.arguments as Map;
            CommentModel comment = results['comment'];
            return MaterialPageRoute(
                builder: (context) => RepliesScreen(comment: comment));
          }

          /// Webview Route
          if (settings.name == webviewRoute) {
            final results = settings.arguments as Map;
            String url = results['url'];
            return MaterialPageRoute(
                builder: (context) => WebviewScreen(url: url));
          }

          /// Show User Route
          if (settings.name == showUserRoute) {
            final results = settings.arguments as Map;
            UserModel user = results['user'];
            return MaterialPageRoute(
                builder: (context) => ShowUserScreen(
                      user: user,
                    ));
          }

          /// Followers Route
          if (settings.name == followersRoute) {
            final results = settings.arguments as Map;
            UserModel user = results['user'];
            return MaterialPageRoute(
                builder: (context) => FollowersScreen(user: user));
          }

          /// Following Route
          if (settings.name == followingRoute) {
            final results = settings.arguments as Map;
            UserModel user = results['user'];
            return MaterialPageRoute(
                builder: (context) => FollowingScreen(user: user));
          }

          /// Posts By Categories Route
          if (settings.name == postsByCategoryRoute) {
            final results = settings.arguments as Map;
            CategoryModel category = results['category'];
            return MaterialPageRoute(
                builder: (context) => PostsByCategoryScreen(
                      category: category,
                    ));
          }

          /// Following Route
          if (settings.name == ytScreen) {
            final results = settings.arguments as RouteArgument;
            String url = results.url ?? " ";
            return MaterialPageRoute(
                builder: (context) => PlayYTVideo(url: url));
          }

          // Report User Route
          if (settings.name == reportUserRoute) {
            final results = settings.arguments as Map;
            final int postid = results['postid'];
            final int postuserid = results['userid'];
            return MaterialPageRoute(
                builder: (context) => ReportUser(
                      postid: postid,
                      userid: postuserid,
                    ));
          }

          /// No route found
          assert(false, 'Need to implement ${settings.name}');
          return null;
        },
      ),
    );
  }
}

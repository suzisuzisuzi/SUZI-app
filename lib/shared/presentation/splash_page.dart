import 'package:flutter/material.dart';
import 'package:suzi_app/authentication/presentation/pages/sign_in_page.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "assets/illustrations/illustration2.png",
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 32,
              ),
              Image.asset("assets/illustrations/illustration1.png"),
              const SizedBox(
                height: 24,
              ),
              Text(
                "suzi",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Text(
                  "Your observations matter.",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontFamily: 'Technor',
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
              const Spacer(
                flex: 3,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 48,
                child: FilledButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const SignInPage();
                        },
                      ),
                    );
                  },
                  child: const Text("Get Started"),
                ),
              ),
              const Spacer(
                flex: 4,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class OnboardingContent {
  final String topLogo;
  final String description;
  final String image;

  OnboardingContent({
    required this.topLogo,
    required this.description,
    required this.image,
  });
}

List<OnboardingContent> contents = [
  OnboardingContent(
    topLogo: "assets/logo/logo.png",
    description:
        "Id ea esse incididunt pariatur Lorem.Ea excepteur ex elit est qui dolor minim officia incididunt.",
    image: "assets/images/onboarding4.png",
  ),
  OnboardingContent(
    topLogo: "assets/logo/logo.png",
    description:
        "Id ea esse incididunt pariatur Lorem.Ea excepteur ex elit est qui dolor minim officia incididunt.",
    image: "assets/images/onboarding1.png",
  ),
  OnboardingContent(
    topLogo: "assets/logo/logo.png",
    description:
        "Id ea esse incididunt pariatur Lorem.Ea excepteur ex elit est qui dolor minim officia incididunt.",
    image: "assets/images/onboarding6.png",
  ),
];

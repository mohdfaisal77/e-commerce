class OnBoardingContent{
  String image;
  String title;
  String description;
  OnBoardingContent({
    required this.title,required this.image,required this.description
});
}
List<OnBoardingContent> contents=[
  OnBoardingContent(title: 'Select from Our\n  Best Menu', image: "assets/images/pizza.png", description: "Pick your food from our menu more than 35 times")
,OnBoardingContent(title: "Easy and Online Payment", image: "assets/images/burger.png", description: "You can pay cash on delivery and Card payment is available")
,OnBoardingContent(title: "Quick delivery at Your DoorStep", image: "assets/images/burger.png", description: "deliver your food at your\n  doorsteps")
];
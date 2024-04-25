import 'package:equatable/equatable.dart';

class Vent extends Equatable {
  final String content;
  final String date;

  const Vent({
    required this.content,
    required this.date,
  });

  @override
  List<Object> get props => [content, date];

  static const sampleVents = [
    Vent(
        content:
            "Hide my Identity\nI need to vent\nHello 22F. I am lonely af. I live in a country where there are no habeshas, and they don’t speak english so I can’t make friends. Its a beautiful country but I spend my days on my bed. I want to go out but feel insecure because I am one of few black people. I am wasting my golden years on my bed. Help. ",
        date: "2 days ago"),
    Vent(
        content:
            "Hide my Identity\nI need to vent\nY'all know what's harder than studying? Living with the fear of failure. Being afraid of losing the validation. Being afraid because the only thing you can do is learning and there is nothing you are actually good at. Being afraid because all the people around Have something they are good at and they like it, while u hate studying which is the only thing u can do. Beginning to Hate learning because u put so much pressure on yourself to succeed on something that isn't even your dream that u can't take it anymore.",
        date: "1 day ago"),
    Vent(
        content:
            "Hide my Identity\nI need to vent\nI find myself torn between the contentment I feel with my current life and the mounting expectations placed upon me by my family. Despite my academic achievements and contributions at home, these qualities have raised their expectations to new heights. While my father is satisfied with my accomplishments and doesn't ask for more, others see me as a solution to their financial struggles. \nThough I am not naturally ambitious for material wealth or financial gain, I might consider striving harder to fulfill their expectations. I have been pushing myself for all my 25 years, so why not a little longer? My motivation comes from wanting to bring pride and joy to my father, who has always supported me. Meeting the expectations set by our relatives becomes a way of honoring his faith in me. \nHowever, deep down, I know that someday I will return to the simplicity I desire. I will live a life aligned with my true goals, free from the weight of relentless expectations. Until then, driven by love and respect for my father, I will continue pushing myself. He has always believed in me, and being a source of pride for him is my lifelong endeavor.",
        date: "2 days ago"),
  ];
}

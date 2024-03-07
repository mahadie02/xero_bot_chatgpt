import 'package:dart_openai/dart_openai.dart';

chatResponse(promt, type) async {
  OpenAI.apiKey = 'Your_API_KEY';

  if (type == 'Chat') {
    try {
      OpenAIChatCompletionModel chat = await OpenAI.instance.chat.create(
        model: "gpt-3.5-turbo",
        messages: [
          OpenAIChatCompletionChoiceMessageModel(
            content: '$promt',
            role: OpenAIChatMessageRole.user,
          ),
        ],
      );
      return chat.choices[0].message.content;
    } on RequestFailedException catch (e) {
      // print(e.message);
      return e.message;
    }
  }
  try {
    if (type == 'Image') {
      final image = await OpenAI.instance.image.create(
        prompt: promt,
        n: 1,
        size: OpenAIImageSize.size256,
      );
      return image.data.first.url;
    }
  } on RequestFailedException {
    return '-1';
  }
}




/*List<String> chatModels = [
  'gpt-3.5-turbo-0301',
  'text-davinci-003',
];

Future<void> mainCode() async {
  // Set the OpenAI API key from the .env file.
  OpenAI.apiKey = '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';

  // Start using!
  final completion = await OpenAI.instance.completion.create(
    model: "text-davinci-003",
    prompt: "Dart is",
  );

  // Printing the output to the console
  print(completion.choices[0].text);

  // Generate an image from a prompt.
  final image = await OpenAI.instance.image.create(
    prompt: "dog",
    n: 1,
  );

  // Printing the output to the console.
  print(image.data.first.url);

  // create a moderation
  final moderation = await OpenAI.instance.moderation.create(
    input: "I will cut your head off",
  );

  // Printing moderation
  print(moderation.results.first.categories.violence);
}*/

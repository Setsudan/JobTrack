sealed class BackgroundImagePickOutcome {
  const BackgroundImagePickOutcome();
}

final class BackgroundImagePickCancelled extends BackgroundImagePickOutcome {
  const BackgroundImagePickCancelled();
}

final class BackgroundImagePickInvalid extends BackgroundImagePickOutcome {
  const BackgroundImagePickInvalid();
}

final class BackgroundImagePickResolved extends BackgroundImagePickOutcome {
  const BackgroundImagePickResolved(this.sourcePath);

  final String sourcePath;
}

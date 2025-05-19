namespace Highrise.UI
{
    public static class StringExtensions
    {
        private static char[] LineBreakCharacters = new[] { '\n', '\r', '\0' };

        public static string Sanitized(this string input)
        {
            return input?.Replace("\\", "");
        }

        public static bool ContainsLineBreak(this string text)
        {
            var endsWithLineBreak = false;
            foreach (var lineBreakCharacter in LineBreakCharacters)
                endsWithLineBreak |= text.Contains(lineBreakCharacter.ToString());

            return endsWithLineBreak;
        }

        public static string RemoveLineBreaks(this string input)
        {
            var output = input;
            foreach (var character in LineBreakCharacters)
                output = output.Replace(character.ToString(), "");

            return output;
        }
    }
}
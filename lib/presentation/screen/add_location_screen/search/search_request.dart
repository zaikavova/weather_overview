abstract class SearchRequest {}

class TextSearchRequest implements SearchRequest {
  TextSearchRequest(this.text);

  final String text;
}

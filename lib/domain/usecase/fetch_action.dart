abstract class FetchDataAction<Data, Param> {
  Future<List<Data>> call(Param param);
}

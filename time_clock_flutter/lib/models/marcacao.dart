class Marcacao {
  final int id;
  final String data;
  final String hora;

  Marcacao(this.id, this.data, this.hora);

  @override
  String toString() {
    return 'Marcacao{id: $id, data: $data, hora: $hora}';
  }
}
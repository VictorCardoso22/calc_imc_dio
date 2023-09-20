class ImcModel {
  int _id = 0;
  double _altura = 0.0;
  double _peso = 0.0;
  double _imc = 0.0;

  ImcModel(this._id, this._altura, this._peso, this._imc);

  int get id => _id;
  set id(int id) {
    _id = id;
  }

  double get altura => _altura;
  set altura(double altura) {
    _altura = altura;
  }

  double get peso => _peso;
  set peso(double peso) {
    _peso = peso;
  }

  double get imc => _imc;
  set imc(double imc) {
    _imc = imc;
  }
}

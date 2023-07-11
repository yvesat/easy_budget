enum AlertType {
  error("Error"),
  warning("Warning"),
  sucess("Sucess"),
  ;

  const AlertType(this.text);
  final String text;
}

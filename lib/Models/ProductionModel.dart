class Production_Model {
  late String date;
  late String value;

  Production_Model(
      this.date,
      this.value,
      );

  Map<String, dynamic> toJson() => {
    'date': date,
    'value': value,
  };

  Production_Model.fromSnapshot(Map<String, dynamic> snapshot)
      : date = snapshot['date'],
        value = snapshot['value'];
}

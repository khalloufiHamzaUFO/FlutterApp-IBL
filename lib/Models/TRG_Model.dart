class TRGModel{
  late String date;
  late String value;

  TRGModel(
      this.date,
      this.value,
      );

  Map<String, dynamic> toJson() => {
    'date': date,
    'value': value,
  };

  TRGModel.fromSnapshot(Map<String, dynamic>? snapshot)
      : date = snapshot!['date'],
        value = snapshot['value'];
}
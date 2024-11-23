class DataModel{

  late String id;
  late String date;
  late String trs;

  DataModel(
      this.date,
      this.trs,
      this.id
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'date': date,
    'trs': trs,
  };

  DataModel.fromSnapshot(Map<String, dynamic>? snapshot)
      : id = snapshot!['id'],
        date = snapshot['date'],
        trs = snapshot['trs'];

}
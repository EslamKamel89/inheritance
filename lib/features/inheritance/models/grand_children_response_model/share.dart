class Share {
	double? men;
	double? women;

	Share({this.men, this.women});

	factory Share.fromJson(Map<String, dynamic> json) => Share(
				men: (json['men'] as num?)?.toDouble(),
				women: (json['women'] as num?)?.toDouble(),
			);

	Map<String, dynamic> toJson() => {
				'men': men,
				'women': women,
			};
}

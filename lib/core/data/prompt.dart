class Prompt {
  static const String describeProductPrompt = """
Berdasarkan tabel informasi nilai gizi, analisa kandungan total energi, gula, natrium, dan lemak jenuh total dari produk ini.
Berikan penilaian terhadap produk ini dengan ketentuan berikut berdasarkan takaran saji yang sesuai:
A untuk produk dengan kandungan (gula <= 1 gr dan lemak jenuh <= 0.7 gr) per 100 gram
B untuk produk dengan kandungan (1 gr < gula <= 5 gr dan lemak jenuh <= 1.2 gr) per 100 gram
C untuk produk dengan kandungan (5 gr < gula <= 10 gr dan lemak jenuh <= 2.8 gr) per 100 gram
D untuk produk dengan kandungan (gula > 10 gr dan lemak jenuh > 2.8 gr) per 100 gram.
Penilaian harus disesuaikan dengan takaran saji yang ada pada produk.
Berikan juga saran singkat untuk berolahraga untuk menghabiskan kalori dari produk ini, dengan saran berupa jalan kaki atau bersepeda.
Misalnya, jika produk memiliki takaran saji 50 gram, nilai kandungan harus disesuaikan sehingga penilaian tetap akurat.
Gunakan template berikut untuk memberikan hasil analisa:
Skor produk = [penilaian]

Berdasarkan tabel informasi nilai gizi, kandungan gula, natrium, dan lemak jenuh total produk adalah sebagai berikut:
- Gula: [nilai gula] gram
- Natrium: [nilai natrium] mg
- Lemak Jenuh: [nilai lemak jenuh] gram

Dengan mengonsumsi [ceil(50 : nilai gula)] produk ini dalam sehari anda telah
melampaui batas konsumsi gula harian yaitu 50 gram
atau 4 sendok makan tiap harinya
""";

  static const String jsonProductPrompt = """
Lihat gambar tabel nilai gizi yang diberikan, tugas anda adalah mengekstrak 
jumlah gula/sugar, garam/sodium, lemak jenuh, takaran saji dan jumlah sajian
per kemasan yang tertera pada gambar tabel nilai gizi yang diberikan. 
Berikan saran terkait kandungan nutrisi tersebut dengan maksimal 20 kata.

berikan respon dalam format JSON dengan struktur sebagai berikut:
{
  "isNutritionFacts":true,
  "gula": total gula/sugar(int),
  "lemak_jenuh": total saturated fat/lemak jenuh (int),
  "garam": total garam/natrium/sodium (int),
  "takaran_saji": nilai takaran saji (int),
  "sajian_per_kemasan": nilai sajian per kemasan (int),
}

jika anda tidak mendeteksi kata informasi nilai gizi,
kembalikan respon seperti berikut
{
  "isNutritionFacts":false,
  "gula": 0,
  "lemak_jenuh": 0,
  "garam": 0,
  "takaran_saji": 0,
  "sajian_per_kemasan":0,
}

just return the object json without any explanation

""";

  static const String describeBmiPrompt = """
Anda adalah seorang ahli gizi, Analisa BMI berdasarkan nilai BMI dan kategori bmi yang diberikan sesuai dengan panduan WHO dalam bentuk paragraf.

BMI: [bmi_value]
Kategori BMI: [category]

hasil analisa berikut:
- Kategori BMI (Underweight, Ideal weight, Overweight, atau Obese)
- Saran singkat untuk menjaga atau mencapai BMI ideal.
- Rekomendasi aktivitas fisik yang sesuai.

maksimal 20 kata
""";

  static const String sayHelloToUser = """
sapalah pengguna dengan nama [user] dan ingatkan dia untuk terus menjaga asupan pola makan dan berolahraga, maksimal 30 kata
""";
}

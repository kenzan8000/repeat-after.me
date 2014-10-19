module JapaneseUtil
  KANA_TABLE = {
    'ん' => 'n', 'ン' => 'n', 'わ' => 'wa', 'ワ' => 'wa', 'ら' => 'ra', 'ラ' => 'ra', 'や' => 'ya', 'ヤ' => 'ya', 'ま' => 'ma', 'マ' => 'ma', 'は' => 'ha', 'ハ' => 'ha', 'な' => 'na', 'ナ' => 'na', 'た' => 'ta', 'タ' => 'ta', 'さ' => 'sa', 'サ' => 'sa', 'か' => 'ka', 'カ' => 'ka', 'あ' => 'a', 'ア' => 'a', 'り' => 'ri', 'リ' => 'ri', 'み' => 'mi', 'ミ' => 'mi', 'ひ' => 'hi', 'ヒ' => 'hi', 'に' => 'ni', 'ニ' => 'ni', 'ち' => 'chi', 'チ' => 'chi', 'し' => 'shi', 'シ' => 'shi', 'き' => 'ki', 'キ' => 'ki', 'い' => 'i', 'イ' => 'i', 'る' => 'ru', 'ル' => 'ru', 'ゆ' => 'yu', 'ユ' => 'yu', 'む' => 'mu', 'ム' => 'mu', 'ふ' => 'fu', 'フ' => 'fu', 'ぬ' => 'nu', 'ヌ' => 'nu', 'つ' => 'tsu', 'ツ' => 'tsu', 'す' => 'su', 'ス' => 'su', 'く' => 'ku', 'ク' => 'ku', 'う' => 'u', 'ウ' => 'u', 'れ' => 're', 'レ' => 're', 'め' => 'me', 'メ' => 'me', 'へ' => 'he', 'ヘ' => 'he', 'ね' => 'ne', 'ネ' => 'ne', 'て' => 'te', 'テ' => 'te', 'せ' => 'se', 'セ' => 'se', 'け' => 'ke', 'ケ' => 'ke', 'え' => 'e', 'エ' => 'e', 'を' => 'wo', 'ヲ' => 'wo', 'ろ' => 'ro', 'ロ' => 'ro', 'よ' => 'yo', 'ヨ' => 'yo', 'も' => 'mo', 'モ' => 'mo', 'ほ' => 'ho', 'ホ' => 'ho', 'の' => 'no', 'ノ' => 'no', 'と' => 'to', 'ト' => 'to', 'そ' => 'so', 'ソ' => 'so', 'こ' => 'ko', 'コ' => 'ko', 'お' => 'o', 'オ' => 'o', 'ァ' => 'a', 'ィ' => 'i', 'ゥ' => 'u', 'ェ' => 'e', 'ォ' => 'o', 'ゃ' => 'ya', 'ャ' => 'ya', 'ゅ' => 'yu', 'ュ' => 'yu', 'ょ' => 'yo', 'ョ' => 'yo', 'っ' => 'tsu', 'ッ' => 'tsu'
  }

  def self.jp_to_segments(text)
    segments = MeCab::Tagger.new.parse(text).split(',')
    segments
  end

  def self.segments_to_kanas(segments)
    kanas ''
    kanas
  end

  def self.kana_to_romajis(kanas)
    romajis = Array.new

    kanas.each do |kana_segment|
      romaji = ''

      chars = kana_segment.chars
      chars.each do |kana|
        romaji += KANA_TABLE.has_key?(kana) ? KANA_TABLE[kana] : kana
      end

      romajis.push(romaji)
    end

    romajis
  end
end

module AmazonAssociates
  ADS = [
    :ad_00
#    :ad_00,
#    :ad_01,
#    :ad_02,
#    :ad_03
  ]

  def self.randomAd
    ADS[rand(ADS.length)]
  end
end


#module AmericanIPA
#  ARPABET_IPA_TABLE = {
##      'AA' => 'aa',  'AA0' => 'aa',  'AA1' => '\'aa', 'AA2' => 'aa',  'HH' => 'hh',  'Z'  =>  'z',
##      'AE' => 'ae',  'AE0' => 'ae',  'AE1' => '\'ae', 'AE2' => 'ae',  'B'  =>  'b',  'ZH' => 'zh',
##      'AH' => 'ah',  'AH0' => 'ah',  'AH1' => '\'ah', 'AH2' => 'ah',  'D'  =>  'd',  'M'  =>  'm',
##      'AO' => 'ao',  'AO0' => 'ao',  'AO1' => '\'ao', 'AO2' => 'ao',  'G'  =>  'g',  'N'  =>  'n',
##      'EH' => 'eh',  'EH0' => 'eh',  'EH1' => '\'eh', 'EH2' => 'eh',  'K'  =>  'k',  'NG' => 'ng',
##      'IH' => 'ih',  'IH0' => 'ih',  'IH1' => '\'ih', 'IH2' => 'ih',  'P'  =>  'p',  'L'  =>  'l',
##      'IY' => 'iy',  'IY0' => 'iy',  'IY1' => '\'iy', 'IY2' => 'iy',  'T'  =>  't',  'R'  =>  'r',
##      'UH' => 'uh',  'UH0' => 'uh',  'UH1' => '\'uh', 'UH2' => 'uh',  'CH' => 'ch',  'Y'  =>  'y',
##      'UW' => 'uw',  'UW0' => 'uw',  'UW1' => '\'uw', 'UW2' => 'uw',  'JH' => 'jh',  'W'  =>  'w',
##      'AW' => 'aw',  'AW0' => 'aw',  'AW1' => '\'aw', 'AW2' => 'aw',  'DH' => 'dh',
##      'AY' => 'ay',  'AY0' => 'ay',  'AY1' => '\'ay', 'AY2' => 'ay',  'F'  =>  'f',
##      'EY' => 'ey',  'EY0' => 'ey',  'EY1' => '\'ey', 'EY2' => 'ey',  'SH' => 'sh',
##      'OW' => 'ow',  'OW0' => 'ow',  'OW1' => '\'ow', 'OW2' => 'ow',  'S'  =>  's',
##      'OY' => 'oy',  'OY0' => 'oy',  'OY1' => '\'oy', 'OY2' => 'oy',  'TH' => 'th',
##      'ER' => 'er',  'ER0' => 'er',  'ER1' => '\'er', 'ER2' => 'er',  'V'  =>  'v'
#      'AA' => 'ɑ',  'AA0' => 'ɑ',  'AA1' => '\'ɑ', 'AA2' => 'ɑ',  'HH' =>  'h',  'Z'  =>  'z',
#      'AE' => 'æ',  'AE0' => 'æ',  'AE1' => '\'æ', 'AE2' => 'æ',  'B'  =>  'b',  'ZH' =>  'ʒ',
#      'AH' =>  'ʌ',  'AH0' =>  'ʌ',  'AH1' =>  '\'ʌ', 'AH2' =>  'ʌ',  'D'  =>  'd',  'M'  =>  'm',
#      'AO' =>  'ɔ',  'AO0' =>  'ɔ',  'AO1' =>  '\'ɔ', 'AO2' =>  'ɔ',  'G'  => 'ɡ',  'N'  =>  'n',
#      'EH' =>  'ɛ',  'EH0' =>  'ɛ',  'EH1' =>  '\'ɛ', 'EH2' =>  'ɛ',  'K'  =>  'k',  'NG' => 'ŋ',
#      'IH' =>  'ɪ',  'IH0' =>  'ɪ',  'IH1' =>  '\'ɪ', 'IH2' =>  'ɪ',  'P'  =>  'p',  'L'  =>  'ɫ',
#      'IY' =>  'i',  'IY0' =>  'i',  'IY1' =>  '\'i', 'IY2' =>  'i',  'T'  =>  't',  'R'  =>  'r',
#      'UH' =>  'ʊ',  'UH0' =>  'ʊ',  'UH1' =>  '\'ʊ', 'UH2' =>  'ʊ',  'CH' => 'tʃ',  'Y'  =>  'j',
#      'UW' =>  'u',  'UW0' =>  'u',  'UW1' =>  '\'u', 'UW2' =>  'u',  'JH' => 'dʒ',  'W'  =>  'w',
#      'AW' => 'aʊ',  'AW0' => 'aʊ',  'AW1' => '\'aʊ', 'AW2' => 'aʊ',  'DH' => 'ð',
#      'AY' => 'aɪ',  'AY0' => 'aɪ',  'AY1' => '\'aɪ', 'AY2' => 'aɪ',  'F'  =>  'f',
#      'EY' => 'eɪ',  'EY0' => 'eɪ',  'EY1' => '\'eɪ', 'EY2' => 'eɪ',  'SH' =>  'ʃ',
#      'OW' => 'oʊ',  'OW0' => 'oʊ',  'OW1' => '\'oʊ', 'OW2' => 'oʊ',  'S'  =>  's',
#      'OY' => 'ɔɪ',  'OY0' => 'ɔɪ',  'OY1' => '\'ɔɪ', 'OY2' => 'ɔɪ',  'TH' => 'θ',
#      'ER' =>  'ɝ',  'ER0' =>  'ɝ',  'ER1' =>  '\'ɝ', 'ER2' =>  'ɝ',  'V'  =>  'v'
#  }
#
#  def self.text_to_ipa(text)
#    # text to ARPABET
#    arpabet_words = Array.new
#    words = text.split(' ')
#    words.each do |word|
#      arpabet_words.push(Pronounce.how_do_i_pronounce(word.delete(',').delete('.').delete('?')))
#    end
#
#    # ARPABET to American IPA
#    ipas = Array.new
#    arpabet_words.each do |arpabets|
#      ipa = ''
#      if arpabets then
#        arpabets.each do |arpabet|
#          ipa += ARPABET_IPA_TABLE[arpabet]
#        end
#      end
#      ipas.push(ipa)
#    end
#
#    ipas
#  end
#end


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


module MP4Converter

  def self.mp4_path(params)
    file = params[:file]
    path = nil
    if file
      mp3_path = './public/post/mp4.mp3'
      mp4_path = './public/post/output.mp4'
      jpg_path = './public/post/mp4.jpg'

      File.open(mp3_path, 'wb') do |file|
        p params[:file][:tempfile]
        file.write params[:file][:tempfile].read

        system("ffmpeg -i #{jpg_path} -i '#{mp3_path}' -ar 44100 -vcodec mpeg4 -loglevel 'quiet' -y #{mp4_path}")
        path = mp4_path
      end
    end

    path
  end
end


module VideoUploader
  def self.post(token, mp4_path, title, message)
    graph = Koala::Facebook::API.new(token)
    graph.put_video(mp4_path, {:title => title, :message => message})
  end
end

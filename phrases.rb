#!/usr/bin/env ruby

# This script bakes phrases as .aiff files to be used by our robot.
# It could have used I18n, but I've chosen to have as few
# dependencies as possible at the moment

require 'yaml'

VOICES = { en: 'Zarvox', pl: 'Zosia' }

def filename(phrase, language)
  filename = phrase['filename']
  filename ||= phrase['en'].downcase.gsub(/\s+/, '_').gsub(/[^A-Z_]/i, '')
  File.join('assets', 'phrases', language.to_s, filename + '.aiff')
end

def say(phrase, language)
  text = phrase[language.to_s].to_s
  # fall back to english voice if no equivalent
  text = phrase['en'] if text == ''

  voice = VOICES[language]

  system("say -v #{voice} -o #{filename(phrase, language)} \"#{text}\"")
end

phrases = YAML.load_file('phrases.yml')

phrases.each do |phrase|
  say(phrase, :pl)
  say(phrase, :en)
end

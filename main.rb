if (Gem.win_platform?)
  Encoding.default_external = Encoding.find(Encoding.locale_charmap)
  Encoding.default_internal = __ENCODING__

  [STDIN, STDOUT].each do |io|
    io.set_encoding(Encoding.default_external, Encoding.default_internal)
  end
end

require 'rexml/document'
require_relative './lib/engine.rb'

current_path = File.dirname(__FILE__)
path_questions = current_path + '/data/questions.xml'

abort 'Файл не найден' unless File.exist?(path_questions)

test = Engine.new
test.to_data(path_questions)

test.lets_go
class Engine
  attr_reader :questions, :answers, :time, :right_answers

  def initialize
    @questions = []
    @answers = []
    @right_answers = []
    @time = 0
    @count = 0
  end

  def to_data(path_file)
    file = File.new(path_file, "r:UTF-8")
    doc = REXML::Document.new(file)
    file.close

    doc.elements.each('questions/question') do |quest|
      question = quest.elements['text'].text
      @time = quest.attributes["secundes"].to_i

      quest.elements.each('variants/variant') do |variant|
        answer = variant.text
        @answers << answer
        @right_answers << answer if variant.attributes['right']
      end
      @questions << question
    end
  end

  def lets_go
      n = 0
      answers = @answers.each_slice(4).to_a

    for item in @questions

      puts item
      puts "Варианты ответов: #{answers[n].join(', ')}\n"
      puts "У вас #{@time} секунд на раздумья."

      time_begin = Time.now
      finale = time_begin + @time

      answer = STDIN.gets.chomp
      time_end = Time.now

      if time_end >= finale
        puts "Сожалею, вы не уложились в отпущенное время. Правильный ответ #{@right_answers[n]}\n\n"

      elsif answer == @right_answers[n]
        @count += 1
        puts "Верный ответ.\n\n"
      else
          puts "Нет. Правильный ответ #{@right_answers[n]}\n\n"
      end

      n += 1
    end

      if @count == 1
        suffix = " "
      elsif(@count > 1 && @count < 5)
        suffix = "а"
      else
        suffix = "ов"
      end

    puts "Вы ответили правильно на #{@count} вопрос#{suffix} из #{@questions.size}\n"
  end
end



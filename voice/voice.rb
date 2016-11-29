#!/usr/bin/env ruby

def say(text)
  `say -v Zosia #{text}`
end

def ask(word)
  typed = []
  errors = 0
  word.each_char do |char|
    say "Naciśnij: #{char}"
    pressed = STDIN.getc

    return false if pressed == "\e" # ESC
    exit if pressed == "\u0003"  # Ctrl-C

    if (pressed == char)
      typed << pressed
      print typed.join + "\r"
      if typed.count > 3
        say typed.join
      end
    else
      if errors < 2
        # say nothing
      elsif errors < 4
        say "Nacisnęłaś: #{pressed}."
      elsif errors < 7
        say "To nie tak... Nacisnęłaś: #{pressed}."
      else
        say "Nacisnęłaś: #{pressed}."
        say "Czy coś jest nie tak? Możesz nacisnąć eskEjp, jeżeli to słowo jest za trudne."
      end

      errors += 1
      redo
    end
  end

  return true
end

def main_loop(list)
  list.each do |word|
    say "Napiszmy: #{word}"
    puts "\n#{word}\r"

    if ask(word)
      say "Świetnie!"
    else
      say "Nic nie szkodzi!"
    end
    puts "\n"
  end
end

# MAIN PROGRAM
say("Cześć! Pobawmy się w pisanie!")

list = File.readlines('lista.txt').map(&:strip).shuffle

begin
  system("stty raw -echo")
  main_loop(list)
ensure
  system("stty -raw echo")
end

puts "\n\nDziękuję za zabawę!\n"
say "Dziękuję za zabawę!"
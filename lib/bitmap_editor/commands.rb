# frozen_string_literal: true

module BitmapEditor
  module Commands
    COMMANDS = {
      'I' => :init,
      'C' => :clear,
      'L' => :pixel,
      'V' => :vertial_line,
      'H' => :horizontal_line,
      'S' => :show
    }.freeze

    COMMAND_ARGS_RESTRICTIONS = {
      init: 2,
      clear: 0,
      pixel: 3,
      vertial_line: 4,
      horizontal_line: 4,
      show: 0
    }.freeze

    DEFAULT_COLOR = 'O'

    def show
      bitmap.each do |line|
        puts line.join('')
      end
    end

    private

    def init(args)
      rows = args[0].to_i
      cols = args[1].to_i
      @bitmap = Array.new(cols) { Array.new(rows, DEFAULT_COLOR) }
    end

    def clear
      @bitmap = Array.new(bitmap.count) { Array.new(bitmap.first&.count, DEFAULT_COLOR) }
    end

    def pixel(args)
      bitmap_x = args[0].to_i
      bitmap_y = args[1].to_i
      color    = args[2]

      bitmap[bitmap_y - 1][bitmap_x - 1] = color
    end

    def vertial_line(args)
      x = args[0].to_i - 1
      y1 = args[1].to_i - 1
      y2 = args[2].to_i - 1
      color = args[3]

      (y1..y2).each do |y|
        bitmap[y][x] = color
      end
    end

    def horizontal_line(args)
      x1 = args[0].to_i - 1
      x2 = args[1].to_i - 1
      y = args[2].to_i - 1
      color = args[3]

      (x1..x2).each do |x|
        bitmap[y][x] = color
      end
    end

    def command_valid?(command, args)
      command && args.count == COMMAND_ARGS_RESTRICTIONS[command]
    end
  end
end

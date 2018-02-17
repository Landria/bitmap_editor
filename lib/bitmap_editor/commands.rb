# frozen_string_literal: true

module BitmapEditor
  module Commands
    COMMANDS= {
      'I' => :draw_bitmap,
      'C' => :clear,
      'L' => :add_pixel,
      'V' => :add_vertial_line,
      'H' => :add_horizontal_line,
      'S' => :show_bitmap
    }

    COMMAND_ARGS_RESTRICTIONS = {
      draw_bitmap: 2,
      clear: 0,
      add_pixel: 3,
      add_vertial_line: 4 ,
      add_horizontal_line: 4,
      show_bitmap: 0
    }

    DEFAULT_COLOR = 'O'

    def show_bitmap
      bitmap.each do |line|
        puts line.join('')
      end
    end

    private

    def draw_bitmap(args)
      rows, cols = args[0].to_i, args[1].to_i
      @bitmap = Array.new(cols){ Array.new(rows, DEFAULT_COLOR) }
    end

    def clear
      @bitmap = Array.new(bitmap.count){ Array.new(bitmap.first&.count, DEFAULT_COLOR) }
    end

    def add_pixel(args)
      bitmap_x, bitmap_y, color = args[0].to_i, args[1].to_i, args[2]
      bitmap[bitmap_y - 1][bitmap_x - 1] = color
    end
  
    def add_vertial_line(args)
      x = args[0].to_i - 1
      y1 = args[1].to_i - 1
      y2 = args[2].to_i - 1
      color = args[3]
  
      (y1..y2).each do |y|
        bitmap[y][x] = color
      end
    end

    def add_horizontal_line(args)
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
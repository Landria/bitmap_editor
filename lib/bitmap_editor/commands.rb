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
    MAX_DIM = 250

    def show
      bitmap.each do |line|
        puts line.join('')
      end
    end

    private

    def init(args)
      @cols = args[0].to_i
      @rows = args[1].to_i
      raise(ArgumentError, 'Check file instructions for bitmap size') if rows > MAX_DIM || cols > MAX_DIM

      @bitmap = Array.new(rows) { Array.new(cols, DEFAULT_COLOR) }
    end

    def clear
      @bitmap = Array.new(bitmap.count) { Array.new(bitmap.first&.count, DEFAULT_COLOR) }
    end

    def pixel(args)
      color = args.pop
      coords = prepare_coordinates(args)

      bitmap[coords[1]][coords[0]] = color
    end

    def vertial_line(args)
      draw_line(args, :vertical)
    end

    def horizontal_line(args)
      draw_line(args, :horizontal)
    end

    def draw_line(args, type)
      color = args.pop
      coord1 = args.send(type == :horizontal ? :pop : :shift).to_i - 1
      coords = prepare_coordinates(args).sort

      (coords[0]..coords[1]).each do |coord2|
        case type
        when :horizontal
          bitmap[coord1][coord2] = color if bitmap[coord1] && bitmap[coord1][coord2]
        when :vertical
          bitmap[coord2][coord1] = color if bitmap[coord2] && bitmap[coord2][coord1]
        end
      end
    end

    def prepare_coordinates(args)
      args.map(&:to_i).map { |coord| coord - 1 }
    end

    def command_valid?(command, args)
      case command
      when :init, :show, :clear
        args.count == COMMAND_ARGS_RESTRICTIONS[command]
      else
        args.count == COMMAND_ARGS_RESTRICTIONS[command] && \
          args.last == args.last.upcase && \
          coordinates_valid?(command, args)
      end
    end

    def coordinates_valid?(command, args)
      condition = []

      args.map(&:to_i).take(COMMAND_ARGS_RESTRICTIONS[command] - 1).each do |coord|
        condition << "(1..MAX_DIM).cover?(#{coord})"
      end
      
      eval(condition.join(' && '))
    end
  end
end

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
      @cols = args[0].to_i
      @rows = args[1].to_i
      raise(ArgumentError, 'Check file instructions for bitmap size') if rows > 250 || cols > 250

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
          bitmap[coord1][coord2] = color
        when :vertical
          bitmap[coord2][coord1] = color
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
          coordinates_valid?(command, args.map(&:to_i))
      end
    end

    def coordinates_valid?(command, args)
      case command
      when :pixel
        (1..cols).cover?(args[0]) && (1..rows).cover?(args[1])
      when :vertial_line
        (1..cols).cover?(args[0]) && (1..rows).cover?(args[1]) && (1..rows).cover?(args[2])
      when :horizontal_line
        (1..cols).cover?(args[0]) && (1..cols).cover?(args[1]) && (1..rows).cover?(args[2])
      else
        true
      end
    end
  end
end

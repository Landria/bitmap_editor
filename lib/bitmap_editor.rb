class BitmapEditor
  attr_accessor :bitmap

  COMMANDS= {
    'I' => :draw_bitmap,
    'C' => :clear,
    'L' => :add_pixel,
    'V' => :vertial_line,
    'H' => :horizontal_line,
    'S' => :show_bitmap
  }

  COMMANDS_ARGS_RESTRICTIONS = {
    draw_bitmap: 2,
    clear: 0,
    add_pixel: 3,
    vertial_line: 4 ,
    horizontal_line: 4,
    show_bitmap: 0
  }

  DEFAULT_COLOR = 'O'

  def run(file)
    calculate
  end

  def calculate(file)
    return "please provide correct file" if file.nil? || !File.exists?(file)

    File.open(file).each do |line|
      perform(line.chomp)
      # case line
      # when 'S'
      #     puts "There is no image"
      # else
      #     puts 'unrecognised command :('
      # end
    end
    
    self
  end

  private

  def perform(line)
    args = line.split(/\s/)
    command = COMMANDS[args.shift]
    raise ArgumentError unless command_valid?(command, args)

    send(command, args)
  end

  def command_valid?(command, args)
    args.count == COMMANDS_ARGS_RESTRICTIONS[command]
  end

  # Commands

  def draw_bitmap(args)
    rows, cols = args[0].to_i, args[1].to_i
    @bitmap = Array.new(rows, Array.new(cols, DEFAULT_COLOR))
  end

  def clear;end

  def add_pixel(args);end

  def vertial_line(args);end

  def horizontal_line(args);end

  def show_bitmap(args);end
end

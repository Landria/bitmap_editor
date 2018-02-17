# frozen_string_literal: true

require_relative 'bitmap_editor/commands'

module BitmapEditor
  class Processor
    
    attr_accessor :bitmap

    include BitmapEditor::Commands

    def run(file)
      calculate(file)
    rescue ArgumentError
      puts "Please provide correct file"
    rescue Exception => e
      puts "Unexpected exception: #{e.message}"
    end

    def calculate(file)
      raise ArgumentError if file.nil? || !File.exists?(file)
  
      File.open(file).each do |line|
        perform(line.chomp)
      end
  
      self
    end
  
    private

    def perform(line)
      args = line.split(/\s/)
      command = COMMANDS[args.shift]
      raise ArgumentError unless command_valid?(command, args)
      args.empty? ? send(command) : send(command, args)
    end
  end
end

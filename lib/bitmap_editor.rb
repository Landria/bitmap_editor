# frozen_string_literal: true

require_relative 'bitmap_editor/commands'

module BitmapEditor
  class Processor

    attr_accessor :bitmap

    include BitmapEditor::Commands

    def run(file)
      check_file(file)

      File.open(file).each do |line|
        perform(line.chomp)
      end

      self
    rescue ArgumentError => e
      puts "ArgumentError: #{e.message}"
    rescue NoMethodError => e
      puts "Unexpected exception: #{e.message}"
    ensure
      self
    end

    private

    def check_file(file)
      raise(ArgumentError, 'Please provide correct file') if file.nil? || !File.exist?(file)
    end

    def perform(line)
      args = line.split(/\s/)
      command = COMMANDS[args.shift]
      return unless command
      raise(ArgumentError, 'Check file instructions') unless command_valid?(command, args)
      args.empty? ? send(command) : send(command, args)
    end
  end
end

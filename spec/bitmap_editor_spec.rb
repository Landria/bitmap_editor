# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BitmapEditor do
  let(:expected_output) do
    [
      ['O', 'O', 'O', 'O', 'O'],
      ['O', 'O', 'Z', 'Z', 'Z'],
      ['A' ,'W', 'O', 'O', 'O'],
      ['O', 'W', 'O', 'O', 'O'],
      ['O', 'W', 'O', 'O', 'O'],
      ['O', 'W', 'O', 'O', 'O']
    ].freeze
  end

  let(:expected_initial_output) do
    [
      ['O', 'O', 'O', 'O', 'O'],
      ['O', 'O', 'O', 'O', 'O'],
      ['O' ,'O', 'O', 'O', 'O'],
      ['O', 'O', 'O', 'O', 'O'],
      ['O', 'O', 'O', 'O', 'O'],
      ['O', 'O', 'O', 'O', 'O']
    ].freeze
  end

  it { expect(BitmapEditor::Processor.new.run('examples/show.txt').bitmap).to eq expected_output }

  # handles duplicate init instrauction (last init instruction apllyed)
  it { expect(BitmapEditor::Processor.new.run('examples/two_inits.txt').bitmap).to eq expected_output }

  # Handle wrong coords range for lines
  it { expect(BitmapEditor::Processor.new.run('examples/flip_coords.txt').bitmap).to eq expected_output }

  it { expect(BitmapEditor::Processor.new.run('examples/clear_bitmap.txt').bitmap.flatten.uniq).to eq ['O'] }

  it { expect(BitmapEditor::Processor.new.run('examples/no_changes.txt').bitmap).to eq expected_initial_output}

  it { expect { BitmapEditor::Processor.new.run('examples/wrong_command_args_type.txt') }.to_not raise_error }

  it 'shows correct bitmap when overrun coords for horizontal line passed' do
    expect(BitmapEditor::Processor.new.run('examples/overrun_h.txt').bitmap).to eq expected_output
  end

  it 'shows correct bitmap when overrun coords for vertical line passed' do
    expect(BitmapEditor::Processor.new.run('examples/overrun_v.txt').bitmap).to eq expected_output
  end

  context 'empty bitmap' do
    it 'when only S command passed' do
      expect(BitmapEditor::Processor.new.run('examples/only_s_command.txt').bitmap).to eq([[]])
    end

    it 'when no init instructions given' do
      expect(BitmapEditor::Processor.new.run('examples/without_init.txt').bitmap).to eq([[]])
    end

    it 'when empty file passed' do
      expect(BitmapEditor::Processor.new.run('examples/empty.txt').bitmap).to eq([[]])
    end
  end

  context 'argument error' do
    it 'when file is not exists' do
      expect(STDOUT).to receive(:puts).with('ArgumentError: Please provide correct file')
      BitmapEditor::Processor.new.run('examples/unknownshow.txt')
    end

    it 'when command has wrong args count' do
      expect(STDOUT).to receive(:puts).with('ArgumentError: Check file instructions')
      BitmapEditor::Processor.new.run('examples/wrong_command_args.txt')
    end

    it 'when command is non upercase character' do
      expect(STDOUT).to receive(:puts).with('ArgumentError: Check file instructions')
      BitmapEditor::Processor.new.run('examples/non_uppercase_command.txt')
    end

    it 'when unknown command passed' do
      expect(STDOUT).to receive(:puts).with('ArgumentError: Check file instructions')
      BitmapEditor::Processor.new.run('examples/unknown_command.txt')
    end

    it 'when colour is non upercase char' do
      expect(STDOUT).to receive(:puts).with('ArgumentError: Check file instructions')
      BitmapEditor::Processor.new.run('examples/non_uppercase_colour.txt')
    end

    it 'when unknown command passed' do
      expect(STDOUT).to receive(:puts).with('ArgumentError: Check file instructions for bitmap size')
      BitmapEditor::Processor.new.run('examples/larger_bitmap.txt')
    end

    it 'when wrong pixel coords passed' do
      expect(STDOUT).to receive(:puts).with('ArgumentError: Check file instructions')
      BitmapEditor::Processor.new.run('examples/wrong_coords.txt')
    end

    it 'when incorrect file passed' do
      expect(STDOUT).to receive(:puts).with('ArgumentError: Check file instructions')
      BitmapEditor::Processor.new.run('examples/text.txt')
    end
  end
end

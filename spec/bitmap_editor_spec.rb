# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BitmapEditor do
  let(:expected_output) {[
    ['O','O','O','O','O'],
    ['O','O','Z','Z','Z'],
    ['A','W','O','O','O'],
    ['O','W','O','O','O'],
    ['O','W','O','O','O'],
    ['O','W','O','O','O']
  ]}

  it { expect(BitmapEditor::Processor.new.run('examples/show.txt').bitmap).to eq expected_output }

  it 'shows argument error message when file is not exists' do
    expect(STDOUT).to receive(:puts).with('ArgumentError: Please provide correct file')
    BitmapEditor::Processor.new.run('examples/unknownshow.txt')
  end

  it { expect(BitmapEditor::Processor.new.run('examples/clear_bitmap.txt').bitmap.flatten.uniq).to eq ['O'] }

  it  'ignores unknown instructions' do
    expect(BitmapEditor::Processor.new.run('examples/unknown_command.txt').bitmap).to eq expected_output
  end

  it 'shows argument error when command has wrong args count' do
    expect(STDOUT).to receive(:puts).with('ArgumentError: Check file instructions')
    BitmapEditor::Processor.new.run('examples/wrong_command_args.txt')
  end

  it { expect { BitmapEditor::Processor.new.run('examples/wrong_command_args_type.txt') }.to_not raise_error }
end

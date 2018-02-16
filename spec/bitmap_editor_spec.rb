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

  it { expect(BitmapEditor.new.calculate('examples/show.txt').bitmap).to eq expected_output }
  it { expect(BitmapEditor.new.calculate('examples/unknownshow.txt')).to eq 'please provide correct file' }
end

require 'crossed_wires/wire'

RSpec.describe CrossedWires::Wire do
  describe '::from_input' do
    subject(:wire) { described_class.from_input(input) }

    context 'with single path' do
      let(:input) { 'U62' }

      it 'creates a correct wire' do
        expect(wire).to match_array [
          have_attributes(begining: have_attributes(x: 0, y: 0),
                          end: have_attributes(x: 0, y: 62))
        ]
      end
    end
  end
end

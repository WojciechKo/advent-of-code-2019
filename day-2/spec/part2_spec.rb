require 'part1'

RSpec.describe 'Part 2' do
  let(:input)  { File.read('input-part1') }

  it 'finds correct noun and verb' do
    nouns = (0..99)
    verbs = (0..99)

    nouns.to_a.product(verbs.to_a).each do |noun, verb|
      memory = Part1::Memory.from_string(input)
      memory[1] = noun
      memory[2] = verb

      result = Part1::Executor.new(memory).execute.first
      if result == 19690720
        puts "noun=#{noun}"
        puts "verb=#{verb}"

        puts "answer=#{100*noun+verb}"
      end
    end
  end
end

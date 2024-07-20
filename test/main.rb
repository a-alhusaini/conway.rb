require "minitest/autorun"
require "minitest/spec"
require "stringio"
require_relative "../main"

describe Conway do
  describe ".play_game_of_life" do
    after do
      $stdin = STDIN
      $stdout = STDOUT
    end

    it "iterates when user presses n" do
      input = StringIO.new("n\nq\n")
      output = StringIO.new

      $stdin = input
      $stdout = output

      Conway.play_game_of_life(3)

      assert_includes output.string, "iteration: 0"
      assert_includes output.string, "iteration: 1"
      assert_includes output.string, "goodbye"
    end

    it 'creates grid with specified width' do
      $stdin = StringIO.new("q\n")
      $stdout = StringIO.new

      Conway.play_game_of_life(2)

      assert_includes $stdout.string, '["", ""]'
    end

    it "let user set cell state" do
      $stdin = StringIO.new("0,0\nq\n")
      $stdout = StringIO.new

      grid = Conway.play_game_of_life(2)
      assert_equal Conway.get_cell_state(grid, 0, 0), "x"
    end

    it 'kills crowded cell' do
      $stdin = StringIO.new("0,0\n0,1\n1,1\n1,0\n1,2\nn\nq\n")
      $stdout = StringIO.new

      grid = Conway.play_game_of_life(4)
      assert_equal Conway.get_cell_state(grid, 1, 1), ""
    end
  end
end

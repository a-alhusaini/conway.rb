module Conway
  class << self
    def grid_print(grid)
      grid.count.times do |x|
        p grid[x]
      end
    end

    def get_cell_state(grid, x, y)
      grid[y][x]
    end

    def create_grid(grid_size)
      grid = []

      grid_size.times do |x|
        grid << []
        grid_size.times do
          grid[x] << ""
        end
      end

      grid
    end

    def flip_cell(grid, x, y)
      if grid[y][x] == ""
        grid[y][x] = "x"
      else
        grid[y][x] = ""
      end
    end

    def kill_cell(grid, x, y)
      grid[y][x] = ""
    end

    def birth_cell(grid, x, y)
      grid[y][x] = "x"
    end

    def count_living_neighbors(grid, x, y)
      living_neighbors = 0
      size = grid.size - 1

      if y > 0 and grid[y-1][x] == "x" then living_neighbors += 1 end
      if x > 0 and grid[y][x-1] == "x" then living_neighbors += 1 end
      if x > 0 and y > 0 and grid[y-1][x-1] == "x" then living_neighbors += 1 end
      if y < size and grid[y+1][x] == "x" then living_neighbors += 1 end
      if x < size and grid[y][x+1] == "x" then living_neighbors += 1 end
      if x < size and y < size and grid[y+1][x+1] == "x" then living_neighbors += 1 end
      if y > 0 and x < size and grid[y-1][x+1] == "x" then living_neighbors += 1 end
      if y < size and x > 0 and grid[y+1][x-1] == "x" then living_neighbors += 1 end

      living_neighbors
    end

    def print_help
      puts """
    Controls
      n => next iteration
      \"number, number\" => flip the state of the cell at x, y
      q => quit
    """
    end

    def play_game_of_life(grid_size)

      grid = create_grid(grid_size)

      iteration = 0


      print_help

      loop do
        puts "iteration: #{iteration}"
        grid_print(grid)

        print "> "
        input = gets.chomp

        if input == "q"
          puts "goodbye"
          break grid
        end

        if input == "n"
          iteration += 1

          new_grid = create_grid(grid_size)

          new_grid.size.times do |y|
            new_grid.size.times do |x|
              living_neighbors = count_living_neighbors(grid, x, y)

              if grid[y][x] == "x" and living_neighbors < 2
                kill_cell(new_grid, x, y)
              elsif grid[y][x] == "" and living_neighbors == 3
                birth_cell(new_grid, x, y)
              elsif grid[y][x] == "x" and living_neighbors > 3
                kill_cell(new_grid, x, y)
              elsif grid[y][x] == "x" and living_neighbors == 2 or living_neighbors == 3
                birth_cell(new_grid, x, y)
              end
            end
          end

          grid_print(new_grid)
          grid = new_grid
        end

        if input.split(",").count == 2
          nums = input.split(",").map(&:to_i)

          flip_cell(grid, nums[0], nums[1])
        end
      end
    end
  end
end

if $0 == __FILE__
  puts "what is the grid size you want?"
  size = gets.to_i
  Conway.play_game_of_life(size)
end

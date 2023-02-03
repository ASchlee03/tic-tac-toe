class Board
  attr_reader :grid

  def initialize
    @grid = Array.new(3) { Array.new(3, '-') }
  end

  def display
    puts '-' * 13
    grid.each { |row| puts "| #{row.join(' | ')} |" }
    puts '-' * 13
  end

  def update(move, mark)
    row, col = move
    grid[row][col] = mark
  end

  def winner
    win_lines = grid + grid.transpose + diagonals

    win_lines.each do |line|
      return 'X' if line == ['X', 'X', 'X']
      return 'O' if line == ['O', 'O', 'O']
    end
    nil
  end

  def diagonals
    [
      [grid[0][0], grid[1][1], grid[2][2]],
      [grid[0][2], grid[1][1], grid[2][0]]
    ]
  end

  def free_positions?
    grid.flatten.include?('-')
  end
end

class Game
  attr_reader :board, :players, :current_player

  def initialize
    @board = Board.new
    @players = %w[X O]
    @current_player = players.first
  end

  def display_board
    board.display
  end

  def play
    loop do
      display_board
      puts "Player #{current_player}'s turn. Choose a position with two number inputs (0 to 2): "
      row, col = gets.chomp.split.map(&:to_i)
      board.update([row, col], current_player)
      break if board.winner || !board.free_positions?

      @current_player = players.reverse.find { |p| p != current_player }
    end
    display_board
    winner = board.winner
    puts winner ? "Player #{winner} won!" : 'It is a draw!'
  end
end

game = Game.new
game.play
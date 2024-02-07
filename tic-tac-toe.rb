class Game
    @@winner = nil

    def initialize(player_one_name, player_two_name)
        @player_one_name = player_one_name
        @player_two_name = player_two_name
        @board = Array.new(3) { Array.new(3, '_') }
    end

    def display_board
        @board.each { |row| puts row.join(' | ') }
    end

    def play_game
        turn = 0
        until @@winner || turn == 9
        display_board
        current_player = turn.even? ? @player_one_name : @player_two_name
        puts "#{current_player}'s turn (#{turn.even? ? 'O' : 'X'}): Enter coordinates (row column):"
        input = gets.chomp.split.map(&:to_i)
        if valid_move?(input)
            make_move(input, turn)
            check_winner
            turn += 1
        else
            puts "Invalid move! Try again."
        end
        end
        display_board
        announce_winner
    end

    def valid_move?(input)
        input.length == 2 && input.all? { |coord| coord.between?(0, 2) } && @board[input[0]][input[1]] == '_'
    end

    def make_move(input, turn)
        symbol = turn.even? ? 'O' : 'X'
        @board[input[0]][input[1]] = symbol
    end

    def check_winner
        check_rows || check_columns || check_diagonals
    end

    def check_rows
        @board.each do |row|
        if row.uniq.length == 1 && row[0] != '_'
            @@winner = row[0]
            return true
        end
        end
        false
    end

    def check_columns
        @board.transpose.each do |column|
        if column.uniq.length == 1 && column[0] != '_'
            @@winner = column[0]
            return true
        end
        end
        false
    end

    def check_diagonals
        if (@board[0][0] == @board[1][1] && @board[1][1] == @board[2][2]) ||
        (@board[0][2] == @board[1][1] && @board[1][1] == @board[2][0])
        @@winner = @board[1][1] unless @board[1][1] == '_'
        return true
        end
        false
    end

    def announce_winner
        if @@winner
        puts "#{@@winner} wins the game!"
        else
        puts "It's a tie!"
        end
    end
end
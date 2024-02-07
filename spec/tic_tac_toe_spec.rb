require_relative '../tic-tac-toe'

describe Game do
    let(:game) { Game.new('Player One', 'Player Two') }

    describe '#valid_move?' do
        it 'returns true for valid moves' do
        expect(game.valid_move?([0, 0])).to eq(true)
        expect(game.valid_move?([1, 2])).to eq(true)
        end

        it 'returns false for invalid moves' do
        expect(game.valid_move?([-1, 0])).to eq(false)
        expect(game.valid_move?([3, 3])).to eq(false)
        expect(game.valid_move?([0, 0])).to eq(false)  # already taken
        end
    end

    describe '#make_move' do
        it 'updates the board with the player\'s symbol' do
        game.make_move([0, 0], 0)
        expect(game.instance_variable_get(:@board)).to eq([['X', '_', '_'], ['_', '_', '_'], ['_', '_', '_']])
        end
    end

    describe '#check_winner' do
        it 'detects a winning row' do
        game.instance_variable_set(:@@winner, nil)
        game.instance_variable_set(:@board, [['X', 'X', 'X'], ['_', '_', '_'], ['_', '_', '_']])
        game.check_winner
        expect(Game.class_variable_get(:@@winner)).to eq('X')
        end

        it 'detects a winning column' do
        game.instance_variable_set(:@@winner, nil)
        game.instance_variable_set(:@board, [['X', '_', '_'], ['X', '_', '_'], ['X', '_', '_']])
        game.check_winner
        expect(Game.class_variable_get(:@@winner)).to eq('X')
        end

        it 'detects a winning diagonal' do
        game.instance_variable_set(:@@winner, nil)
        game.instance_variable_set(:@board, [['X', '_', '_'], ['_', 'X', '_'], ['_', '_', 'X']])
        game.check_winner
        expect(Game.class_variable_get(:@@winner)).to eq('X')
        end
    end
end

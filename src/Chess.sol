pragma ton-solidity >= 0.53.0;

import "Constants.sol";

contract Chess {
    uint32 static game_index;
    address static white_player;
    address static black_player;

    uint64 public white_bid;
    uint64 public black_bid;

    mapping(uint6 => Figure) public figures;

    Color current_color;
    optional(Color) public winner;

    event PlayerMove(Color color, uint16 from, uint16 to);

    constructor() public {
        current_color = Color.White;
    }

    function move(uint6 from, uint6 to) public internalMsg notFinished {
        require(msg.value >= Gas.MOVE_VALUE, ErrorCodes.MSG_VALUE_TOO_LOW_TO_MOVE);

        Color color = getSenderColor();
        require(color == current_color, ErrorCodes.NOT_YOUR_TURN);

        optional(Figure) figure_entry = figures.fetch(from);
        require(figure_entry.hasValue(), ErrorCodes.FIGURE_NOT_FOUND);

        Figure figure = figure_entry.get();
        require(figure.color == color, ErrorCodes.WRONG_COLOR);

        // TODO: check move

        optional(Figure) target_entry = figures.getReplace(to, figure);
        if (target_entry.hasValue()) {
            Figure target = target_entry.get();
            require(target.color != color, ErrorCodes.WRONG_MOVE);
        }

        tvm.rawReserve(address(this).balance - msg.value, 2);
        emit PlayerMove(color, from, to);
        msg.sender.transfer({ value: 0, bounce: false, flag: MsgFlag.ALL_NOT_RESERVED });
    }

    function getSenderColor() private inline returns (Color) {
        if (msg.sender == white_player) {
            return Color.White;
        } else if (msg.sender == black_player) {
            return Color.Black;
        } else {
            revert(ErrorCodes.WRONG_COLOR);
        }
    }

    modifier notFinished {
        require(!winner.hasValue(), ErrorCodes.GAME_ALREADY_FINISHED);
        _;
    }
}

enum Color {
    White,
    Black
}

struct Figure {
    Color color;
}

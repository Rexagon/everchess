pragma ton-solidity >= 0.53.0;

library Gas {
    uint64 constant MOVE_VALUE = 0.5 ever;
}

library ErrorCodes {
    uint16 constant GAME_ALREADY_FINISHED = 2101;

    uint16 constant MSG_VALUE_TOO_LOW_TO_MOVE = 2201;
    uint16 constant NOT_YOUR_TURN             = 2202;
    uint16 constant FIGURE_NOT_FOUND          = 2203;
    uint16 constant WRONG_COLOR               = 2204;
    uint16 constant WRONG_MOVE                = 2205;
}

library MsgFlag {
    uint8 constant SENDER_PAYS_FEES     = 1;
    uint8 constant IGNORE_ERRORS        = 2;
    uint8 constant DESTROY_IF_ZERO      = 32;
    uint8 constant REMAINING_GAS        = 64;
    uint8 constant ALL_NOT_RESERVED     = 128;
}

// SPDX-Licencse-Identifier: MIT

// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.7;

error Raffle_SendMoreToEnterRaffle();
error Raffle_RaffleNotOpen();

contract Raffle {
    enum RaffleState {
        Open,
        Calculating
    }

    RaffleState public s_raffleState;
    uint256 public immutable i_entranceFee;
    address payable[] public s_players;

    event RaffleEntered(address indexed player);

    constructor(uint256 entranceFee) {
        i_entranceFee = entranceFee;
    }

    function enterRaffle() external payable {
        if (msg.value < i_entranceFee) {
            revert Raffle_SendMoreToEnterRaffle();
        }

        // Open / calculating a winner
        if (s_raffleState != RaffleState.Open) {
            revert Raffle_RaffleNotOpen();
        }

        // You can enter the raffle
        s_players.push(payable(msg.sender));
        emit RaffleEntered(msg.sender);
    }

}
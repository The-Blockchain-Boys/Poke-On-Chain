// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Pokedex} from "./Pokedex.sol";
import {VRFv2DirectFundingConsumer} from "./VRFv2DirectFundingConsumer.sol";

contract Battles is Pokedex {
    event Response(bool success);

    function selectPokemon(
        uint256 selected
    ) external view returns (uint256 level, uint256 strength, uint256 hp) {
        require(
            selected < pokemons[msg.sender].length,
            "Selected pokemon doesn't exist"
        );
        return (
            pokemons[msg.sender][selected].level,
            pokemons[msg.sender][selected].strength,
            pokemons[msg.sender][selected].hp
        );
    }

    function getEnemyMoves() internal returns (bytes memory) {
        address _addr = 0x9b0c6189f1E7d1591107C03c544AB6a099c83c4c;
        (bool success, ) = payable(_addr).call{value: 2, gas: 100000}(
            abi.encodeWithSignature("requestRandomWords()")
        );
        emit Response(success);
        VRFv2DirectFundingConsumer randomNumber = VRFv2DirectFundingConsumer(
            0x9b0c6189f1E7d1591107C03c544AB6a099c83c4c
        );
        return randomNumber.randomWords;
    }
}

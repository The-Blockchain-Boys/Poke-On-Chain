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

    function createVRFContract() internal returns (VRFv2DirectFundingConsumer) {
        VRFv2DirectFundingConsumer myVRF = new VRFv2DirectFundingConsumer();
        return VRFv2DirectFundingConsumer(address(myVRF));
    }

    function sendLink(address _addr) internal {
        (bool success, ) = payable(_addr).call{value: msg.value, gas: 100000}(
            ""
        );
        require(success, "Link transaction erroned");
        emit Response(success);
    }

    function getEnemyMoves() internal returns (uint256) {
        VRFv2DirectFundingConsumer vrf = createVRFContract();
        sendLink(address(vrf));
        return vrf.requestRandomWords();
    }
}

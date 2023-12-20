// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Pokedex {
    enum typePokemon {
        Water,
        Grass,
        Fire,
        Eletric,
        Fly
    }

    struct Pokemon {
        address trainer;
        string name;
        uint level;
        uint strength;
        uint hp;
        typePokemon typeOf;
    }

    mapping(address => Pokemon[]) public pokemons;
    mapping(address => uint) public pokeCoins;
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "./ZombieWorld.sol";

//Note:Storage Refers to Variables Stored Permanently and Memory refers to Stored Temporarily.

contract ZombieFeeding is ZombieWorld {  
    function feedAndMultiply(uint _zombieId,uint _targetDna) public{
        require(msg.sender == zombieToOwner[_zombieId]);
    Zombie storage myZombie = zombies[_zombieId];
     _targetDna = _targetDna % dnaModulus;
     uint newDna = (myZombie.dna + _targetDna) / 2;
    _createZombie("NoName", newDna);
    }
}
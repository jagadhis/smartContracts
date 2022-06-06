// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "./ZombieWorld.sol";

//Note:Storage Refers to Variables Stored Permanently and Memory refers to Stored Temporarily.

contract ZombieFeeding is ZombieWorld {  
    function feedAndMultiply(uint _zombieId,uint _targetDna) public{
        require(msg.sender == zombieToOwner[_zombieId]);  //checking that sender is same to ID of Zombie
    Zombie storage myZombie = zombies[_zombieId];  //storing the zombieId in an array
     _targetDna = _targetDna % dnaModulus;  //checking the data is in 16 bits long
     uint newDna = (myZombie.dna + _targetDna) / 2;    //calaculating a New zombie DNA using average method
    _createZombie("NoName", newDna);  //creating a zombie with a nname form create zombie function call
    }
}
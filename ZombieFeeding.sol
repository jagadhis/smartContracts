// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "./ZombieWorld.sol";

//Note:Storage Refers to Variables Stored Permanently and Memory refers to Stored Temporarily.
//Note: Function to access in inheritance should be made public or using external or internal
//Note: Calling with other contracts declaring the functions to inteeract with and ending the declaration with semicolon to know the compiler its interface



contract KittyInterface {
    function getKitty(uint256 _id) external view returns (
    bool isGestating,
    bool isReady,
    uint256 cooldownIndex,
    uint256 nextActionAt,
    uint256 siringWithId,
    uint256 birthTime,
    uint256 matronId,
    uint256 sireId,
    uint256 generation,
    uint256 genes
  );
}

contract ZombieFeeding is ZombieWorld {  
    function feedAndMultiply(uint _zombieId,uint _targetDna) public{
        require(msg.sender == zombieToOwner[_zombieId]);  //checking that sender is same to ID of Zombie
    Zombie storage myZombie = zombies[_zombieId];  //storing the zombieId in an array
     _targetDna = _targetDna % dnaModulus;  //checking the data is in 16 bits long
     uint newDna = (myZombie.dna + _targetDna) / 2;    //calaculating a New zombie DNA using average method
    _createZombie("NoName", newDna);  //creating a zombie with a nname form create zombie function call
    }
}
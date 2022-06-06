// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "./ZombieWorld.sol";

//Note:Storage Refers to Variables Stored Permanently and Memory refers to Stored Temporarily.
//Note: Function to access in inheritance should be made public or using external or internal
//Note: Calling with other contracts declaring the functions to inteeract with and ending the declaration with semicolon to know the compiler its interface
//Note: using Interface keywork Instead if contract in Newer Version.


interface KittyInterface {
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
     
     address ckAddress = 0x06012c8cf97BEaD5deAe237070F9587f8E7A266d;
 
  KittyInterface kittyContract  = KittyInterface(ckAddress);

    function feedAndMultiply(uint _zombieId,uint _targetDna,string memory _species) public{
        require(msg.sender == zombieToOwner[_zombieId]);  //checking that sender is same to ID of Zombie
    Zombie storage myZombie = zombies[_zombieId];  //storing the zombieId in an array
     _targetDna = _targetDna % dnaModulus;  //checking the data is in 16 bits long
     uint newDna = (myZombie.dna + _targetDna) / 2;    //calculating a New zombie DNA using average method
     if (keccak256(abi.encodePacked(_species)) == keccak256(abi.encodePacked("kitty"))) {
      newDna = newDna - newDna % 100 + 99;
    }
    _createZombie("NoName", newDna);  //creating a zombie with a nname form create zombie function call
    }

     function feedOnKitty(uint _zombieId , uint _kittyId) public{
       uint kittyDna;
    (,,,,,,,,,kittyDna) = kittyContract.getKitty(_kittyId);  //calling the KittyContract and returning the data
    feedAndMultiply(_zombieId, kittyDna,"Kitty");
  }
}
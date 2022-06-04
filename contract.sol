// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract ZombieWorld{   //creating a Contract 
    uint dnaDigits = 16;   //initiating a unsigned integer 
    uint dnaModulus = 10 ** dnaDigits; //using a Math Operator - Exponential Operator

    struct Zombie {   //creating a Struct 
        string name;   //adding variables with data type
    uint dna;
    
}
  Zombie[] public zombies;  //Creating Struct array With Public 

  function createZombie(string memory _name,uint _dna) public{   //creating Funciton With Public Visibility and adding function parameters
      zombies.push(Zombie(_name,_dna)); //pushing the paramteres value in the Struct array
  }
  function _createZombie(string memory _name,uint _dna) private{  //creating Funciton with Private Visibility and adding function parameters
      zombies.push(Zombie(_name,_dna));
  }

  function _generateRandomDna(string memory _str) private view returns (uint){  //view function only viewing the data but it cannot be modified 
  keccak256(abi.encodePacked(_str));   //hashfunction keccak256 inbuilt version of SHA3
            uint rand = uint(keccak256(abi.encodePacked(_str)));   //typecasting
        return rand % dnaModulus;

  }


}
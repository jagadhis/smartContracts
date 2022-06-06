// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

//Note: In Solidity, function execution always needs to start with an external caller. A contract will just sit on the blockchain doing nothing until someone calls one of its functions. So there will always be a msg.sender.
//Note:Require Is Used TO Check Condition To True BEfore running a Function
contract ZombieWorld{   //creating a Contract 


    event NewZombie(uint zombieId,string name,uint dna); //created a Event
    uint dnaDigits = 16;   //initiating a unsigned integer 
    uint dnaModulus = 10 ** dnaDigits; //using a Math Operator - Exponential Operator

    struct Zombie {   //creating a Struct 
        string name;   //adding variables with data type
    uint dna;
    
}
  Zombie[] public zombies;  //Creating Struct array With Public 

   mapping (uint => address) public zombieToOwner; //mapping the address that owns a zombie
   mapping (address => uint) ownerZombieCount; //mapping the number of zombies an owner has

  function createZombie(string memory _name,uint _dna) public{   //creating Funciton With Public Visibility and adding function parameters
      zombies.push(Zombie(_name,_dna)); //pushing the paramteres value in the Struct array
     
  }
    function _createZombie(string memory _name, uint _dna) public {
        zombies.push(Zombie(_name, _dna));
      
          uint id = zombies.length - 1;  //creating a variable for ID
             zombieToOwner[id] = msg.sender; //mapping zombieToOwner ID TO Msg.sender
        ownerZombieCount[msg.sender]++; //increasing the count of Msg.sender when owner has created more than one zombie 
        emit NewZombie(id, _name, _dna); //emit to let know the function is called
    }
  function _generateRandomDna(string memory _str) private view returns (uint){  //view function only viewing the data but it cannot be modified 
  keccak256(abi.encodePacked(_str));   //hashfunction keccak256 inbuilt version of SHA3
            uint rand = uint(keccak256(abi.encodePacked(_str)));   //typecasting
        return rand % dnaModulus;

  }
    function _createRandomZombie(string memory _name) public {  //creating a randomzombie generator with name as parameter
        require(ownerZombieCount[msg.sender] == 0); //requiring a Condition to check that zombiecount of the owner is zero to create a zombie
        uint randDna = _generateRandomDna(_name);    //calling generateRandomDna function in randdna variable
        _createZombie(_name, randDna);   //calling createzombie function
    }


}


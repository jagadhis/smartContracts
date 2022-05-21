// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract carrental{
    address public owner;
    uint256 private counter;

    constructor(){
        counter = 0;
        owner = msg.sender;
    }

    struct carrentalinfo{
        uint256 id; 
        string carname;
        uint256 carnum;
        string drivername;
        uint256 startKm;
        uint256 endKm;
        uint256 totalHr;
        uint256 totalkm;
        uint256 amount;
        string[] datesBooked;
        address renter;
    }

       event CarsCreated (
        uint256 id,
        string carname,
        uint256 carnum,
        string drivername,
        uint256 startKm,
        uint256 endKm,
        uint256 totalHr,
        uint256 totalkm,
        uint256 amount,
        string[] datesBooked,
        address renter
    );

        event CarsBooked (
        string[] datesBooked,
        uint256 id,
         string carname,
        uint256 carnum,
        string drivername
    );
       mapping(uint256 => carrentalinfo) rentals;
    uint256[] public rentalIds;

    function addRentals(
        uint256  id,
        string memory carname,
        uint256  carnum,
        string memory drivername,
        uint256  startKm,
        uint256  endKm,
        uint256  totalHr,
        uint256  totalkm,
        uint256  amount,
        string[] memory datesBooked
    ) public {
        require(msg.sender == owner, "Only owner of smart contract can put up rentals");
        carrentalinfo storage newRental = rentals[counter];
        newRental.carname = carname;
        newRental.carnum = carnum;
        newRental.drivername = drivername;
        newRental.startKm = startKm;
        newRental.endKm = endKm;
        newRental.totalHr = totalHr;
        newRental.totalkm = totalkm;
        newRental.amount = amount;
       
        newRental.datesBooked = datesBooked;
        newRental.id = counter;
        newRental.renter = owner;
        rentalIds.push(counter);
    emit CarsCreated(
             carname,
             carnum,
             drivername,
             startKm,
             endKm,
             totalHr,
             totalkm,
             amount,
             datesBooked, 
             counter, 
             owner
             );
        counter++;
    }
    function checkBookings(uint256 id, string[] memory newBookings) private view returns (bool){
        
        for (uint i = 0; i < newBookings.length; i++) {
            for (uint j = 0; j < rentals[id].datesBooked.length; j++) {
                if (keccak256(abi.encodePacked(rentals[id].datesBooked[j])) == keccak256(abi.encodePacked(newBookings[i]))) {
                    return false;
                }
            }
        }
        return true;
    }


    function addDatesBooked(uint256 id, string[] memory newBookings) public payable {
        
        require(id < counter, "No such Rental");
        require(checkBookings(id, newBookings), "Already Booked For Requested Date");
        require(msg.value == (rentals[id].totalkm * 1 wei * newBookings.length) , "Please submit the asking price in order to complete the purchase");
    
        for (uint i = 0; i < newBookings.length; i++) {
            rentals[id].datesBooked.push(newBookings[i]);
        }

        payable(owner).transfer(msg.value);
        emit CarsBooked(newBookings, id, msg.sender, rentals[id].carnum,  rentals[id].drivername);
    
    }

    function getRental(uint256 id) public view returns (string memory, uint256, string[] memory){
        require(id < counter, "No such Rental");

        carrentalinfo storage s = rentals[id];
        return (s.carname,s.datesBooked);
    }

}
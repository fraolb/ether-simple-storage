// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7; // this is older version

//EVM ethereum virtual machin
//avalanche, fantom, polygon
contract SimpleStorage {
    // types can be boolean, uint, int, address, bytes

    ///this is initialized to zero
    //default is internal,
    uint256 favNum;

    //dictionaries
    mapping(string => uint256) public nameToFavNumber;

    ///object
    struct People {
        uint256 favNum;
        string name;
    }

    People public person = People({favNum: 2, name: "Fraol"});

    //array
    //uint256[] public favNums;
    People[] public people;

    //functions
    function store(uint256 _favNumber) public virtual {
        favNum = _favNumber;
        favNum = favNum + 1;
    }

    //when view and pure functions, when called alone, dont spend gas, they disallow any modification, and reading from the state
    function retrieve() public view returns (uint256) {
        return favNum;
    }

    ///calldata, memory, storage
    function addPerson(string memory _name, uint256 _favNum) public {
        people.push(People(_favNum, _name));
        nameToFavNumber[_name] = _favNum;
    }
}

//0xd9145CCE52D386f254917e481eB44e9943F39138

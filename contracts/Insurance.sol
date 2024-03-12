// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Insurance {
    uint256 public amount;
    address public owner;
    bool public passedAway;

    address[] public familyWallet;
    mapping(address => uint) inheritMoney;
    uint public familyShareValue;

    constructor() payable {
        owner = msg.sender;
        amount = msg.value;
        passedAway = false;
    }

    modifier onlyOwner() {
        require(owner == msg.sender, "Only the owner can create");
        _;
    }

    modifier mustPassAway() {
        require(passedAway == true, "They havent passed away");
        _;
    }

    function addMoney() public payable onlyOwner {
        amount = amount + msg.value;
    }

    function changePassedAway() public onlyOwner {
        passedAway = true;
    }

    function addFamilyMember(
        address familyAddress,
        uint familyShare
    ) public onlyOwner {
        familyWallet.push(familyAddress);
        inheritMoney[familyAddress] = familyShare;
        familyShareValue += familyShare;
    }

    function releaseTheFund() public mustPassAway {
        require(
            familyShareValue < amount,
            "The family share value is higher than the value we have, add some fund to the contract"
        );
        for (uint i = 0; i < familyWallet.length; i++) {
            payable(familyWallet[i]).transfer(inheritMoney[familyWallet[i]]);
        }
        familyWallet = new address[](0);
        familyShareValue = 0;
        //payable(msg.sender).transfer(address(this).balance);
    }
}

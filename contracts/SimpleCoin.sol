// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Coin {
    address public minter;
    mapping(address => uint) public balances;

    event Sent(address from, address to, uint256 amount);

    constructor() {
        minter = msg.sender;
    }

    modifier onlyOwener() {
        require(msg.sender == minter, "Only the owner can mint");
        _;
    }

    modifier lowAmount(uint256 amount) {
        require(balances[msg.sender] > amount, "You have low amount");
        _;
    }

    function mint(address receiver, uint256 amount) public onlyOwener {
        balances[receiver] += amount;
    }

    error insufficientBalance(uint256 requested, uint256 available);

    function transfer(address receiver, uint256 amount) public {
        if (balances[msg.sender] < amount) {
            revert insufficientBalance({
                requested: amount,
                available: balances[msg.sender]
            });
        }
        balances[msg.sender] -= amount;
        balances[receiver] += amount;
        emit Sent(msg.sender, receiver, amount);
    }

    function checkAmount() public view returns (uint256) {
        return balances[msg.sender];
    }
}

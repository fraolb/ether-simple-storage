// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

import "hardhat/console.sol";

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract WEB3ETH is ERC20 {
    address public liquidityFeeWallet;

    constructor(
        address coinMintedTo,
        address liquidityWalletFees
    ) ERC20("Web3Foundation", "WEB3ETH") {
        _mint(coinMintedTo, 1000);
        liquidityFeeWallet = liquidityWalletFees;
    }

    function transfer(
        address to,
        uint256 value
    ) public override returns (bool) {
        address owner = _msgSender();
        require(value < super.balanceOf(owner), "Not enough balance");
        uint256 theFeeValue = (value * 10) / 100;
        uint256 theTransactionAMount = value - theFeeValue;
        require(theFeeValue > 0, "The fees are 0");
        console.log(theTransactionAMount);
        console.log(theFeeValue);
        // console.log(msg.sender);
        super._transfer(owner, to, theTransactionAMount);
        super._transfer(owner, liquidityFeeWallet, theFeeValue);
        return true;
    }
}

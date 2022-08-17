// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.14;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

/**
* @title Token A.
* @author Anthony (fps) https://github.com/0xfps.
* @dev Token A for Uniswap.
*/
contract A is ERC20 {
    constructor() ERC20("A", "ATK") {
        _mint(msg.sender, 9000 * (10 ** 18));
        _mint(address(this), 1000 * (10 ** 18));
    }
}
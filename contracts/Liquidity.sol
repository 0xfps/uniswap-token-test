// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

import {A} from "./A.sol";
import {B} from "./B.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

import {IUniswapV2Router02} from "./interfaces/IUniswapV2Router02.sol";
// import "@uniswap/v2-periphery/contracts/UniswapV2Router02.sol";
// Incase you want to use the npm package.

/**
* @title Liquidity Provider.
* @author Anthony (fps) https://github.com/0xfps.
* @dev Liquidity Provider.
*/
contract LP {
    address private AToken;
    address private BToken;
    address private owner;

    IUniswapV2Router02 private router;

    modifier onlyOwner() {
        require(msg.sender == owner, "!Owner");
        _;
    }

    constructor() {
        owner = msg.sender;
        router = IUniswapV2Router02(0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D);

        AToken = address(new A());
        BToken = address(new B());
    }

    /**
    * @notice   This contract owns tokens on A and B respectively.
    *           The tokens affected are those owned by this contract at A and B.
    *           The `router` contract is approved to spend them.
    */
    function createLiquidity() public onlyOwner {
        uint256 ATokenBalance = IERC20(AToken).balanceOf(address(this));
        uint256 BTokenBalance = IERC20(BToken).balanceOf(address(this));

        IERC20(AToken).approve(address(router), ATokenBalance);
        IERC20(BToken).approve(address(router), BTokenBalance);

        router.addLiquidity(
            AToken,
            BToken,
            ATokenBalance,
            BTokenBalance,
            0, 0, address(this),
            (block.timestamp + 3 weeks)
        );
    }

    function getBalance() public view returns(uint256, uint256) {
        uint256 ATokenBalance = IERC20(AToken).balanceOf(address(this));
        uint256 BTokenBalance = IERC20(BToken).balanceOf(address(this));

        return (ATokenBalance, BTokenBalance);
        // Should be 0 for both after adding liquidity.
    }
}
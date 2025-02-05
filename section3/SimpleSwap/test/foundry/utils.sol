// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.17;

import { IERC20 } from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import { TestERC20 } from "../../contracts/test/TestERC20.sol";
import { Test } from "forge-std/Test.sol";
import { DSTest } from "ds-test/test.sol";
import { SimpleSwap } from "../../contracts/SimpleSwap.sol";
import { ISimpleSwapEvent } from "../../contracts/interface/ISimpleSwap.sol";

contract fixture is DSTest, Test, ISimpleSwapEvent {

  address taker = address(0x1234);
  address maker = address(0x5678);

  TestERC20 tokenA;
  TestERC20 tokenB;
  uint256 tokenADecimals;
  uint256 tokenBDecimals;
  uint256 slpDecimals;

  SimpleSwap simpleSwap;
  
  function setUp() public virtual {
    tokenB = new TestERC20("token B", "TKB");
    tokenA = new TestERC20("token A", "TKA");

    tokenADecimals = tokenA.decimals();
    tokenBDecimals = tokenB.decimals();
    simpleSwap = new SimpleSwap(address(tokenA), address(tokenB));

    tokenA.mint(taker, 1000 * 10 ** tokenADecimals);
    tokenA.mint(maker, 1000 * 10 ** tokenADecimals);
    tokenB.mint(taker, 1000 * 10 ** tokenBDecimals);
    tokenB.mint(maker, 1000 * 10 ** tokenBDecimals);

    vm.startPrank(taker);
    tokenA.approve(address(simpleSwap), 1000 * 10 ** tokenADecimals);
    tokenB.approve(address(simpleSwap), 1000 * 10 ** tokenADecimals);
    vm.stopPrank();

    vm.startPrank(maker);
    tokenA.approve(address(simpleSwap), 1000 * 10 ** tokenADecimals);
    tokenB.approve(address(simpleSwap), 1000 * 10 ** tokenADecimals);
    vm.stopPrank();

    vm.label(taker, "taker");
    vm.label(maker, "maker");
    vm.label(address(tokenA), "tokenA");
    vm.label(address(tokenB), "tokenB");
  }
}
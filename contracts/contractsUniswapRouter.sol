// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract UniswapPair {
    address public token0;
    address public token1;

    uint public reserve0;
    uint public reserve1;

    event Sync(uint reserve0, uint reserve1);
    event Swap(address indexed sender, uint amount0Out, uint amount1Out);

    constructor() {}

    function initialize(address _token0, address _token1) external {
        require(token0 == address(0), "Already initialized");
        token0 = _token0;
        token1 = _token1;
    }

    function getReserves() external view returns (uint, uint) {
        return (reserve0, reserve1);
    }

    function _update(uint balance0, uint balance1) internal {
        reserve0 = balance0;
        reserve1 = balance1;
        emit Sync(balance0, balance1);
    }

    function swap(uint amount0Out, uint amount1Out, address to) external {
        require(amount0Out > 0 || amount1Out > 0, "Invalid output");

        if (amount0Out > 0) reserve0 -= amount0Out;
        if (amount1Out > 0) reserve1 -= amount1Out;

        emit Swap(msg.sender, amount0Out, amount1Out);
    }
}

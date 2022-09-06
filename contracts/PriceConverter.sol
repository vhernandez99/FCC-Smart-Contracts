//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

library PriceConverter {
    function getPrice(AggregatorV3Interface priceFeed) internal view returns (uint256) {
        //abi of the contract
        //address of the contract 0x8A753747A1Fa494EC906cE90E9f37563A8AF630e
        (, int price, , , ) = priceFeed.latestRoundData();
        //ETH in terms of USD
        //300.0000000
        return uint256(price * 1e10); //1**10 == 1000000000
    }

    function getConversionRate(uint256 ethAmount, AggregatorV3Interface priceFeed)
        internal
        view
        returns (uint256)
    {
        uint256 ethPrice = getPrice(priceFeed);
        //3000_000000000000000000
        //1_000000000000000000 ETH
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18;
        return ethAmountInUsd;
    }
}

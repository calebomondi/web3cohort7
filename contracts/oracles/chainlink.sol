// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AggregatorV3Interface} from "@chainlink/contracts@1.3.0/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

contract ChainLinkOracle {
    AggregatorV3Interface internal dataFeedBTC;
    AggregatorV3Interface internal dataFeedETH;

    constructor(address _dataFeedBTC, address _dataFeedETH) {
        dataFeedBTC = AggregatorV3Interface(_dataFeedBTC);
        dataFeedETH = AggregatorV3Interface(_dataFeedETH);
    }

    function getLatestETH() external view returns (int) {
        (,int answer,,,) = dataFeedETH.latestRoundData();
        return  answer;
    }

    function getLatestBTC() external view returns (int) {
        (,int answer,,,) = dataFeedBTC.latestRoundData();
        return  answer;
    }
}
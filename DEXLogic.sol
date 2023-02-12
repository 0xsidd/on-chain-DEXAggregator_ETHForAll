// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import {IUNIFORK} from "./uniForkInterface.sol";

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract PathFinding{
    address constant public uniswapV2Router = 0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D;
    address constant public sushiswapV2Router = 0xd9e1cE17f2641f24aE83637ab66a2cca9C378B9F;

    address[] public dex = [0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D,0xd9e1cE17f2641f24aE83637ab66a2cca9C378B9F];

    address[] public selectors = [0x6B175474E89094C44Da98b954EedeAC495271d0F,0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48];
    // address[] public path = [0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2,0xdAC17F958D2ee523a2206206994597C13D831ec7];

    // function getDEXAmountOut(address[] memory path)public view returns(uint256[] memory,uint256[] memory){
    //     // address[2] memory path = [0x6B175474E89094C44Da98b954EedeAC495271d0F,0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2];
    //     uint256[] memory ret1 = IUNIFORK(uniswapV2Router).getAmountsOut(1e18,path); 
    //     uint256[] memory ret2 = IUNIFORK(sushiswapV2Router).getAmountsOut(1e18,path); 
    //     return(ret1,ret2);
    // }

    function getPrice(address[] memory path)public view returns(uint256){
        uint256 bestValue;
        
            for(uint256 j=0;j<2;j++){
                if(IUNIFORK(dex[j]).getAmountsOut(1e18,path)[1]>bestValue){
                    bestValue = IUNIFORK(dex[j]).getAmountsOut(1e18,path)[1];
                }
                else{bestValue=bestValue;}
            }
            uint256 uniP = IUNIFORK(dex[0]).getAmountsOut(1e18,path)[1];
            uint256 sushiP = IUNIFORK(dex[1]).getAmountsOut(1e18,path)[1];
            return (bestValue);
    }
}
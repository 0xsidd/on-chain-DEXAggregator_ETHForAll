// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import {IUNIFORK} from "./uniForkInterface.sol";

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract PathFinding{
    address constant public uniswapV2Router = 0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D;
    address constant public sushiswapV2Router = 0xd9e1cE17f2641f24aE83637ab66a2cca9C378B9F;

    address public WETH = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;
    address public USDC = 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48;
    address public USDT = 0xdAC17F958D2ee523a2206206994597C13D831ec7;
    address public DAI = 0x6B175474E89094C44Da98b954EedeAC495271d0F;
    address public OHM = 0x64aa3364F17a4D01c6f1751Fd97C2BD3D7e7f1D5;

    address[] public dex = [uniswapV2Router,sushiswapV2Router];

    address[] public path = [WETH,OHM];
    address [][] public allPath;

    constructor(){
        allPath.push([WETH,USDC]);
        allPath.push([USDC,USDT]);
        allPath.push([USDT,DAI]);
        allPath.push([DAI,OHM]);
    }


    function getPrice()public view returns(uint256){
        uint256 bestValue;
        for(uint256 i=0; i<path.length; i++){
            if(IUNIFORK(dex[i]).getAmountsOut(1e18,path)[1]>bestValue){
                bestValue = IUNIFORK(dex[i]).getAmountsOut(1e18,path)[1];
            }
            else{bestValue=bestValue;}
        }
            return (bestValue);
    }

    function getBestPriceWithPaths()public view returns(uint256,uint256,uint256){
         
        uint256 bestValue;
        uint256 tempVal;
        for(uint256 i; i<allPath.length; i++){
            for(uint256 j=0; j<dex.length; j++){

                if(i==0){
                    uint256 tempVal2 = IUNIFORK(dex[j]).getAmountsOut(1e18,allPath[i])[1];
                    if(tempVal2>tempVal){
                        tempVal=tempVal2;
                    }
                }
                else{
                    uint256 tempVal2 = IUNIFORK(dex[j]).getAmountsOut(tempVal,allPath[i])[1];
                    if(tempVal2>tempVal){
                        bestValue = tempVal;
                        tempVal=tempVal2;
                    }
                    else if(tempVal2>tempVal){
                        bestValue = tempVal;
                        tempVal=tempVal;
                    }
                }
                
            // bestValue = tempVal;
            }
        }
        uint256 one = IUNIFORK(dex[1]).getAmountsOut(1e18,allPath[0])[1];
        uint256 two = IUNIFORK(dex[1]).getAmountsOut(one,allPath[1])[1];
        uint256 three = IUNIFORK(dex[1]).getAmountsOut(two,allPath[2])[1];
        uint256 four = IUNIFORK(dex[1]).getAmountsOut(three,allPath[3])[1];
        // return(finalVal,IUNIFORK(dex[0]).getAmountsOut(1e18,path)[1]);
        return(bestValue,four,IUNIFORK(dex[1]).getAmountsOut(1e18,path)[1]);
    }
}
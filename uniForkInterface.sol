// SPDX-License-Identifier: MIT
pragma solidity =0.8.18;

interface IUNIFORK{
    function getAmountsOut(uint amountIn, 
      address[] memory path)
      external 
      view 
      returns (uint[] memory amounts);
}
/*
███████╗██╗      █████╗ ███╗   ███╗██╗███╗   ██╗ ██████╗          ██████╗ 
██╔════╝██║     ██╔══██╗████╗ ████║██║████╗  ██║██╔════╝         ██╔═══██╗
█████╗  ██║     ███████║██╔████╔██║██║██╔██╗ ██║██║  ███╗        ██║   ██║
██╔══╝  ██║     ██╔══██║██║╚██╔╝██║██║██║╚██╗██║██║   ██║        ██║   ██║
██║     ███████╗██║  ██║██║ ╚═╝ ██║██║██║ ╚████║╚██████╔╝███████╗╚██████╔╝
╚═╝     ╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚══════╝ ╚═════╝ 
        ██████╗ ██████╗  ██████╗ ██████╗                                  
        ██╔══██╗██╔══██╗██╔═══██╗██╔══██╗                                 
        ██║  ██║██████╔╝██║   ██║██████╔╝                                 
        ██║  ██║██╔══██╗██║   ██║██╔═══╝                                  
███████╗██████╔╝██║  ██║╚██████╔╝██║                                      
╚══════╝╚═════╝ ╚═╝  ╚═╝ ╚═════╝ ╚═╝
// SPDX-License-Identifier: MIT
*/
pragma solidity 0.7.5;

interface IERC20transferFrom { // interface for erc20 token `transferFrom()`
    function transferFrom(address from, address to, uint256 amount) external returns (bool);
}

interface IERC721transferFrom { // interface for erc721 token `transferFrom()`
    function transferFrom(address from, address to, uint256 tokenId) external;
}

interface IFL_O {
    function ownerOf(uint256 tokenId) external view returns (address);
    function totalSupply() external view returns (uint256);
}

contract FLAMING_O_DROP {
    address public FLAMING_O = 0xc7886c91fF20dE17c9161666202b8D8953D03BBD;
    
    function dropERC20(address token, uint256 amount) external { // drop token amount evenly on FL_O holders
        IFL_O FL_O = IFL_O(FLAMING_O);
        uint256 count = 1;
        uint256 length = FL_O.totalSupply();
        uint256 split = amount / length;
        
        for (uint256 i = 0; i < length; i++) {
            IERC20transferFrom(token).transferFrom(msg.sender, FL_O.ownerOf(count), split);
            count++;
        }
    }
    
    function dropERC721(address token) external { // drop NFT series on FL_O holders, starting from `tokenId` 1
        IFL_O FL_O = IFL_O(FLAMING_O);
        uint256 count = 1;
        uint256 length = FL_O.totalSupply();
        
        for (uint256 i = 0; i < length; i++) {
            IERC721transferFrom(token).transferFrom(msg.sender, FL_O.ownerOf(count), count);
            count++;
        }
    }
}

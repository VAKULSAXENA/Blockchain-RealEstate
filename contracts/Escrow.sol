// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

interface IERC721{
    function transferFrom(address _from,address _to,uint _id) external;
}

contract Escrow{
    address public lender;
    address public inspector;
    address payable public seller;
    address public nftAddress;

    mapping(uint=>bool) public islisted;
    mapping(uint=>uint) public purchasePrice;
    mapping(uint=>uint) public escrowAmount;
    mapping(uint=>address) public buyer;
    mapping(uint=>bool) public inspectionPassed;
    mapping(uint=>mapping(address=>bool)) approval;

    modifier onlySeller {
        require(msg.sender==seller,'You are not registered Seller');
        _;
    }

    constructor(address _lender,address _inspector,address payable _seller, address _nftAddress){
        lender=_lender;
        inspector=_inspector;
        seller=_seller;
        nftAddress=_nftAddress;

    }

    function list(uint _nftId,address _buyer,uint _purchasePrice,uint _escrowAmount) public onlySeller {
        IERC721(nftAddress).transferFrom(msg.sender,address(this),_nftId);
        islisted[_nftId]=true;
        purchasePrice[_nftId]=_purchasePrice; 
        escrowAmount[_nftId]=_escrowAmount;
        buyer[_nftId]=_buyer;

    }

    function depositEarnest(uint _nftId) public payable {
        require(msg.value>=escrowAmount[_nftId],"Insufficient amount");
        
    }

    function updateInspectionStatus(uint _nftId,bool _passed) public {
            inspectionPassed[_nftId]=_passed;
    }
    function approveSale(uint _nftId) public returns(bool){
        approval[_nftId][msg.sender]=true;
    }
}


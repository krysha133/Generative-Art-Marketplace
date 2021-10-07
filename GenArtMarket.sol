pragma solidity ^0.8.0;
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/token/ERC721/ERC721Full.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/ownership/Ownable.sol";
import "./GenArtAuction.sol";
contract GenArtMarket is ERC721Full, Ownable {
    constructor() ERC721Full("GenArtMarket", "GWART") public {}
    using Counters for Counters.Counter;
    Counters.Counter token_ids;
    address payable foundation_address = msg.sender;
    mapping(uint => GenArtAuction) public auctions;   // referencing autcion contract call auctions contract
    modifier artRegistered(uint token_id) {
        require(_exists(token_id), "Your art is not registered!");
        _;
    }
    function createAuction(uint token_id) public onlyOwner {
        auctions[token_id] = new GenArtAuction(foundation_address); // person who own scontract ran in
    }
    function registerArt(string memory uri) public payable onlyOwner{
        token_ids.increment();  // new piece of mona lisa new Art, new token created
        uint token_id = token_ids.current();
        _mint(foundation_address, token_id);  // new record of token created
        _setTokenURI(token_id, uri);
        createAuction(token_id);
    }
    function endAuction(uint token_id) public onlyOwner artRegistered(token_id) {
        GenArtAuction auction = auctions[token_id]; // identify variable , what auction we are dealing with , this bracket is not python it refers to mapping in line 21
        auction.auctionEnd(); // call other auction contract end , these two identify parent child () is dealing with function
        safeTransferFrom(owner(), auction.highestBidder(), token_id);
    }
    function auctionEnded(uint token_id) public view returns(bool) {
        GenArtAuction auction = auctions[token_id];
        return auction.ended();
    }
    function highestBid(uint token_id) public view artRegistered(token_id) returns(uint) {
        GenArtAuction auction = auctions[token_id];
        return auction.highestBid();
    }
    function pendingReturn(uint token_id, address sender) public view artRegistered(token_id) returns(uint) {
        GenArtAuction auction = auctions[token_id];
        return auction.pendingReturn(sender);
    }
    function bid(uint token_id) public payable artRegistered(token_id) { // token id is image token
        GenArtAuction auction = auctions[token_id]; // singular auction passing in token id , create and instance of other contract
        auction.bid.value(msg.value)(msg.sender); // taking value for bid X and the address of who sent the message,  this is where python comes in
    }                   // bid lets us pass in token id for art in the UI , auction with bid from auction contract line 41 other contract
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;
import "./GamePlayerStatus.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DchainGame is Ownable {
    string public name;
    string public thumbnail;
    uint public price;
    string[] private tasks;

    mapping(address => address) private players;
    address[] private playerAddresses;

    event DchainGamePurchased(address indexed player, address playerContract);

    constructor(string memory _name, uint _price, string memory _thumbnail, string[] memory _tasks) Ownable(msg.sender) {
        name = _name;
        price = _price;
        thumbnail = _thumbnail;
        tasks = _tasks;
    }

    function buyGame() external payable {
        require(players[msg.sender] == address(0), "You have already bought the game");
        require(msg.value >= price, "Insufficient funds");

        payable(owner()).transfer(msg.value);

        GamePlayerStatus playerContract = new GamePlayerStatus(tasks);
        players[msg.sender] = address(playerContract);
        playerAddresses.push(msg.sender);
        emit DchainGamePurchased(msg.sender, address(playerContract));
    }

    function getPlayerContract() public view returns (address) {
        return players[msg.sender];
    }

    function hasPurchasedGame(address player) public view returns (bool) {
        return players[player] != address(0);
    }

    function getAllPlayers() public view returns (address[] memory) {
        return playerAddresses;
    }
}

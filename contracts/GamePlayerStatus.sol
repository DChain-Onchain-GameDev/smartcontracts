// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

contract GamePlayerStatus {
    mapping(string => bool) private tasks;
    string[] private taskNames;

    event TaskCompleted(string task);
    event TasksReset();

    constructor(string[] memory _tasks) {
        for (uint i = 0; i < _tasks.length; i++) {
            tasks[_tasks[i]] = false;
            taskNames.push(_tasks[i]);
        }
    }

    modifier taskExists(string memory _task) {
        require(checkTaskExists(_task), "Task does not exist");
        _;
    }

    function checkTaskExists(string memory _task) public view returns (bool) {
        for (uint i = 0; i < taskNames.length; i++) {
            if (keccak256(abi.encodePacked(taskNames[i])) == keccak256(abi.encodePacked(_task))) {
                return true;
            }
        }
        return false;
    }

    function completeTask(string memory _task) public taskExists(_task) returns (bool) {
        tasks[_task] = true;
        emit TaskCompleted(_task);
        return gameStatus();
    }

    function isTaskCompleted(string memory _task) public view taskExists(_task) returns (bool) {
        return tasks[_task];
    }

    function reset() public {
        for (uint i = 0; i < taskNames.length; i++) {
            tasks[taskNames[i]] = false;
        }
        emit TasksReset();
    }

    function getTaskStatus() public view returns (string[] memory, bool[] memory) {
        bool[] memory status = new bool[](taskNames.length);
        for (uint i = 0; i < taskNames.length; i++) {
            status[i] = tasks[taskNames[i]];
        }
        return (taskNames, status);
    }

    function gameStatus() public view returns (bool) {
        for (uint i = 0; i < taskNames.length; i++) {
            if (!tasks[taskNames[i]]) {
                return false;
            }
        }
        return true;
    }

    function getTasks() public view returns (string[] memory) {
        return taskNames;
    }
}

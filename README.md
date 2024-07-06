# Smart Contracts for Game Developement on Dchain

#### PlayerStatus.sol

The `PlayerStatus` contract manages the status of tasks for a player in a game. It includes functions to complete tasks, check if tasks are completed, reset tasks, and retrieve the status of all tasks. Key features include:
- **Task Management**: Players can mark tasks as completed and reset all tasks.
- **Task Existence**: Checks to ensure a task exists before performing actions.
- **Events**: Emits events when tasks are completed or reset.
- **Task Status Retrieval**: Allows retrieval of all tasks and their completion status.

#### GameFactory.sol

The `GameFactory` contract is responsible for creating new game instances and keeping track of all created games. Key features include:
- **Game Creation**: Allows the creation of new game contracts with specified parameters (name, price, thumbnail, and tasks).
- **Game Tracking**: Maintains a list of all created game contract addresses.
- **Events**: Emits an event when a new game is created.
- **Game Information Retrieval**: Provides functions to get total games created and detailed information about a specific game.

#### Game.sol

The `Game` contract represents a game that players can purchase. It includes functions to manage game purchases and player-specific task statuses. Key features include:
- **Game Purchase**: Allows players to buy the game by sending the required Ether.
- **Player Management**: Keeps track of players who have purchased the game and their associated `PlayerStatus` contract.
- **Events**: Emits an event when a game is purchased.
- **Player Contract Access**: Provides functions to get the `PlayerStatus` contract for a player and check if a player has purchased the game.
- **All Players Retrieval**: Allows retrieval of all players who have purchased the game.

### Contract Interaction Flow

1. **Game Creation**: 
   - The `GameFactory` contract is used to create new `Game` contracts.
   - Each game is initialized with specific parameters and the address of the game contract is stored.

2. **Buying a Game**:
   - Players can buy a game by calling the `buyGame` function in the `Game` contract and sending the required Ether.
   - Upon purchase, a new `PlayerStatus` contract is created for the player to manage their tasks within the game.
   - The player's address and their associated `PlayerStatus` contract address are stored.

3. **Managing Tasks**:
   - Players can interact with their `PlayerStatus` contract to complete tasks, check task status, and reset tasks.
   - The `PlayerStatus` contract emits events to log task completions and resets.

4. **Retrieving Information**:
   - The `GameFactory` contract can provide a list of all created game addresses and detailed information about each game.
   - The `Game` contract can provide the address of a player's `PlayerStatus` contract and a list of all players who have purchased the game.

These contracts together create a robust system for managing games and player task statuses in a decentralized manner.
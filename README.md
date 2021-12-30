## everchess.io (WIP)

Strange and useless chess game on Everscale blockchain.

### How does it work

Two players place bids on a deployed round. Then they call the `move` method until 
someone wins. The winner gets everything.

### How to build
```bash
everdev sol compile --output-dir build ./src/Chess.sol
```

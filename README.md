# Generative-Art-Marketplace
## The Pitch
A seamless user experience for non-tech savy customers to be able to utilize our pre-built generative art models(created using tensorflow) to generate art or transfer styles from an image of a painting onto an image of a personally taken photo. We also provide the user a front-end python interface to be able to tokenize their artwork as an ERC721 Non-Fungible-Token and auction it off using our smart contracts. The project is still a work in progress and has currently only been tested on a locally hosted Ethereum network.
### Usage
1. Generate Art with [Generate](/Generate Art with Tensorflow) Note: Model is CPU intensive and is recommended to be run on Google Collab or alternatively Amazon Web Services
2. Setup a local network using Ganache and create a custom RPC on Metamask 
3. Deploy [Contracts](/contracts) using remix.ide
4. Upload image you want to tokenize onto IPFS using Pinata, convert CID to CIDv1
5. Run [Dashboard](/frontend/message_board.ipynb) and follow the prompts


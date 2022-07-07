#  IPFS Monitor

Small application to monitor and analyse
which peers contribute, and how much, to the download of a content, preferably
large, from the IPFS network.\
In particular, the goals of the assignment are:

1. Download large files, or folders, from IPFS
2. Query the bitswap agent to get the CID of the partners, and query the ledger
to know which partners contributed to the download of a file, and how much
they contributes;
3. Detect the location of these peers around the globe.

##  Instructions

1. Install [IPFS](https://ipfs.io/#install)
2. `ipfs init`
3. `ipfs daemon`
4. `zsh ipfs.sh`

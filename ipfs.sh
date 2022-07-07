#!/bin/sh
echo "This script downloads a file from IPFS;"
echo "query the bitswap agent to get the CID of the partners, and query the ledger
to know which partners contributed to the download of a file, and how much
they contributes\n"

SHUTTLE_IMAGE=QmSgvgwxZGaBLqkGyWemEDqikCqU52XxsYLKtdy3vGZ8uq

echo "Download a shuttle jpg ($SHUTTLE_IMAGE)"
ipfs get $SHUTTLE_IMAGE

PEERS=( $(ipfs bitswap stat -v) )
# remove non peers item from PEERS
PEERS=( "${PEERS[@]:32}" )
MAXES=()
for peer in $PEERS
do  
    LEDGER=( $(ipfs bitswap ledger $peer) )
    NODE=$LEDGER[3]
    EXCHANGE=$LEDGER[8]
    BYTES_SENT=$LEDGER[11]
    BYTES_RECEIVED=$LEDGER[14]
    if (( $EXCHANGE > 0 || $BYTES_SENT > 0 || $BYTES_RECEIVED > 0)); then
        MAXES+=( $NODE )
    fi
done

echo "Peers with contribution:"
for peer in $MAXES
do
    ipfs bitswap ledger $peer
    LINE_ADDRESS=$(ipfs id $peer -f="<addrs>\n")
    ADDRESS=${LINE_ADDRESS:5:13}
    echo address of $peer
    curl http://ip-api.com/json/$ADDRESS

done
    
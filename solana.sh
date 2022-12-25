#!/bin/bash
#set -x -e

npm install solana-web3.js binance-api-node @solana/web3.js

vote_acc=""
key_acc=""
author=""

while :
do
    echo "checking Epoch Progress"
    epoch="$(solana epoch-info | grep -o "......%" | tr -d [=%=][:space:])"
    echo "$epoch %"
    num2=0.25
    echo "Not yeat"
    sleep 60

if (( $(echo "$epoch > $num2" |bc -l) )); then
continue
fi
    echo "Let's go!"
    echo "Withdraw from vote"
    sleep 400
    solana -um withdraw-from-vote-account "$vote_acc" "$key_acc" ALL -k "$author"
    sleep 90
    echo "Withdraw to binance and sell"
    node ./withdrawsol.js

done

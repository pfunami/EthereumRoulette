// 0x692a70d2e424a56d2c6c27aa97d1a86395877b3a

if (typeof web3 !== 'undefined') {
    web3 = new Web3(web3.currentProvider);
    ethereum.enable();
    web3.version.getNetwork((error, result) => {
        console.log('Network ID: ' + result)
    });
    var account = "0x937be33cc76117b967d33966099c81b2d1a9a383";

    web3.eth.getAccounts((error, result) => {
        account = result[0];
        console.log('Your accounts: ' + account);
    });

    let addr = "0x0ca430128d017bff36154dacc761437da3e429f2";
    let abi = [
        {
            "constant": true,
            "inputs": [],
            "name": "name",
            "outputs": [
                {
                    "name": "",
                    "type": "string"
                }
            ],
            "payable": false,
            "stateMutability": "view",
            "type": "function"
        },
        {
            "constant": true,
            "inputs": [],
            "name": "totalSupply",
            "outputs": [
                {
                    "name": "",
                    "type": "uint256"
                }
            ],
            "payable": false,
            "stateMutability": "view",
            "type": "function"
        },
        {
            "constant": true,
            "inputs": [],
            "name": "getChipVal",
            "outputs": [
                {
                    "name": "",
                    "type": "uint256"
                }
            ],
            "payable": false,
            "stateMutability": "view",
            "type": "function"
        },
        {
            "constant": false,
            "inputs": [
                {
                    "name": "_exChip",
                    "type": "uint256"
                }
            ],
            "name": "exchangeChip",
            "outputs": [],
            "payable": false,
            "stateMutability": "nonpayable",
            "type": "function"
        },
        {
            "constant": true,
            "inputs": [],
            "name": "decimals",
            "outputs": [
                {
                    "name": "",
                    "type": "uint256"
                }
            ],
            "payable": false,
            "stateMutability": "view",
            "type": "function"
        },
        {
            "constant": true,
            "inputs": [
                {
                    "name": "_origin",
                    "type": "string"
                },
                {
                    "name": "_target",
                    "type": "string"
                }
            ],
            "name": "isSameString",
            "outputs": [
                {
                    "name": "",
                    "type": "bool"
                }
            ],
            "payable": false,
            "stateMutability": "pure",
            "type": "function"
        },
        {
            "constant": true,
            "inputs": [],
            "name": "key",
            "outputs": [
                {
                    "name": "",
                    "type": "uint256"
                }
            ],
            "payable": false,
            "stateMutability": "view",
            "type": "function"
        },
        {
            "constant": true,
            "inputs": [],
            "name": "getBetValAll",
            "outputs": [
                {
                    "name": "",
                    "type": "uint256"
                }
            ],
            "payable": false,
            "stateMutability": "view",
            "type": "function"
        },
        {
            "constant": true,
            "inputs": [],
            "name": "player",
            "outputs": [
                {
                    "name": "",
                    "type": "address"
                }
            ],
            "payable": false,
            "stateMutability": "view",
            "type": "function"
        },
        {
            "constant": true,
            "inputs": [],
            "name": "inNums",
            "outputs": [
                {
                    "name": "kind",
                    "type": "string"
                },
                {
                    "name": "dividend",
                    "type": "uint256"
                }
            ],
            "payable": false,
            "stateMutability": "view",
            "type": "function"
        },
        {
            "constant": false,
            "inputs": [],
            "name": "getMustPayAd",
            "outputs": [
                {
                    "name": "",
                    "type": "uint256"
                }
            ],
            "payable": false,
            "stateMutability": "nonpayable",
            "type": "function"
        },
        {
            "constant": true,
            "inputs": [],
            "name": "payed",
            "outputs": [
                {
                    "name": "",
                    "type": "uint256"
                }
            ],
            "payable": false,
            "stateMutability": "view",
            "type": "function"
        },
        {
            "constant": true,
            "inputs": [
                {
                    "name": "",
                    "type": "uint256"
                }
            ],
            "name": "mustPay",
            "outputs": [
                {
                    "name": "",
                    "type": "uint256"
                }
            ],
            "payable": false,
            "stateMutability": "view",
            "type": "function"
        },
        {
            "constant": false,
            "inputs": [
                {
                    "name": "_val",
                    "type": "uint256"
                }
            ],
            "name": "buyChip",
            "outputs": [],
            "payable": false,
            "stateMutability": "nonpayable",
            "type": "function"
        },
        {
            "constant": true,
            "inputs": [
                {
                    "name": "",
                    "type": "address"
                }
            ],
            "name": "balanceOf",
            "outputs": [
                {
                    "name": "",
                    "type": "uint256"
                }
            ],
            "payable": false,
            "stateMutability": "view",
            "type": "function"
        },
        {
            "constant": true,
            "inputs": [],
            "name": "symbol",
            "outputs": [
                {
                    "name": "",
                    "type": "string"
                }
            ],
            "payable": false,
            "stateMutability": "view",
            "type": "function"
        },
        {
            "constant": true,
            "inputs": [],
            "name": "dealer",
            "outputs": [
                {
                    "name": "",
                    "type": "address"
                }
            ],
            "payable": false,
            "stateMutability": "view",
            "type": "function"
        },
        {
            "constant": true,
            "inputs": [],
            "name": "chip",
            "outputs": [
                {
                    "name": "",
                    "type": "uint256"
                }
            ],
            "payable": false,
            "stateMutability": "view",
            "type": "function"
        },
        {
            "constant": false,
            "inputs": [
                {
                    "name": "num",
                    "type": "uint256"
                }
            ],
            "name": "init",
            "outputs": [],
            "payable": false,
            "stateMutability": "nonpayable",
            "type": "function"
        },
        {
            "constant": true,
            "inputs": [],
            "name": "betValAll",
            "outputs": [
                {
                    "name": "",
                    "type": "uint256"
                }
            ],
            "payable": false,
            "stateMutability": "view",
            "type": "function"
        },
        {
            "constant": false,
            "inputs": [
                {
                    "name": "_from",
                    "type": "address"
                },
                {
                    "name": "_to",
                    "type": "address"
                },
                {
                    "name": "_value",
                    "type": "uint256"
                }
            ],
            "name": "transfer",
            "outputs": [],
            "payable": false,
            "stateMutability": "nonpayable",
            "type": "function"
        },
        {
            "constant": true,
            "inputs": [],
            "name": "outNums",
            "outputs": [
                {
                    "components": [
                        {
                            "name": "num",
                            "type": "uint256"
                        },
                        {
                            "name": "kind",
                            "type": "string"
                        },
                        {
                            "name": "dividend",
                            "type": "uint256"
                        }
                    ],
                    "name": "range",
                    "type": "tuple"
                },
                {
                    "components": [
                        {
                            "name": "num",
                            "type": "uint256"
                        },
                        {
                            "name": "kind",
                            "type": "string"
                        },
                        {
                            "name": "dividend",
                            "type": "uint256"
                        }
                    ],
                    "name": "color",
                    "type": "tuple"
                },
                {
                    "components": [
                        {
                            "name": "num",
                            "type": "uint256"
                        },
                        {
                            "name": "kind",
                            "type": "string"
                        },
                        {
                            "name": "dividend",
                            "type": "uint256"
                        }
                    ],
                    "name": "odd_even",
                    "type": "tuple"
                },
                {
                    "components": [
                        {
                            "name": "num",
                            "type": "uint256"
                        },
                        {
                            "name": "kind",
                            "type": "string"
                        },
                        {
                            "name": "dividend",
                            "type": "uint256"
                        }
                    ],
                    "name": "high_low",
                    "type": "tuple"
                },
                {
                    "components": [
                        {
                            "name": "num",
                            "type": "uint256"
                        },
                        {
                            "name": "kind",
                            "type": "string"
                        },
                        {
                            "name": "dividend",
                            "type": "uint256"
                        }
                    ],
                    "name": "column",
                    "type": "tuple"
                }
            ],
            "payable": false,
            "stateMutability": "view",
            "type": "function"
        },
        {
            "constant": false,
            "inputs": [
                {
                    "name": "place",
                    "type": "string"
                },
                {
                    "name": "number",
                    "type": "uint256"
                },
                {
                    "name": "betVal",
                    "type": "uint256"
                }
            ],
            "name": "betOut",
            "outputs": [],
            "payable": false,
            "stateMutability": "nonpayable",
            "type": "function"
        },
        {
            "constant": false,
            "inputs": [
                {
                    "name": "_ranNum",
                    "type": "uint256"
                }
            ],
            "name": "payOut",
            "outputs": [],
            "payable": false,
            "stateMutability": "nonpayable",
            "type": "function"
        },
        {
            "inputs": [
                {
                    "name": "_supply",
                    "type": "uint256"
                },
                {
                    "name": "_name",
                    "type": "string"
                },
                {
                    "name": "_symbol",
                    "type": "string"
                },
                {
                    "name": "_decimals",
                    "type": "uint256"
                },
                {
                    "name": "_dealer",
                    "type": "address"
                }
            ],
            "payable": false,
            "stateMutability": "nonpayable",
            "type": "constructor"
        },
        {
            "anonymous": false,
            "inputs": [
                {
                    "indexed": true,
                    "name": "from",
                    "type": "address"
                },
                {
                    "indexed": true,
                    "name": "to",
                    "type": "address"
                },
                {
                    "indexed": false,
                    "name": "value",
                    "type": "uint256"
                }
            ],
            "name": "Transfer",
            "type": "event"
        },
        {
            "anonymous": false,
            "inputs": [
                {
                    "indexed": false,
                    "name": "getChip",
                    "type": "uint256"
                },
                {
                    "indexed": false,
                    "name": "allChip",
                    "type": "uint256"
                },
                {
                    "indexed": false,
                    "name": "value",
                    "type": "uint256"
                }
            ],
            "name": "GetChip",
            "type": "event"
        },
        {
            "anonymous": false,
            "inputs": [
                {
                    "indexed": false,
                    "name": "exchangeChip",
                    "type": "uint256"
                },
                {
                    "indexed": false,
                    "name": "allChip",
                    "type": "uint256"
                },
                {
                    "indexed": false,
                    "name": "value",
                    "type": "uint256"
                }
            ],
            "name": "ExchangeChip",
            "type": "event"
        }
    ];

    let contract = web3.eth.contract(abi).at(addr);

    $('#spin').on('click', function () {
        let random = Math.floor(Math.random() * 37);    //0~36
        contract.payOut.sendTransaction(random, {
            from: "0x937be33cc76117b967d33966099c81b2d1a9a383",
            gas: 3000000
        }, (error, result) => {
            console.log('Transaction Hash : ' + result);
            $('#output').text(random.toString());
        });
    });


    let getBalance = function () {
        web3.eth.getBalance("0x937be33cc76117b967d33966099c81b2d1a9a383", (error, balance) => {
            $('#balance').text(web3.fromWei(balance, "ether"));
        });
        // contract.balanceOf.call("0x937be33cc76117b967d33966099c81b2d1a9a383", (error, result) => {
        //     $('#balance').text(web3.fromWei(result, "ether"));
        // });
        let dealer = "0xc289e22143536dB9e0556d87E45dC17cF3f84aCD";
        web3.eth.getBalance(dealer, (error, balance) => {
            console.log('Dealer Balance: ' + balance);
            // $('#balance').text(web3.fromWei(balance[0], "ether"));
        });
        // contract.balanceOf.call(dealer, (error, result) => {
        //     web3.fromWei(result, "ether");
        //     console.log('Dealer Balance: ' + result);
        // });
    };

    let getChipVal = function () {
        contract.getChipVal.call((error, result) => {
            $('#chipNum').text(web3.fromWei(result, "ether"));
        });
    };
    setInterval(getChipVal, 1000);
    setInterval(getBalance, 1000);

    let dealer = "0xc289e22143536dB9e0556d87E45dC17cF3f84aCD";
    $('#buyChip').on('click', function () {
        let val = web3.toWei($('#inputEth').val(), "ether");
        contract.buyChip.sendTransaction(val, {
            from: "0x937be33cc76117b967d33966099c81b2d1a9a383",
            gas: 3000000
        }, (error, result) => {
            console.log('Transaction Hash : ' + result);
        });
        web3.eth.sendTransaction({
            from: "0x937be33cc76117b967d33966099c81b2d1a9a383",
            to: dealer,
            value: val
        }, (error, balance) => {
            console.log(balance);
        });
    });

    $('#exchangeChip').on('click', function () {
        let val = web3.toWei($('#inputChip').val(), "ether");
        contract.exchangeChip.sendTransaction(val, {
            from: "0x937be33cc76117b967d33966099c81b2d1a9a383",
            gas: 3000000
        }, (error, result) => {
            console.log('Transaction Hash : ' + result);
            window.alert($('#inputChip').val()+'ETH の換金を受け付けました。n時間後に反映されます。')
        });
        // web3.eth.sendTransaction({
        //     from: "0x937be33cc76117b967d33966099c81b2d1a9a383",
        //     to: dealer,
        //     value: val * 0.95
        // }, (error, balance) => {
        //     console.log(balance);
        // });
    });

    function disp(place, num) {
        let betVal = window.prompt("賭け額を入力してください", "");

        if (betVal === '' || isNaN(betVal.valueOf())) {
            window.alert('数値を入力してください')
        } else {

            contract.betOut.sendTransaction(place, num, web3.toWei(betVal.valueOf(), "ether"), {
                from: "0x937be33cc76117b967d33966099c81b2d1a9a383",
                gas: 3000000
            }, (error, result) => {
                console.log('Transaction Hash : ' + result);
            });
        }

    }

    let betValAll = 0;

    let dispPos = [];
    let startingPos = 0;
    $('.button_num.button-red, .button_num.button-black').on('click', function () {
        let id = $(this).attr("id");
        disp("Straight Up", id.valueOf());
        dispPos.push(this);
    });
    $('.button_num.button-zero').on('click', function () {
        disp("Straight Up", 0);
        dispPos.push(this);
    });


    $('.button_num.button-column, .button_num.button-range, .button_num.other, .button_num.other.red, .button_num.other.black').on('click', function () {
        let id = $(this).attr("id");
        disp(id, 37);
        dispPos.push(this);
    });

    function getBetValAll() {
        contract.getBetValAll.call((error, result) => {
            // if (result.valueOf() === 0) {
            //     console.log("!!!!!!!!!");
            //     $('.ethcoin').remove();
            // }else
            if (result.valueOf() !== betValAll) {
                for (let i = startingPos; i < dispPos.length; i++) {
                    $(dispPos[i]).append('<div class="ethcoin" id="coin"><img src="/images/ethcoin.png" alt="eth coin" height="50"></div>');
                }
                startingPos = dispPos.length;
                betValAll = result.valueOf();
            }
            if (betValAll == 0) {
                $('.ethcoin').remove();
            }
        });
    }
    setInterval(getBetValAll, 1000);
} else {
    document.write('Install <a href="https://metamask.io">METAMASK</a>')
}
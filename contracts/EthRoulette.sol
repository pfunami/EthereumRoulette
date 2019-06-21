pragma solidity ^0.5.8;
pragma experimental ABIEncoderV2;

import "github.com/oraclize/ethereum-api/oraclizeAPI.sol";

//乱数生成
//import "github.com/oraclize/ethereum-api/oraclizeAPI_0.5.sol";
//ディーラーとプレイヤー
contract EthRoulette is usingOraclize {
    uint public randomNumber;
    bytes32 public request_id;

    //    function RandomNumberOraclized() {
    //        // (1) Oraclize Address Resolver の読み込み
    //        // <OARアドレスを指定。deterministic OAR の場合、この行の指定は必要ない
    //        OAR = OraclizeAddrResolverI(0x45831C2e2e081F7373003502D1D490e62b09A0dD);
    //    }

    function request() {
        // (2) OraclizeへWolframAlphaによる計算を依頼
        // デバッグのため、request_idにOraclizeへの処理依頼番号を保存しておきます
        request_id = oraclize_query("WolframAlpha", "random number between 0 and 36");
    }

    // (3) Oraclize側で外部処理が実行されると、この__callback関数を呼び出してくれる
    function __callback(bytes32 request_id, string result) {
        if (msg.sender != oraclize_cbAddress()) {
            throw;
        }

        // (4) 実行結果resultをdrawnNumberへ保存
        randomNumber = parseInt(result);
    }

    /*状態変数の宣言*/
    string public name;         /*tokenの名前*/
    string public symbol;       /*tokenの単位*/
    uint8 public decimals;      /*小数点以下の桁数*/
    uint256 public totalSupply; /*tokenの総量*/
    uint256 public chip;
    mapping(address => uint256) public balanceOf; /*各アドレスの残高*/
    address public dealer;
    address public player;

    /*コンストラクタ*/
    constructor(uint256 _supply, string memory _name, string memory _symbol, uint8 _decimals, address _dealer)public{
        player = msg.sender;
        dealer = _dealer;
        balanceOf[msg.sender] = _supply;
        balanceOf[dealer] = _supply * 100;
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
        totalSupply = _supply * 101;
        chip = 0;
    }

    struct outsideBet {
        uint num;
        string kind;
        uint256 dividend;
    }

    struct insideBet {
        string kind;
        uint256 dividend;
    }

    struct Outside {
        outsideBet range;
        outsideBet color;
        outsideBet odd_even;
        outsideBet high_low;
        outsideBet column;
    }

    Outside public outNums;
    insideBet public inNums;    //将来的に枠線上ルールを設置

    function init(uint num) public {
        //inside
        inNums.dividend = 36;
        inNums.kind = "Straight Up";

        //outside
        Outside memory number;
        /*range*/
        number.range.dividend = 3;
        if (num == 0) {
            number.range.kind = "ZERO";
        } else if (num <= 12) {
            number.range.kind = "SMALL";
        } else if (num <= 24) {
            number.range.kind = "MEDIUM";
        } else if (num <= 36) {
            number.range.kind = "LARGE";
        }
        /*color*/
        number.color.dividend = 2;
        if (num == 0) {
            number.color.kind = "none";
        } else if (num / 10 == 0 || num / 10 == 2) {
            if (num % 2 == 1 && num != 29) {
                number.color.kind = "RED";
            } else {
                number.color.kind = "BLACK";
            }
        } else {
            if ((num % 2 == 0 && num != 10) || num == 19) {
                number.color.kind = "RED";
            } else {
                number.color.kind = "BLACK";
            }
        }
        /*odd_even*/
        number.odd_even.dividend = 2;
        if (num == 0) {
            number.odd_even.kind = "none";
        } else if (num % 2 == 1) {
            number.odd_even.kind = "ODD";
        } else {
            number.odd_even.kind = "EVEN";
        }
        /*high_low*/
        number.high_low.dividend = 2;
        if (num == 0) {
            number.high_low.kind = "none";
        } else if (num <= 18) {
            number.high_low.kind = "LOW";
        } else {
            number.high_low.kind = "HIGH";
        }
        /*column*/
        number.column.dividend = 3;
        if (num == 0) {
            number.column.kind = "none";
        } else if (num % 3 == 0) {
            number.column.kind = "pat1";
        } else if (num % 3 == 1) {
            number.column.kind = "pat2";
        } else {
            number.column.kind = "pat3";
        }
        outNums = number;

    }


    /*イベント通知*/
    event Transfer(address indexed from, address indexed to, uint256 value);


    /*送金*/
    function transfer(address _from, address _to, uint256 _value) public returns (bool) {

        /*不正送金チェック*/
        if (balanceOf[msg.sender] < _value) {
            return false;

        }
        if (balanceOf[_to] + _value < balanceOf[_to]) {
            return false;

        }

        /*送金アドレスと受信アドレスの残高を更新*/
        balanceOf[_from] -= _value;
        balanceOf[_to] += _value;

        /*イベント通知*/
        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    struct betInfo {
        string kind;
        uint256 betVal;
        uint num;
    }

    betInfo bet_info;
    betInfo[] betInfos;
    /*イベント通知*/
    event GetChip(uint256 getChip, uint256 allChip, uint256 value);
    event ExchangeChip(uint256 exchangeChip, uint256 allChip, uint256 value);

    function buyChip(uint256 _val) public {
        if (transfer(player, dealer, _val)) {
            chip += _val;
            emit GetChip(_val, chip, balanceOf[player]);
        }
    }

    function exchangeChip(uint256 _exChip) public {
        if (_exChip <= chip && transfer(dealer, player, _exChip)) {
            chip -= _exChip;
            emit ExchangeChip(_exChip, chip, balanceOf[player]);
        }
    }

    function betOut(string memory place, uint number, uint256 betVal) public {
        bet_info.kind = place;
        bet_info.betVal = betVal;
        bet_info.num = number;
        betInfos.push(bet_info);
    }

    function isSameString(string memory _origin, string memory _target) public pure returns (bool) {
        return keccak256(abi.encodePacked(_origin)) == keccak256(abi.encodePacked(_target));
    }

    uint beginNum = 0;
    function payOut(uint _ranNum) public {
        init(_ranNum);
        bool profits = false;
        for (uint i = beginNum; i < betInfos.length; i++) {
            if (isSameString(outNums.range.kind, betInfos[i].kind)) {
                profits = true;
                chip += betInfos[i].betVal * outNums.range.dividend;
            }
            if (isSameString(outNums.high_low.kind, betInfos[i].kind)) {
                profits = true;
                chip += betInfos[i].betVal * outNums.high_low.dividend;
            }
            if (isSameString(outNums.odd_even.kind, betInfos[i].kind)) {
                profits = true;
                chip += betInfos[i].betVal * outNums.odd_even.dividend;
            }
            if (isSameString(outNums.color.kind, betInfos[i].kind)) {
                profits = true;
                chip += betInfos[i].betVal * outNums.color.dividend;
            }
            if (isSameString(outNums.column.kind, betInfos[i].kind)) {
                profits = true;
                chip += betInfos[i].betVal * outNums.column.dividend;
            }
            if (_ranNum == betInfos[i].num) {
                profits = true;
                chip += betInfos[i].betVal * inNums.dividend;
            }

            if (!profits) {
                chip -= betInfos[i].betVal;
            }
        }
        beginNum = betInfos.length; //初期化したかったけど難しそう
    }
}

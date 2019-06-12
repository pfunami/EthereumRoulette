pragma solidity ^0.5.8;

//ディーラーとプレイヤー
contract Environment {
    address public dealer;
    address public player;

    function setPlayer() public {
        dealer = 0xc289e22143536dB9e0556d87E45dC17cF3f84aCD;
        player = msg.sender;
    }
}


contract Num {

    struct outsideBet {
        uint num;
        string type;
        uint256 dividend;
    }

    struct insideBet {
        string type;
        uint256 dividend;
    }

    struct Outside {
        outsideBet range;
        outsideBet color;
        outsideBet odd_even;
        outsideBet high_low;
        outsideBet column;
    }

    Outside[36] public outNums;
    insideBet[36] public inNums;    //将来的に枠線上ルールを設置

    function init(int num) public {
        //inside
        inNums[num].dividend = 36;
        inNums[num].type = "Straight Up";

        //outside
        Outside memory number;
        /*range*/
        number.range.dividend = 3;
        if (num == 0) {
            number.range.type = "ZERO";
        } else if (num <= 12) {
            number.range.type = "SMALL";
        } else if (num <= 24) {
            number.range.type = "MEDIUM";
        } else if (num <= 36) {
            number.range.type = "LARGE";
        }
        /*color*/
        number.color.dividend = 2;
        if (num == 0) {
            number.color.type = "none";
        } else if (num / 10 == 0 || num / 10 == 2) {
            if (num % 2 == 1 && num != 29) {
                number.color.type = "RED";
            } else {
                number.color.type = "BLACK";
            }
        } else {
            if ((num % 2 == 0 && num != 10) || num == 19) {
                number.color.type = "RED";
            } else {
                number.color.type = "BLACK";
            }
        }
        /*odd_even*/
        number.odd_even.dividend = 2;
        if (num == 0) {
            number.odd_even.type = "none";
        } else if (num % 2 == 1) {
            number.odd_even.type = "ODD";
        } else {
            number.odd_even.type = "EVEN";
        }
        /*high_low*/
        number.high_low.dividend = 2;
        if (num == 0) {
            number.high_low.type = "none";
        } else if (num <= 18) {
            number.high_low.type = "LOW";
        } else {
            number.high_low.type = "HIGH";
        }
        /*column*/
        number.column.dividend = 3;
        if (num == 0) {
            number.column.type = "none";
        } else if (num % 3 == 0) {
            number.column.type = "pat1";
        } else if (num % 3 == 1) {
            number.column.type = "pat2";
        } else {
            number.column.type = "pat3";
        }
        outNums[num] = number;

    }
}


/*　やっぱ乱数発生の指示はjsから出し、乱数生成自体は別言語で書いてそれを呼び出し、それをsolidityに渡すようにしようかな... */
//乱数生成
import "github.com/oraclize/ethereum-api/oraclizeAPI_0.5.sol";

contract RandomNumberOraclized is usingOraclize {
    uint public randomNumber;
    bytes32 public request_id;

    //function RandomNumberOraclized() public{
    // (1) Oraclize Address Resolver の読み込み
    // <OARアドレスを指定。deterministic OAR の場合、この行の指定は必要ない
    //OAR = OraclizeAddrResolverI(0x45831C2e2e081F7373003502D1D490e62b09A0dD);
    //}

    function request() public {
        // (2) OraclizeへWolframAlphaによる計算を依頼
        // デバッグのため、request_idにOraclizeへの処理依頼番号を保存しておきます
        request_id = oraclize_query("WolframAlpha", "random number between 0 and 36");
    }

    // (3) Oraclize側で外部処理が実行されると、この__callback関数を呼び出してくれる
    function __callback(bytes32 request_id, string memory result) public {
        if (msg.sender != oraclize_cbAddress()) {
            revert();
        }

        // (4) 実行結果resultをdrawnNumberへ保存
        randomNumber = parseInt(result);
    }
}


contract Play is Environment, Transaction {//transactionがnumを継承
    struct betInfo {
        string type;
        uint256 betVal;
        int nun;
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

    function betOut(string memory place, int number, uint256 betVal) public {//t=in,f=out
        bet_info.type = place;
        bet_info.betVal = betVal;
        bet_info.num = number;
        betInfos.push(bet_info);
    }

    function isSameString(string memory _origin, string memory _target) public pure returns (bool) {
        return keccak256(abi.encodePacked(_origin)) == keccak256(abi.encodePacked(_target));
    }

    function try(int _ranNum) public {
        init(_ranNum);
        bool profits = false;
        for (int i = 0; betInfos.length; i++) {
            if (isSameString(outNums[_ranNum].range.type, betInfos[i].type)) {
                profits = true;
                chip += betInfos[i].betVal * outNums[_ranNum].range.dividend;
            }
            if (isSameString(outNums[_ranNum].high_low.type, betInfos[i].type)) {
                profits = true;
                chip += betInfos[i].betVal * outNums[_ranNum].high_low.dividend;
            }
            if (isSameString(outNums[_ranNum].odd_even.type, betInfos[i].type)) {
                profits = true;
                chip += betInfos[i].betVal * outNums[_ranNum].odd_even.dividend;
            }
            if (isSameString(outNums[_ranNum].color.type, betInfos[i].type)) {
                profits = true;
                chip += betInfos[i].betVal * outNums[_ranNum].color.dividend;
            }
            if (isSameString(outNums[_ranNum].column.type, betInfos[i].type)) {
                profits = true;
                chip += betInfos[i].betVal * outNums[_ranNum].column.dividend;
            }
            if (_ranNum == betInfos[i].num) {
                profits = true;
                chip += betInfos[i].betVal * inNums[_ranNum].dividend;
            }

            if (!profits) {
                chip -= betInfos[i].betVal;
            }
        }
    }
}

contract Transaction is Num {
    /*状態変数の宣言*/
    string public name;         /*tokenの名前*/
    string public symbol;       /*tokenの単位*/
    uint8 public decimals;      /*小数点以下の桁数*/
    uint256 public totalSupply; /*tokenの総量*/
    uint256 public chip;
    mapping(address => uint256) public balanceOf; /*各アドレスの残高*/

    /*イベント通知*/
    event Transfer(address indexed from, address indexed to, uint256 value);

    /*コンストラクタ*/
    constructor(uint256 _supply, string memory _name, string memory _symbol, uint8 _decimals)public{
        balanceOf[msg.sender] = _supply;
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
        totalSupply = _supply;
        chip = 0;
    }

    /*送金*/
    function transfer(address _from, address _to, uint256 _value) public returns (bool) {

        /*不正送金チェック*/
        if (balanceOf[msg.sender] < _value) {
            return false;
            revert();
        }
        if (balanceOf[_to] + _value < balanceOf[_to]) {
            return false;
            revert();
        }

        /*送金アドレスと受信アドレスの残高を更新*/
        balanceOf[_from] -= _value;
        balanceOf[_to] += _value;

        /*イベント通知*/
        emit Transfer(msg.sender, _to, _value);
        return true;
    }
}

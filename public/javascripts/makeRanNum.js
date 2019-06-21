// cryptoをインポート
const crypto = require('crypto');

// crypto.randomBytes()で生成するときのバイト数
const nBytes = 4;
// nBytesの整数の最大値
const maxValue = 4294967295;

// [0.0, 1.0]区間でセキュアな乱数を生成する
exports.secureRandom = function () {
    // nBytesバイトのランダムなバッファを生成する
    const randomBytes = crypto.randomBytes(nBytes);
    // ランダムなバッファを整数値に変換する
    const r = randomBytes.readUIntBE(0, nBytes);
    // 最大値で割ることで、[0.0, 1.0]にする
    return r / maxValue;
}
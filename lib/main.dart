import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const JankenPage(),
    );
  }
}

// ページに動きをつける場合はstf(StatefulWidget)を使用する
class JankenPage extends StatefulWidget {
  const JankenPage({super.key});

  @override
  State<JankenPage> createState() => _JankenPageState();
}

class _JankenPageState extends State<JankenPage> {
  // 変数はここに書く
  String myHand = '👊';
  String computerHand = '👊';
  // 勝敗を保持する変数
  String result = '引き分け';
  // 回数
  var play = 0;
  var win = 0;
  var lose = 0;

  // 関数定義もstateの中で行う
  void slectHand(String selectedhand) {
    myHand = selectedhand;
    print(myHand);
    play += 1;
    // コンピュータの手を決める
    generateComputerHand();
    // 勝敗の判定
    judge();
    setState(() {});
  }

  // ランダムでじゃんけんの生成をする関数
  void generateComputerHand() {
    // nextInt()の括弧の中に与えた数字より小さい値を最高値としたランダムな数を生成する
    // 3であれば 0, 1, 2,　がランダムで生成される。
    final randomNumber = Random().nextInt(3);
    computerHand = randomNumberToHand(randomNumber);
  }

  // ランダム生成された数値を絵文字に変換する
  String randomNumberToHand(int randomNumber) {
    // 数字を絵文字に変換
    switch (randomNumber) {
      case 0:
        return '👊';
      case 1:
        return '✌️';
      case 2:
        return '🖐️';
      default:
        return '👊';
        break;
    }
  }

  // 勝敗判定の関数
  void judge() {
    if (myHand == computerHand) {
      result = '引き分け';
    } else if (myHand == '👊' && computerHand == '✌️' ||
        myHand == '✌️' && computerHand == '🖐️' ||
        myHand == '🖐️' && computerHand == '👊') {
      result = '勝ち';
      win += 1;
    } else {
      result = '負け';
      lose += 1;
    }
    if (play == 6) {
      play = 0;
      win = 0;
      lose = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    // UIはここに書いていく
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'じゃんけん',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  play.toString() + '回目',
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                Text(
                  win.toString() + '回勝ち',
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                Text(
                  lose.toString() + '回負け',
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Text(
              result,
              style: const TextStyle(
                fontSize: 32,
              ),
            ),
            const SizedBox(height: 48),
            Text(
              computerHand,
              style: const TextStyle(fontSize: 40),
            ),
            const SizedBox(height: 48),
            Text(
              myHand,
              style: const TextStyle(
                fontSize: 32,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    slectHand('👊');
                  },
                  child: const Text('👊'),
                ),
                ElevatedButton(
                  onPressed: () {
                    slectHand('✌️');
                  },
                  child: const Text('✌️'),
                ),
                ElevatedButton(
                  onPressed: () {
                    slectHand('🖐️');
                  },
                  child: const Text('🖐️'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// dartの関数
// [返り値の型] [関数の名前]([引数の型] [引数の名前]){
// [実行する処理]
//} 
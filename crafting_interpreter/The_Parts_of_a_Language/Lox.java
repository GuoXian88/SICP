package com.craftinginterpreters.lox;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.charset.Charset;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.List;

//函数入口
public class Lox {
  // 内部私有成员指示是否产生错误
  static boolean hadError = false;

  public static void main(String[] args) throws IOException {
    if (args.length > 1) {
      System.out.println("Usage: jlox [script]");
    } else if (args.length == 1) { // 接收一个参数的时候是通过文件路径读文件执行
      runFile(args[0]);
    } else {// 没有参数就弹出命令行交互
      runPrompt();
    }
  }

  private static void runFile(String path) throws IOException {
    byte[] bytes = Files.readAllBytes(Paths.get(path)); // 文件路径--> byte
    run(new String(bytes, Charset.defaultCharset())); // byte --> string encode
    // Indicate an error in the exit code
    if (hadError) // 执行错误抛错
      System.exit(65);
  }

  private static void runPrompt() throws IOException {
    InputStreamReader input = new InputStreamReader(System.in);// 输入流
    BufferedReader reader = new BufferedReader(input);// 输入流-->buffer

    for (;;) {
      System.out.print("> ");
      run(reader.readLine());// buffer转string(readLine内部?)
      hadError = false;
    }
  }

  // string-->tokens
  private static void run(String source) {
    Scanner scanner = new Scanner(source);
    List<Token> tokens = scanner.scanTokens();

    // For now, just print the tokens.
    for (Token token : tokens) {
      System.out.println(token);
    }
  }

  /*
   * 分离出错的代码和报错的代码  TODO: Ideally, we would have an actual abstraction, some k
   * nd of “ErrorReporter” interface that gets passed to the scanner and 
   * arser  o that we can swap out different reporting strategies.
   * 
   */
  static void error(int line, String message) {
    report(line, "", message);
  }

  private static void report(int line, String where, String message) {
    System.err.println("[line " + line + "] Error" + where + ": " + message);
    hadError = true;
  }

}

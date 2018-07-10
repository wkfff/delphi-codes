AQTimeSuper命令行方式。


自动化运行AQTime工程，并处理运行结果。

AQTimeSuper [-h] [-p aqtimeprojectfile] [-s] [-a accessfile] [-o outputfile]

  -h 命令行帮助信息
  -p 运行aqtime的工程
  aqtimeprojectfile aqtime的工程文件
  -s 将分析结果提交到sql-server服务器上
  -a 将分析结果保存到access数据库文件中，要保证该文件已存在
  accessfile access数据库文件
  -o 将类的内存泄露信息保存到文件中
  outputfile 内存泄露信息文件


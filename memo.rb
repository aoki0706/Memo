require "csv"

while true
  puts "new(新規でメモを作成)"
  puts "add(既存のメモに追記)"
  puts "read(既存のメモを表示)"
  puts "end(メモを終了する)"
  memo_type = gets.chomp

  # ---新規メモを作成---
  if memo_type == "new"
    puts "拡張子を除いたファイル名を入力してください"
    new_memo_title = gets.chomp
    puts "メモしたい内容を記入してください(Ctrl+Dで決定)"
    new_memo_text = STDIN.read.chomp
    CSV.open(new_memo_title + ".csv", "w") do |csv|
      csv << [new_memo_text]
    end
    puts ""
    puts "CSVファイルに保存されました"
    puts "-----------------------"
    puts "ファイル名: " + new_memo_title
    puts new_memo_text
    puts "-----------------------"
    puts ""

  # ---既存のメモを編集---
  elsif memo_type == "add"
    puts "-------メモ一覧---------"
    Dir.foreach(".") do |item|
      next if item == "." or item == ".."
      if item == ".DS_Store" or item == "memo.rb" or item == ".git"
      else
        puts item
      end
    end
    puts "----------------------"
    puts "上記より編集したいファイル名を拡張子を除いて入力してください"
    add_memo_title = gets.chomp
    CSV.open("#{add_memo_title}.csv", "a") do |csv|
      puts "#{add_memo_title}.csvに追記する内容を記入してください(Ctrl+Dで決定)"
      add_memo_text = STDIN.read.chomp
      csv << [add_memo_text]
    end
    puts ""
    puts "CSVファイルに保存されました"
    puts "-----------------------"
    puts "ファイル名: " + add_memo_title
    CSV.foreach("#{add_memo_title}.csv") do |row|
      puts row[0]
    end
    puts "-----------------------"
    puts ""

  # ---既存のメモを表示---
  elsif memo_type == "read"
    puts "-------メモ一覧---------"
    Dir.foreach(".") do |item|
      next if item == "." or item == ".."
      if item == ".DS_Store" or item == "memo.rb" or item == ".git"
      else
        puts item
      end
    end
    puts "----------------------"
    puts "上記より表示したいファイル名を拡張子を除いて入力してください"
    read_memo_title = gets.chomp
    puts "----------------------"
    puts "ファイル名: " + read_memo_title
    CSV.foreach("#{read_memo_title}.csv") do |row|
      puts row[0]
    end
    puts "----------------------"
  
  elsif memo_type == "end"
    break

  else
    puts "'new','add','read'のいずれかを入力してください"
  end
end


require 'minitest/autorun'

class SampleTest < MiniTest::Test
  def test_すべてがオブジェクト
    assert_equal '1', '1'.to_s
    assert_equal '1', 1.to_s
    assert_equal '', nil.to_s
    assert_equal 'true', true.to_s
    assert_equal 'false', false.to_s
    assert_equal '(?-mix:\\d+)', /\d+/.to_s
  end

  def test_メソッド呼び出し
    assert_equal '1', 1.to_s()          # 数値の1を文字列に変換する (カッコあり)
    assert_equal '1',1.to_s            # 数値の1を文字列に変換する (カッコなし)
    assert_equal 'a',10.to_s(16) # 数値を16進数の文字列に変換する (カッコあり)

    ret = 10.to_s 16  # 数値を16進数の文字列に変換する (カッコなし)
    assert_equal'a', ret
  end

  def test_文の区切り
    # セミコロンを使って、3つの文を1行に押し込める
    assert_equal('1', 1.to_s); assert_equal('', nil.to_s); assert_equal('a', 10.to_s(16))

    # ( で開業しているので、カッコが閉じられるまで改行してもエラーにならない
    assert_equal('a',
    10.to_s(
          16
    ))

    # バックスラッシュを使って改行して書く
    assert_equal'a', \
10.to_s(16)
  end

  def test_変数の宣言と代入
    # 2つの値を同時に代入する
    a, b = 1, 2
    assert_equal 1, a
    assert_equal 2, b

    # 右辺の数が少ない場合はnilが入る
    c, d = 10
    assert_equal 10, c
    assert_nil d

    # 右辺の数が多い場合ははみ出した値が切り捨てられる
    e, f = 100, 200, 300
    assert_equal 100, e
    assert_equal 200, f
  end

  def test_文字列
    assert_output("こんにちは\nさようなら\n") { puts "こんにちは\nさようなら" }
    assert_output("こんにちは\\nさようなら\n") { puts 'こんにちは\nさようなら' }

    name = 'Alice'
    assert_equal 'Hello, Alice!', "Hello, #{name}!"
    assert_equal 'Hello, #{name}!', 'Hello, #{name}!'
    assert_equal 'Hello, #{name}!', "Hello, \#{name}!"

    i = 10
    assert_equal '10は16進数にするとaです', "#{i}は16進数にすると#{i.to_s(16)}です"

    assert_equal 'こんにちは\nさようなら', "こんにちは\\nさようなら"
  end

  def test_文字列の比較
    assert_equal true, 'ruby' == 'ruby'
    assert_equal false, 'ruby' == 'Ruby'
    assert_equal true, 'ruby' != 'perl'
    assert_equal false, 'ruby' != 'ruby'

    assert_equal true, 'a' < 'b'
    assert_equal false, 'a' < 'A'
    assert_equal true, 'a' > 'A'
    assert_equal true, 'abc' < 'def'
    assert_equal false, 'abc' < 'ab'
    assert_equal true, 'abc' < 'abcd'
    assert_equal true, 'あいうえお' < 'かきくけこ'
  end

  def test_数値
    assert_equal 1000000000, 1_000_000_000

    assert_equal 30, 10 + 20
    assert_equal 75, 100 - 25
    assert_equal 60, 12 * 5
    assert_equal 4, 20 / 5

    n = 1
    assert_equal -1, -n

    assert_equal 0, 1 / 2

    assert_equal 0.5, 1.0 / 2
    assert_equal 0.5, 1 / 2.0

    n = 1
    assert_equal 1.0, n.to_f
    assert_equal 0.5, n.to_f / 2

    assert_equal 2, 8 % 3

    assert_equal 8, 2 ** 3
  end

  def test_演算子の優先順位
    assert_equal 23, 2 * 3 + 4 * 5 - 6 / 2
    assert_equal -7, 2 * (3 + 4) * (5 - 6) / 2
  end

  def test_変数に格納された数値の増減
    n = 1

    n += 1
    assert_equal 2, n

    n -= 1
    assert_equal 1, n

    n = 2

    n *= 3
    assert_equal 6, n

    n /= 2
    assert_equal 3, n

    n **= 2
    assert_equal 9, n
  end

  def test_数値と文字列は暗黙的に変換されない
    e = assert_raises TypeError do
      1 + '10'
    end
    assert_equal 'String can\'t be coerced into Fixnum', e.message

    assert_equal 11, 1 + '10'.to_i
    assert_equal 11.5, 1 + '10.5'.to_f

    number = 3
    e = assert_raises TypeError do
      'Number is ' + number
    end
    assert_equal 'no implicit conversion of Fixnum into String', e.message

    assert_equal 'Number is 3', 'Number is ' + number.to_s
    assert_equal 'Number is 3', "Number is #{number}"
  end

  def test_小数を使う場合は丸め誤差に注意
    assert_equal false, 0.1 * 3.0 == 0.3
    assert_equal false, 0.1 * 3.0 <= 0.3

    # Rationalクラスであれば期待した通りに値の比較ができる
    assert_equal true, 0.1r * 3r == 0.3
    assert_equal true, 0.1r * 3r <= 0.3
  end

  def test_リテラル
    # ソースコードに直接埋め込むことができる値のことをリテラルという
    assert_equal Fixnum, 123.class
    assert_equal String, 'Hello'.class
    assert_equal Array, [1, 2, 3].class
    assert_equal Hash, {'japan' => 'yen', 'us' => 'dollar', 'india' => 'ruppe'}.class
    assert_equal Regexp, /\d+-\d+/.class
  end

  def test_sample
    assert_equal 'RUBY', 'ruby'.upcase
  end
end
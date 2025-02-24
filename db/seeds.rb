# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Question.create(
    text: "Q1. 大きな荷物を持って横断歩道を渡ろうとしているおばあさんがいました。あなたならどうしますか？",
    option1: "大きな荷物を運びながら横断歩道を渡るのは危ないので荷物を持ってあげる",
    option2: "横断歩道の前まで荷物を持って来れたのだからそれなりに力もありそうだし大丈夫だろうということで何もしない",
    option3: "「ちんたら歩いてんじゃねぇ」と暴言を吐く",
    value1: "3",
    value2: "2",
    value3: "0"
)

Question.create(
    text: "Q2.友達が「ほんと痩せたいからダイエットするわ〜」と言いながら唐揚げを頬張っていました。あなたならどうしますか？",
    option1: "唐揚げを食べてたらダイエットなんかできないよと言って心を鬼にして友達の唐揚げを食べてあげる",
    option2: "「そうなんだ。頑張れ」と応援だけしてあげる",
    option3: "唐揚げは油で揚げているから0カロリーだしどんどん食べなと言い、ダイエットの邪魔をする",
    value1: "3",
    value2: "1",
    value3: "0"
)

Question.create(
    text: "Q3. 外国人が道に迷って困っている様子です。あなたは全く英語を話せません。あなたならどうしますか？",
    option1: "スマホの翻訳機能を使って身振り手振りで助けてあげる",
    option2: "きっと英語を話すことができる人がなんとかするので、自分は何もせずに通り過ぎる",
    option3: "外国人に近づき、日本語で捲し立てて、日本の厳しさを教える",
    value1: "3",
    value2: "1",
    value3: "0"
)

Question.create(
    text: "Q4.あなたはやっとの思いでドラゴンボールを7つ集めることができました。どのようなお願いをしますか？",
    option1: "世界中の人たちが平和に楽しく暮らせるようにしてほしいと願う",
    option2: "不老不死と永遠の若さをお願いする",
    option3: "自分が世界征服をして好き勝手暴れ回りたいと願う",
    value1: "3",
    value2: "1",
    value3: "0"
)

Question.create(
    text: "Q5.イメチェンした友達の髪型がめちゃくちゃダサかったです。あなたならどうしますか？",
    option1: "ダサいと思っている自分の価値観を疑い、友達の髪型を褒める",
    option2: "その髪型はダサすぎるから美容院で直してもらってこいと言って自分の行きつけの美容院に連れて行く",
    option3: "「ほんとイメチェンしたね〜」と含みのある言葉を言う",
    value1: "3",
    value2: "1",
    value3: "0"
)

Question.create(
    text: "Q6.自販機で飲み物を買いたいけど1万円札しか持ってなくて買えないと友達が困っていました。あなたならどうしますか？",
    option1: "「また今度自分も同じように困ってたら奢って」と言って買ってあげる",
    option2: "自分も１万円札しか持ってないと言って何もしない",
    option3: "友達が飲みたそうにしていた物を買い、友達の前でおいしそうに飲む",
    value1: "3",
    value2: "1",
    value3: "0"
)

Question.create(
    text: "Q7.道を歩いていると前から３段のアイスクリームを持った女の子が走って来て、自分とぶつかってしまい、アイスクリームが自分のズボンについてしまいました。あなたならどうしますか？",
    option1: "「悪ィな。おれのズボンがアイスクリームを食っちまった。次ァ５段を買うといい」と言ってお金を渡す",
    option2: "女の子には何も言わないが、女の子が去った後にSNSで話を盛りまくって投稿する",
    option3: "親御さんを呼び出し謝罪させ、ズボンを買った値段の10倍の金額を請求する",
    value1: "3",
    value2: "1",
    value3: "0"
)

Question.create(
    text: "Q8.少し離れたところで人が倒れていました。あなたはどうしますか？",
    option1: "とりあえず駆け寄って状態を確認し、必要そうなら救急車を呼ぶ",
    option2: "きっと誰かが助けてくれるだろうから、そのまま通り過ぎる",
    option3: "倒れている人の様子を動画撮影し、SNSに面白おかしく投稿する",
    value1: "3",
    value2: "1",
    value3: "0"
)

Question.create(
    text: "Q9.道端に財布が落ちていました。あなたはどうしますか？",
    option1: "すぐに近くの交番に届ける",
    option2: "財布の中身が減っていたら自分が盗んではないかと疑われるかもしれないので、そのまま通り過ぎる",
    option3: "拾った人の物だから持ち帰り、自分の物にする",
    value1: "3",
    value2: "1",
    value3: "0"
)

Question.create(
    text: "Q10.あなたはいい人ですか？",
    option1: "はい！",
    option2: "周りから良い人と言われることが度々ある",
    option3: "わからない",
    value1: "100",
    value2: "3",
    value3: "1"
)

# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength

namespace :entry do
  desc 'Create lt entries for event id 2'
  task create_lt: :environment do
    ActiveRecord::Base.transaction do
      event = Event.find_by(id: 2)
      category = Category.find_by!(category_name: 'lt')

      lightning_talks = [
        { name: '@yasulab (安川 要平)', title: 'Ruby + YAML + Git でデータ管理していたことで国の地域 KPI に貢献できた話' },
        { name: '新卒えんじにゃ', title: '自作ゲームに使えるgem作ってみた' },
        { name: 'kaiba', title: 'RailsとKamalと多くの無料枠で個人開発サービスを作るのは最高なのではということに気づいてしまった俺達は' },
        { name: 'Yasuo Honda', title: '私のRails開発環境' },
        { name: 'maimu', title: 'Gentoo 1年生、ビルドは終わらない' },
        { name: 'kishima', title: 'M5UnifiedとPicoRubyで楽しむM5シリーズ' },
        { name: 'joker1007', title: 'DHHもすなるLinuxデスクトップといふものを、Rubyistもしてみむとてするなり' },
        { name: 'Shu Oogawara (@expajp)', title: 'あなたの知らないDateのひみつ' },
        { name: 'shishi', title: '完全環境再現兵器nix' },
        { name: 'kei-q', title: "持て余しているO'Reilly Learning Platformをもっと活用したい" },
        { name: 'Lni_T / ルニ', title: 'ruby.wasmはどこでも動くのか？ ― みんな！オラに検証機を分けてくれ！' },
        { name: 'lef237', title: '人生で初めてRubyのgemをリリースした話' },
        { name: 'sugiwe', title: 'ViewファーストなRailsアプリ開発のたのしさ' },
        { name: 'dak2', title: ' MCP Security Best Practices に見る MCP のセキュリティリスクと`modelcontextprotocol/ruby-sdk` の authorization の現在地' },
        { name: 'yancya', title: 'RubyKaigi 2026 の宿は、やんちゃハウスで！' },
        { name: '仁藤慎平', title: '小5息子に「Rubyではじめる電子工作~ラジコンを作ろう~」でRuby沼に沈めてみた' },
        { name: '鍋谷 武典', title: '私がわかっていなかった ruby の挙動の紹介' },
        { name: '5hun', title: 'ぼっちが秘める可能性 〜孤高のRubyistが語る交流会サバイバル術〜' },
        { name: 'fd0', title: 'Ruby on Cygwin 2025年11月号' },
        { name: 'hirokiej', title: 'METs to the Future -This is Ruby' },
        { name: 'siso255', title: '自作アプリにViewComponentを導入した' },
        { name: 'neko317', title: 'るびま王チャレンジ' },
        { name: 'Yusa', title: '「イベント駆動開発」のススメーコミュニティ参加で加速する開発モチベーション' },
        { name: '久保トークン', title: 'テスト自動化の0歩目' },
        { name: 'yokomaru', title: '12%のRailsエンジニアに向けたMinitest setupの話' },
        { name: 'yttrium173340', title: 'Ruby で SPARQL やってみた【総集編】' }
      ]

      lightning_talks.each do |lightning_talk|
        user = User.create!(name: lightning_talk[:name])

        Entry.create!(
          user_id: user.id,
          category_id: category.id,
          event_id: event.id,
          title: lightning_talk[:title]
        )
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength

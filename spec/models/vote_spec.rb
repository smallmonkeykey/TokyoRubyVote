# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Vote, type: :model do
  describe 'validates' do
    context 'コメントが300文字以内の場合' do
      it '有効であること' do
        vote = build(:vote, comment: 'a' * 300)
        expect(vote).to be_valid
      end
    end

    context 'コメントが301文字以上の場合' do
      it '無効であること' do
        vote = build(:vote, comment: 'a' * 301)
        expect(vote).to_not be_valid
      end
    end

    context 'ユーザーが同じエントリーに2回投票した場合' do
      it '無効であること' do
        user = create(:user)
        entry = create(:entry)

        create(:vote, user:, entry:)
        second_vote = build(:vote, user:, entry:)

        expect(second_vote).to_not be_valid
      end
    end
  end

  describe 'scopes' do
    let(:event1)  { create(:event, :event1) }
    let(:event2)  { create(:event, :event2) }
    let(:category_food)  { create(:category, :food) }
    let(:category_drink) { create(:category, :drink) }

    let(:user1) { create(:user) }
    let(:user2) { create(:user, name: 'user2', uid: 'user2uid') }

    let(:entry_food_event1)  { create(:entry, :entry1, category: category_food,  event: event1, user: user1) }
    let(:entry_food_event2)  { create(:entry, :entry2, category: category_food,  event: event2, user: user1) }
    let(:entry_drink_event1) { create(:entry, title: 'ワイン', category: category_drink, event: event1, user: user1) }

    let!(:vote1) { create(:vote, entry: entry_food_event1,  user: user2) }
    let!(:vote2) { create(:vote, entry: entry_food_event2,  user: user2) }
    let!(:vote3) { create(:vote, entry: entry_drink_event1, user: user2) }

    describe '.for_event' do
      it '指定したevent_idの投票のみ返すこと' do
        results = Vote.for_event(event1.id)

        expect(results).to match_array([vote1, vote3])
        expect(results).to_not include(vote2)
      end
    end

    describe '.for_category' do
      it '指定したカテゴリーの投票だけ返すこと' do
        results = Vote.for_category('food')

        expect(results).to include(vote1, vote2)
        expect(results).to_not include(vote3)
      end
    end
  end

  describe 'class method' do
    let(:event1)  { create(:event, :event1) }
    let(:category_food)  { create(:category, :food) }
    let(:category_drink) { create(:category, :drink) }

    let(:user1) { create(:user) }
    let(:user2) { create(:user, name: 'user2', uid: 'user2uid') }
    let(:user3) { create(:user, name: 'user3', uid: 'user3uid') }
    let(:user4) { create(:user, name: 'user4', uid: 'user4uid') }
    let(:user5) { create(:user, name: 'user5', uid: 'user5uid') }

    let(:entry1) { create(:entry, :entry1, category: category_food, event: event1, user: user1) }
    let(:entry2) { create(:entry, :entry2, category: category_food, event: event1, user: user1) }
    let(:entry3) { create(:entry, title: 'ビール', category: category_drink, event: event1, user: user1) }
    let(:entry4) { create(:entry, title: '肉巻き', category: category_food, event: event1, user: user2) }
    let(:entry5) { create(:entry, title: 'おにぎり', category: category_food, event: event1, user: user3) }

    let!(:vote1) { create(:vote, entry: entry1, user: user2, comment: 'おいしい') }
    let!(:vote2) { create(:vote, entry: entry1, user: user3) }
    let!(:vote3) { create(:vote, entry: entry1, user: user4, comment: 'おいしかったです') }
    let!(:vote4) { create(:vote, entry: entry1, user: user5) }
    let!(:vote5) { create(:vote, entry: entry2, user: user2) }
    let!(:vote6) { create(:vote, entry: entry2, user: user3) }
    let!(:vote7) { create(:vote, entry: entry2, user: user4) }
    let!(:vote8) { create(:vote, entry: entry4, user: user3) }
    let!(:vote9) { create(:vote, entry: entry4, user: user4) }
    let!(:vote10) { create(:vote, entry: entry5, user: user4) }

    describe '.ranking_by_single' do
      it '票数を獲得した順番にエントリーを並べる（単品王の上位３人をきめる）' do
        results = Vote.ranking_by_single

        first = results.first
        expect(first.name).to eq(user1.name)
        expect(first.votes_count).to eq(4)

        second = results.second
        expect(second.name).to eq(user1.name)
        expect(second.votes_count).to eq(3)

        third = results.third
        expect(third.name).to eq(user2.name)
        expect(third.votes_count).to eq(2)
      end
    end
    describe '.ranking_by_total_votes' do
      it 'ユーザーごとの合計票数を多い順に返すこと(合算王の上位３人をきめる)' do
        results = Vote.ranking_by_total_votes

        first = results.first
        expect(first.name).to eq(user1.name)
        expect(first.votes_count).to eq(7)

        second = results.second
        expect(second.name).to eq(user2.name)
        expect(second.votes_count).to eq(2)

        third = results.third
        expect(third.name).to eq(user3.name)
        expect(third.votes_count).to eq(1)
      end
    end

    describe '.fetch_comment' do
      it 'コメントのある投票のみ返すこと(2件)' do
        results = Vote.fetch_comment

        expect(results.size).to eq(2)
      end
    end

    describe '.fetch_group_comment' do
      it 'カテゴリーごとのコメント付きの投票を返すこと' do
        results = Vote.fetch_group_comment
        categories = results.map(&:category_name)

        expect(categories).to include('food')
        expect(categories).to_not include('drink')
      end
    end
  end
end

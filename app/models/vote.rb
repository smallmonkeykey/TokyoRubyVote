# frozen_string_literal: true

class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :entry

  validates :comment, length: { maximum: 300 }
  validate :cannot_vote_for_same_entry

  scope :for_event, lambda { |event_id|
    joins(:entry).where(entries: { event_id: })
  }

  scope :for_category, lambda { |category_name|
    joins(entry: :category).where(categories: { category_name: })
  }

  def self.ranking_by_single
    joins(entry: :user)
      .select('entries.id AS entry_id, COUNT(votes.id) AS votes_count, entries.title AS title, users.name AS name')
      .group('entries.id', 'entries.title', 'users.name')
      .order('votes_count DESC')
      .limit(3)
  end

  def self.ranking_by_total_votes
    joins(entry: :user)
      .select('COUNT(votes.id) AS votes_count, string_agg(distinct entries.title, \',\') AS titles, users.name AS name')
      .group('entries.user_id', 'users.name')
      .order('votes_count DESC')
      .limit(3)
  end

  def self.fetch_comment
    joins(entry: :user)
      .where.not(votes: { comment: [nil, ''] })
      .select('entries.id AS entry_id, entries.title AS title, users.name AS name, votes.comment AS comment')
      .order('entries.user_id')
  end

  def self.fetch_group_comment
    joins(entry: %i[category user])
      .select('entry_id, entries.title, users.name, categories.category_name')
      .where.not(comment: [nil, ''])
      .group(:entry_id, 'entries.title', 'users.name', 'categories.category_name')
      .order('categories.category_name ASC')
  end

  private

  def cannot_vote_for_same_entry
    return unless user.votes.exists?(entry_id:)

    errors.add(:base, 'すでに投票しているため、投票できません。')
  end
end

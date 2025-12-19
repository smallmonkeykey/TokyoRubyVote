# frozen_string_literal: true

# rubocop:disable Metrics/MethodLength
module ApplicationHelper
  def default_meta_tags
    {
      site: 'TokyuRubyVote',
      title: 'TokyuRuby会議での投票に関するサービス',
      reverse: true,
      charset: 'utf-8',
      description: 'TokyuRubyVoteでは、TokyuRuby会議でのエントリー、投票、結果をみることができます。',
      keywords: 'TokyuRuby',
      canonical: request.original_url,
      separator: '|',
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        type: 'website',
        url: request.original_url,
        image: image_url('tokyu.png'),
        locale: 'ja_JP'
      },
      twitter: {
        card: 'summary',
        image: image_url('tokyu.png')
      }
    }
  end
end
# rubocop:enable Metrics/MethodLength

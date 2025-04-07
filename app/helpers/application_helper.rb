# frozen_string_literal: true

module ApplicationHelper
  # rubocop:disable Metrics/MethodLength, Layout/LineLength
  # meta_tagが多く、description部分でどうしてもメソッドが長くなってしまうため、上記のrubocopルールを除外
  def default_meta_tags
    {
      site: 'BookRIn',
      title: 'リアルタイムで輪読会の記録を共同編集できるサービス',
      reverse: true,
      charset: 'utf-8',
      description: 'BookRInでは、リアルタイムでメンバーと輪読会の記録を残すことが出来ます。テンプレート機能を用いることで、主催者はフォーマットを毎回用意する必要がなく、輪読会の準備に時間をかける必要がありません。',
      keywords: '輪読会, 共同編集',
      canonical: request.original_url,
      separator: '|',
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        type: 'website',
        url: request.original_url,
        image: image_url('ogp.png'),
        local: 'ja-JP'
      },
      twitter: {
        card: 'summary_large_image',
        site: '@obvyamdrss',
        image: image_url('ogp.png')
      }
    }
  end
  # rubocop:enable Metrics/MethodLength, Layout/LineLength
end

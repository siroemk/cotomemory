# frozen_string_literal: true

module ApplicationHelper
  def default_meta_tags
    {
      site: 'Cotomemory コトバのキオクをキロクしよう',
      reverse: true,
      charset: 'utf-8',
      description: 'Cotomemoryは子供の可愛い名言を簡単に記録できるサービスです。家族と名言を共有することができます。',
      keywords: '子育て, 子供, こども, 名言',
      og: {
        title: :title,
        type: 'website',
        site_name: 'Cotomemory',
        description: :description,
        image: image_url('ogp.png'),
        url: 'https://cotomemory.com'
      },
      twitter: {
        card: 'summary_large_image',
        site: '@siroemk'
      }
    }
  end
end

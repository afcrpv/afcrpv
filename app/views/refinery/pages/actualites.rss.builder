# encoding: UTF-8

xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title Refinery::Core.site_name
    xml.description Refinery::Core.site_name + " Actualités de la pharmacovigilance"
    xml.link refinery.url_for(Refinery::Page.find_by_path("/actualites").url.merge(only_path: false))

    @pv_news.each do |news_item|
      xml.item do
        xml.title news_item.title
        xml.description news_item.description
        xml.pubDate news_item.created_at.to_s(:rfc822)
        xml.link refinery.polymorphic_url([get_demodulized_class(news_item), news_item])
      end
    end
  end
end

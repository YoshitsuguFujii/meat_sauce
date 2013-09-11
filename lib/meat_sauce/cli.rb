# encoding: utf-8
require "thor"
require "nokogiri"
require "selenium-webdriver"
require "anemone"

#require 'pry'

module MeatSauce
  class UrlFormatError < StandardError;end
  class CLI < Thor
    # class_option :url, :required => true, :aliases => "-u" なんかhelp見れなくなるからrequireをコメントアウト
    class_option :url, aliases: "-u"
    class_option :browser , type: :string, default: "firefox", aliases: "-b"

    desc "scraping", "指定したタグの中身を抜き出します(specific tag inside extracted)" # {{{
    method_option :tag, :required => true, :aliases => "-t"
    method_option :only_text, type: :boolean,  default: true, aliases: "-o"
    def scraping
      open_driver do |driver|
        html = driver.page_source
        doc = Nokogiri::HTML(html)

        doc.css(options[:tag]).each do |tag|

          if options[:only_text]
            puts tag.inner_text
          else
            puts tag.inner_html
          end
        end
      end
    end # }}}

    desc "show_source", "ソースを表示します(retrive http source)" # {{{
    def show_source
      open_driver do |driver|
        puts driver.page_source
      end
    end # }}}

    desc "show_links", "指定した深さまでリンクの一覧を表示します(Display the link of the specified depth)" # {{{
    method_option :depth_limit, type: :numeric, aliases: "-d"
    method_option :skip_query_string, type: :boolean, default: true, aliases: "-s"
    def show_links(call_as_function = false)
      opts = {
        skip_query_strings: options[:skip_query_string]
      }
      opts.merge!(depth_limit: options[:depth_limit]) unless options[:depth_limit].nil?

      url = []
      Anemone.crawl(url_complement(options[:url]), opts) do |anemone|
        anemone.on_every_page do |page|
          url << page.url
        end
      end

      if call_as_function
        return url
      else
        puts url.join("\n")
      end
    end # }}}

    desc "capture", "指定した深さまで画面のスクリーンショットを取ります(Screenshot the link of the specified depth page)" # {{{
    method_option :file_path, required: true, aliases: "-f"
    method_option :depth_limit, type: :numeric, default: 0, aliases: "-d"
    def capture
      links = show_links(true)
      open_driver do |driver|
        if options[:depth_limit] == 0
          # スクリーンショットを取る
          driver.save_screenshot(options[:file_path])
        else

          links.each_with_index do |link, idx|
            driver.navigate.to(link.to_s)
            driver.save_screenshot(path_add_suffix(options[:file_path], idx))
          end
        end
      end
    end # }}}

    private # {{{
      # 有効なURL書式かどうか
      def url_complement(url_path)
        if url_path.nil?
          say("'--url' または '-u'オプションでurlを指定してください (No value provided for required options '--url')", :red)
        end

        url = url_path
        unless url_path.start_with?("http://")
          url = "http://" + url
        end

        raise UrlFormatError, "invalid url" if URI.regexp.match(url).nil?
        return url
      end

      def open_driver
        # ブラウザ起動
        # :chrome, :firefox, :safari, :ie, :operaなどに変更可能
        driver = Selenium::WebDriver.for(options[:browser].to_sym)

        # urlにアクセス
        driver.navigate.to(url_complement(options[:url]))

        yield(driver) if block_given?

      ensure
        # ブラウザ終了
        driver.quit if defined?(driver)
      end

      def path_add_suffix(path, idx)
        dir_path ||= File.dirname(path)
        ext_name ||= File.extname(path)

        file_name = File.basename(path, ext_name)
        [dir_path, "/" ,file_name,"_#{idx.to_s}",ext_name].join
      end
    # end private }}}
  end
end

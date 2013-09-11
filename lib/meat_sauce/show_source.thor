class ShowSource < MeatSauce::CLI
  # desc "引数説明", "コマンド説明文"
  desc "show_source", "retrive http source"
  # メソッド名=サブコマンド名
  method_option :url, :required => true, :aliases => "-u"
  method_option :tag, :type => :string, :default => "", :aliases => "-t"
  def show_source
    # ブラウザ起動
    # :chrome, :firefox, :safari, :ie, :operaなどに変更可能
    driver = Selenium::WebDriver.for(options[:browser].to_sym)

    # Googleにアクセス
    driver.navigate.to(url_complement(options[:url]))

    puts driver.page_source
  ensure
    # ブラウザ終了
    driver.quit if defined?(driver)
  end
end

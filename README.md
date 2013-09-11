# MeatSauce

ページをスクレイピングしたり、スクリーンショットを撮ったり  
scraping web page, screen shot web page ....

## Installation

Add this line to your application's Gemfile:

    gem 'meat_sauce'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install meat_sauce

## Usage

### 使えるコマンド表示(show subcommand)
```ruby
$ meat_sauce
Tasks:
  meat_sauce capture -f, --file-path=FILE_PATH  # 指定した深さまで画面のスクリーンショットを取ります(Screenshot the link of the specified depth page)
  meat_sauce help [TASK]                        # Describe available tasks or one specific task
  meat_sauce scraping -t, --tag=TAG             # 指定したタグの中身を抜き出します(specific tag inside extracted)
  meat_sauce show_links                         # 指定した深さまでリンクの一覧を表示します(Display the link of the specified depth)
  meat_sauce show_source                        # ソースを表示します(retrive http source)

Options:
  -u, [--url=URL]          
  -b, [--browser=BROWSER]  
                           # Default: firefox
```


###コマンド詳細(command description)
 
**各コマンド共通(every method common option)**

option	| abbreviation 		|  explain
:----------		|:----------		|:----------
--url     |-u   | target url
--browser | -b | select browser(default firefox)

<br />

**サブコマンド(sub command)**

+   **`capture`**   
screen shot web page  
WEBページのスクリーンショットを撮ります

option	| abbreviation 		|  explain
:----------		|:----------		|:----------
--file-path     |-f   | 画像の保存先を指定します(save file path)
--depth-limit | -d |  URLを起点に取得するリンクの深さを指定<br />(The depth of the link acquired with URL as the starting point is specified. default 0)

+   **`scraping`**   
retrieve text inner tag  
WEBページのタグの中身を取得します

option	| abbreviation 		|  explain
:----------		|:----------		|:----------
--tag | -t | target tag
only-text | -o | text only default true)

<br />

+   **`show_links `**   
get all link in page  
ページの全てのリンクを取得します

option	| abbreviation 		|  explain
:----------		|:----------		|:----------
--depth-limit | -d |  URLを起点に取得するリンクの深さを指定<br />(The depth of the link acquired with URL as the starting point is specified. default 0)

<br />

+   **`show_source `**   
get http source  
ページのソースを取得します  


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
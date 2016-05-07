#
#  По непонятной мне пока причине автоматический запуск этого скрипта не приводит к корректной установке.
#  Извините, сейчас нет времени разбираться.
#  Выполняйте команды в баше вручную и смотрите, что происходит
#
# @url http://michaelchelen.net/81fa/install-jekyll-2-ubuntu-14-04/

sudo apt-get update

sudo apt-get install -y git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev


cd
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
exec $SHELL

git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
exec $SHELL

git clone https://github.com/rbenv/rbenv-gem-rehash.git ~/.rbenv/plugins/rbenv-gem-rehash

rbenv install 2.2.3
rbenv global 2.2.3
#ruby -v

sudo apt-get install -y make gcc nodejs
gem install jekyll
gem install github-pages
gem install jekyll-tagging
gem install jekyll-paginate
gem install pygments.rb
gem install redcarpet

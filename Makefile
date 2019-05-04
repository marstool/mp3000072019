all:

include Makefile.env

up:
	git push -u origin master
e:
	vim Makefile.env
m:
	vim Makefile
gs:
	git status
gc:
	git commit -a
	

gd :
	git diff

ga :
	git add .

rg:regen
regen:
	[ -f config.toml ] && make regenX || make regenX -C scripts.Hugo 
regenX:
	rm -fr public/*
	cp ../CNAME public/
	[ -f public/CNAME ] || ( echo ; echo "why no CNAME ? exit" ; echo ; exit 32 )
	hugo

s : server
server:
	hugo server

# hddps://themes.gohugo.io/
# hddps://gohugo.io/themes/

gen00:
	tree -H '.' -L 1 --noreport --charset utf-8 > index.html

PWD01:=$(shell basename $$(realpath .))
gen:
	cd public/ && rm -f CNAME index.html
	cd public/ && tree -H 'http://marstool.github.io/$(PWD01)' --noreport --charset utf-8 > index.html
	[ ! -f index.html ] || cat index.html > public/index.html 
	make sed01
	make sed02
	cp CNAME public/
	cat config > .git/config
	@echo
	@grep jjj123 CNAME 
	@echo
	@grep marstool .git/config
	@echo
	diff config .git/config
	@echo

sed01:
	sed -i \
		-e '/meta name=/d' \
		-e '/ by Steve Baker and Thomas Moore/d' \
		-e '/ by Francesc Rocher/d' \
		-e '/ by Florian Sesser/d' \
		-e '/ by Kyosuke Tokoro/d' \
		public/index.html

#	<a href=".">.</a><br>
#	└── <a href="./index.html">index.html</a><br>

sed02Text:=<a href="http://marstool.github.io/mp3s">marstool.github.io</a>
sed02:
	sed -i \
	-e 's;<a href=".">.</a>;$(sed02Text);g' \
	-e 's;<a href="./index.html">index.html</a>;$(sed02Text);g' \
	-e 's;<h1>Directory Tree</h1>;<h1>$(sed02Text)</h1>;g' \
		public/index.html


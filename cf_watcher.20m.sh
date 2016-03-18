#!/bin/bash

MAINPATH='/Users/a12091/bitbar'
TMP=$MAINPATH'/tmp'

echo 'CF watcher 👀| color=#7808FF'
echo "---"

function save_html {
 rm -f $TMP/*.txt
  COUNT=1
  for url in $@
  do
    curl $url 2> /dev/null > $TMP/$COUNT.txt
    if [ -s $TMP/$COUNT.txt ]; then
        echo "url#$url" >> $TMP/$COUNT.txt
        COUNT=`expr $COUNT + 1`
    else
        echo "取得エラー"
    fi
  done
}

function get_image {
    rm -rf $TMP/$2
    curl -o $TMP/$2  $1 2> /dev/null
    /usr/bin/sips --resampleWidth 50 $TMP/$2 --out $TMP/$2 > /dev/null 2>&1
    IMG=`base64 $TMP/$2`
    echo $IMG
}






# makuake
echo "makuake | color=black"
MAKUAKE_URLS=$(ruby $MAINPATH/lib/yaml.rb $MAINPATH/config/watcher.yml makuake)


# get html & save
save_html $MAKUAKE_URLS

# html parse
for filepath in $TMP/*.txt
  do
    if [ -s $filepath ]; then
    PERCENT=`cat $filepath | grep -e 'stbarin' | cut -d":" -f2 | cut -d";" -f1`
    TITLE=`cat $filepath | grep -e '<title>' | sed -e 's/<[^>]*>//g' | cut -d"|" -f1 | sed -e 's/ //g'`
    PRICE=`cat $filepath | grep -e 'stMoneyNum' | cut -d">" -f2 | sed -e 's/<\/p//g'`
    ENDTIME=`cat $filepath | grep -e 'var end = ' | cut -d"=" -f2 | sed -e 's/[ |;]//g'`
    NOWTIME=`/bin/date +"%s"`
    DIFF=`expr $ENDTIME - $NOWTIME`
    LASTDAY=`expr $DIFF / 86400`
    LINK=`cat $filepath | grep -e 'url#' | cut -d"#" -f2`
    IMGPATH=`cat $filepath | grep -e '690_388' | cut -d"\"" -f2`
    IMGFILE=`cat $filepath | grep -e '690_388' | cut -d"\"" -f2 | cut -d"/" -f8`
    IMG=`get_image https:$IMGPATH $IMGFILE`
    echo "$TITLE | size=12 image=${IMG} href=$LINK"
    echo "├ $PERCENT | size=12"
    echo "├ $PRICE | size=12"
    echo "└ Last$LASTDAY days | size=12"
    fi
  done
echo "---"

# camp-fire
echo "camp-fire | color=black"
CAMPFIRE_URLS=$(ruby $MAINPATH/lib/yaml.rb $MAINPATH/config/watcher.yml camp-fire)


# get html & save
save_html $CAMPFIRE_URLS


# html parse
for filepath in $TMP/*.txt
  do
    if [ -s $filepath ]; then
    PERCENT=`cat $filepath |  grep -e '<div class="meter"><div class="meter-in"><div class="bar' | cut -d":" -f2 | cut -d";" -f1`
    TITLE=`cat $filepath | grep -e '<title>' | sed -e 's/<[^>]*>//g' | cut -d"-" -f1`
    PRICE=`cat $filepath | grep -e 'number' | sed -e 's/<[^>]*>//g' | grep -e "円" | tr -d '\t'`
    LASTDAY=`cat $filepath | grep -e 'number' | sed -e 's/<[^>]*>//g' | grep -e "日" | tr -d '\t'`
    LINK=`cat $filepath | grep -e 'url#' | cut -d"#" -f2`
    IMGPATH=`cat $filepath | grep -e 'og:image' | cut -d"\"" -f4`
    IMGFILE=`cat $filepath | grep -e 'og:image' | cut -d"\"" -f4 | cut -d"/" -f8`
    IMG=`get_image $IMGPATH $IMGFILE`
    echo "$TITLE | size=12 image=${IMG} href=$LINK"
    echo "├ $PERCENT | size=12"
    echo "├ $PRICE | size=12"
    echo "└ Last $LASTDAY days | size=12"
    fi
  done

echo "---"

# readyfor
echo "readyfor | color=black"
READYFOR_URLS=$(ruby $MAINPATH/lib/yaml.rb $MAINPATH/config/watcher.yml readyfor)

# get html & save
save_html $READYFOR_URLS

# html parse
for filepath in $TMP/*.txt
  do
    if [ -s $filepath ]; then
    PERCENT=`cat $filepath | grep -e 'Gauge__txt' | sed -e 's/<[^>]*>//g'`
    TITLE=`cat $filepath | grep -e "og:title" | sed -e 's/<meta property="og:title" content="//g' | cut -d"-" -f1 | sed -e 's/ //g'`
    PRICE=`cat $filepath | grep -e 'Project-visual__condition-dd is-sum' | sed -e 's/<[^>]*>//g' | sed -e 's/ //g'`
    LASTDAY=`cat $filepath | grep -e 'time-left-to-publish-days' | sed -e 's/<[^>]*>//g' | sed -e 's/ //g'`
    LINK=`cat $filepath | grep -e 'url#' | cut -d"#" -f2`
    IMGPATH=`cat $filepath | grep -e 'og:image' | cut -d"\"" -f4 | cut -d"?" -f1`
    IMGFILE=`cat $filepath | grep -e 'og:image' | cut -d"\"" -f4 | cut -d"?" -f1 | cut -d"/" -f7`
    IMG=`get_image $IMGPATH $IMGFILE`
    echo "$TITLE | size=12 image=${IMG} href=$LINK"
    echo "├ $PERCENT | size=12"
    echo "├ $PRICE | size=12"
    echo "└ Last $LASTDAY days | size=12"
    fi
  done


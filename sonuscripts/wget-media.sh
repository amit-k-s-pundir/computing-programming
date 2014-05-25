#/bin/bash

suggestedName="test.flv"
logFileName=wget-log-"$suggestedName"
logFileDir="/opt/downloads/wget-log"
logFile="${logFileDir}"/"${logFileName}".log
directoryPrefix="/opt/downloads/latest/today"
ua="Mozilla/5.0 (X11; Linux i686; rv:26.0) Gecko/20100101 Firefox/26.0"
referer="http://xhamster.com/movies/1188837/she_sits_on_him.html"
#referer="${2}"
#oFileName="${3}"
#oFile="${directoryPrefix}/${oFileName}"
#echo $logFile

wget -c -N -a "$logFile" -U $ua --header="User-Agent: $ua" -P $directoryPrefix --header="Accept: */*" --header="Connection: Keep-Alive" --header="Referer: $referer" $1

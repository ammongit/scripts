#!/bin/bash
# convenience script for automating timelapse creation
# from still images using ffmpeg.
#
# Copyright (c) 2014 Dan Panzarella
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE. 


help="Usage: 
`basename $0` [OPTS] IMG_FORMAT OUTFILE
	-h  help
	-s starting image sequence number (default 1)
	-e ending image sequence number
	-q quality: 0-9  (default 7)
	-r resolution (default 1920x1080)
	-f framerate/fps (default 24)
"
start_num="1"
resolution="1920x1080"
quality="7"
frames="24"
end=false
length=""


# parse options
while getopts :hq:s:r:e:f: opt; do
	case "$opt" in
	    h)
	        echo "$help"
	        exit 0
	        ;;
	    \?)
	        echo "Invalid arg: -$OPTARG" >&2
	        echo "$help"
	        exit 1
	        ;;
	    :)
	        echo "$help"
	        echo "-$OPTARG requires an argument" >&2
	        exit 1
	        ;;
	    q)  quality="$OPTARG" ;;
	    s)  start_num="$OPTARG" ;;
	    r)  resolution="$OPTARG" ;;
	    f)  frames="$OPTARG"  ;;
	    e)
	        end=true
	        end_num="$OPTARG"
	        ;;
	esac
done


# get positional params
name_format=${@:$OPTIND:1}
out_name=${@:$OPTIND+1:1}

if [ -z "$name_format" ]; then
	echo "filename format is required" >&2
	echo "$help"
	exit 1
fi
if [ -z "$out_name" ]; then
	echo "output filename is required" >&2
	echo "$help"
	exit 1
fi


#translate 0-9 quality scale to ffmpeg quality
case "$quality" in
	0)
	    speed="ultrafast"
	    crf="28"
	    ;;
	1)
	    speed="superfast"
	    crf="28"
	    ;;
	2)
	    speed="veryfast"
	    crf="27"
	    ;;
	3)
	    speed="faster"
	    crf="26"
	    ;;
	4)
	    speed="fast"
	    crf="24"
	    ;;
	5)
	    speed="medium"
	    crf="22"
	    ;;
	6)
	    speed="slow"
	    crf="21"
	    ;;
	7)
	    speed="slower"
	    crf="20"
	    ;;
	8)
	    speed="veryslow"
	    crf="18"
	    ;;
	9)
	    speed="veryslow"
	    crf="0"
	    ;;
	*)
	    speed="slower"
	    crf="20"
	    ;;
esac


#calculate number of frames from start and end
if $end; then
	length="-vframes $((end_num - start_num))"
fi

ffmpeg -f image2 -framerate "$frames" -start_number "$start_num" -i "$name_format" $length -s "$resolution" -c:v libx264 -pix_fmt yuv420p -preset "$speed" -crf "$crf" "$out_name" 



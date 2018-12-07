#!/bin/sh
cd /root/public/blogs
git add .
git ci -am 'submit blogs'
git push

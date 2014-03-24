#!/bin/bash

rake generate
rake deploy

# 推送源代码
sh push_source.sh

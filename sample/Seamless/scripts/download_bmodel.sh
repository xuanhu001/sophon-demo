#!/bin/bash
res=$(which unzip)

if [ $? != 0 ];
then
    echo "Please install unzip on your system!"
    exit
fi
pip3 install dfss -i https://pypi.tuna.tsinghua.edu.cn/simple --upgrade
scripts_dir=$(dirname $(readlink -f "$0"))

pushd $scripts_dir

# models
if [ ! -d "../models/BM1684X" ];
then
    mkdir -p ../models/BM1684X
    python3 -m dfss --url=open@sophgo.com:sophon-demo/Seamless/online/streaming_s2t_BM1684X.zip
    unzip streaming_s2t_BM1684X.zip
    mv streaming_s2t_BM1684X/* ../models/BM1684X
    rm -r streaming_s2t_BM1684X
    rm -f streaming_s2t_BM1684X.zip
    echo "streaming bmodel download!"
    python3 -m dfss --url=open@sophgo.com:sophon-demo/Seamless/m4t_offline/m4t_s2t_BM1684X.zip
    unzip m4t_s2t_BM1684X.zip
    mv m4t_s2t_BM1684X/* ../models/BM1684X
    rm -r m4t_s2t_BM1684X
    rm -f m4t_s2t_BM1684X.zip
    echo "m4t bmodel download!"

    python3 -m dfss --url=open@sophgo.com:sophon-demo/Seamless/punc_ct-transformer_zh-cn-common-vad_realtime-vocab272727.zip
    unzip punc_ct-transformer_zh-cn-common-vad_realtime-vocab272727.zip -d ../models
    rm -f punc_ct-transformer_zh-cn-common-vad_realtime-vocab272727.zip
    echo "punc models download!"

    python3 -m dfss --url=open@sophgo.com:sophon-demo/Seamless/tokenizer.model
    mv tokenizer.model ../models
    echo "tokenizer model download!"
else
    echo "Models folder exist! Remove it if you need to update."
fi
popd
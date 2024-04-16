#!/bin/bash
if [ ! $1 ]; then
    target=bm1684x
    target_dir=BM1684X
else
    target=${1,,}
    target_dir=${target^^}
fi

outdir=../models/$target_dir

function gen_mlir_decoder()
{
    model_transform.py \
        --model_name auto-sam_decoder \
        --model_def ../models/onnx/vit-b-auto-multi_mask.onnx \
        --input_shapes [[$1,256,64,64],[64,1,2],[64,1],[64,1,256,256],[1],[2]] \
        --output_names /Concat_3_output_0,/Slice_2_output_0,iou_predictions,low_res_masks \
        --mlir sam_auto_decoder_$1b.mlir
}

function gen_fp32bmodel_decoder()
{
    model_deploy.py \
        --mlir sam_auto_decoder_$1b.mlir \
        --quantize F32 \
        --chip $target \
	--model SAM-ViT-B_auto_multi_decoder_fp32_$1b.bmodel

    mv SAM-ViT-B_auto_multi_decoder_fp32_$1b.bmodel $outdir/decode_bmodel
}


pushd $model_dir
if [ ! -d $outdir ]; then
    mkdir -p $outdir/decode_bmodel
else
    echo "Models folder exist! "
fi

# batch_size=1
gen_mlir_decoder 1
gen_fp32bmodel_decoder 1

popd
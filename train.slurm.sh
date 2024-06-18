#!/bin/bash
#SBATCH --job-name=vae_train
#SBATCH --output=vae_train.out
#SBATCH --error=vae_train.err
#SBATCH --gres=gpu:4

VAE=vaes.py
train_seq=/data2/log-l/wazhang/protein_sequences/prot.exper/6M_train
target_seq=/data2/log-l/wazhang/protein_sequences/prot.exper/6M_test

n_latent=2
n_hidden=512
n_gen=1048576
n_epoch=32
n_batch=128

echo -e "\n\nTrain"
python $VAE l${n_latent}_${n_gen} train sVAE $train_seq $n_latent $n_hidden --epoch ${n_epoch} --batch_size ${n_batch}
echo -e "\n\nPlot latent"
python $VAE l${n_latent}_${n_gen} plot_latent $train_seq
echo -e "\n\nTVD"
python $VAE l${n_latent}_${n_gen} TVD $target_seq
echo -e "\n\nGenerate sequences"
python $VAE l${n_latent}_${n_gen} gen $n_gen -o gen_l${n_latent}_${n_gen}

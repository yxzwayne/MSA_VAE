Description
===========

Code to run and validate VAEs fit to protein MSA data. This implementation provides an abstract base class to help with implementation of new VAE architectures, as well as plotting functionality. This code was developed for publication \[1\] and was use to make the plots.

This implementation builds on the code from \[2\] hosted [here](https://github.com/samsinai/VAE_protein_function), which itself appears related to the example VAE code provided with the Keras library provided [here](https://github.com/keras-team/keras/blob/2.0.0/examples/variational_autoencoder.py). Both previous implementations are under MIT license. The Keras code has since been updated, hosted [here](https://github.com/keras-team/keras-io/blob/master/examples/generative/vae.py). 

Related repositories: 

* https://github.com/ahaldane/Mi3-GPU provides the implementation for the Potts model used in [1], as well as helper scripts useful to process MSA data.
* https://github.com/ahaldane/HOM_r20 provides a script used to make the "r20" plots used in [1] based on the VAE output.

\[1\] TBD, Upcoming.

\[2\] Sam Sinai, Eric Kelsic, George M. Church, and Martin A. Nowak. Variational auto-encoding of protein sequences. [\[arXiv:1712.03346\]](https://arxiv.org/abs/1712.03346) \[cs, q-bio\], January 2018.


Setup
=====

Requirements:

 * Python modules: Keras, scipy, maplotlib.
 * C compiler

Run "make" to compile the helper module for loading sequence files. After compiling, a file seqtools.xxx.so should have been created.

Usage
=====

The vaes.py script is the main tool, and will output usage info when run.

The run.sh script shows example commands, including the exact commands used to create the figures in the main and supplementary text of \[1\].

Run the vaes.py script in one of the following ways:

To train a new model:
---------------------

    $ vaes.py my_name train Church_VAE trainingMSA 2 250

"my_name" is a name for use as prefix for output files (pickled VAE). 
"train" tells the script to run in training mode. 
"Church_VAE" tells the script to use the Church VAE (can also be Deep_VAE, test_VAE)
"trainingMSA" is the file (MSA) to train on. The MSA should be formatted as one sequence per line, without any header lines or other info (see the Mi3-GPU docs).
"2" is the number of latent dimensions.
"250" is the size of the encoder/decoder layers for the church VAE (only necessary for Church_VAE, other vaes have different options here).

Optional arg:
 "--TVDseqs msafile" will track the TVD of the hamming distance distribution on each epock, and make a plot.

In this mode the script will create create plots of the loss function over epochs, and a csv file containing the loss over epochs.


To generate sequences:
----------------------

    $ vaes.py my_name gen 100000 -o gen100K

"my_name" is the name prefix for pickled VAE & output files.
"gen" tells the script to run in sequence generation mode. 
1000000 is the # of sequences to generate.
The "-o" option specifies the output file.

To compute energies
-------------------

    $ vaes.py my_name energy MSAfile --ref_energy E.npy

"my_name" is the name prefix for pickled VAE & output files.
"energy" tells the script to run in energy computation mode. 
"MSAfile" is the MSA to compute energies for
--ref_energy (optional) is reference energies to include in comparison plot


To Plot the Latent Space
------------------------

    $VAE my_name plot_latent trainingMSA

Will create some png files of the latent space.

Other computations:
------------------------

See the "run.sh" file. Can also compute TVD plot, C correlation plot, and more.


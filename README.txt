ASSIGNMENT 1 - HILL CIPHER

The assignement consists in mainly 6 modules:

1) matrix_multi.vhd
2) key_loader.vhd
3) key_inverter.vhd
5) Multiplexer.vhd
6) D_FF.vhd

All these 6 modules were put together in the hill_cipher.vhd final module.

In addition to these main modules, other ones were created for comparing purposes.

The matrix_multi_sub.vhd the struct_matrix_multi.vhd and the struc_key_loader.

Moreover, each module (except for the D_FF.vhd) has a simulation waveform (.wvf) 
for testing purposes.The multiplier.wvf is use to test the matrix_multi.vhd and 
the struct_matrix_multi.vhd modules. The key_loader.wvf is used to test 
the key_loader.vhd and the struc_key_loader.vhd modules.

Furthermore, the Hill_cipher.vhd module uses an lpm_ROM component. The .mif file 
where it takes the outputs from is the mult_inv_16.mif file.
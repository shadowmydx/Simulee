In DetectBug.py, all functions start with "test_" are detecting data race & barrier divergence bugs, and all functions start with "performance_sync" are used to detect unnecessary barrier functions.

kaldi:
```
test_copy_low_upp()
test_copy_upp_low()
test_add_diag_vec_mat()
test_copy_from_tp()
test_copy_from_mat()
test_slice()
```

thundersvm:
```
test_thundersvm_c_smo_solve_kernel()
```

CUDA-CNN
```
performance_sync_cuda_cnn_g_getCost_3()
```

CudaSift:
```
performance_sync_FindMaxCorr()
# same situation for FindMaxCorr1, FindMaxCorr2, FindMaxCorr3
```

cudpp
```
performance_sync_cudpp_sparseMatrixVectorSetFlags()
# same situation for yGather, sparseMatrixVectorFetchAndMultiply.
```


Positive feedback from authors:
```
https://github.com/cudpp/cudpp/issues/180
https://github.com/Celebrandil/CudaSift/issues/38
```

Raw bug log located in
```
./raw_data_report_script
```

Git log parser script located in another repo:
```
https://github.com/shadowmydx/empirical_script
```

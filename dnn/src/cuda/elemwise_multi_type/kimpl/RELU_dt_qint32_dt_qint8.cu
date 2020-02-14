/**
 * \file dnn/src/cuda/elemwise_multi_type/kimpl/RELU_dt_qint32_dt_qint8.cu
 * MegEngine is Licensed under the Apache License, Version 2.0 (the "License")
 *
 * Copyright (c) 2014-2020 Megvii Inc. All rights reserved.
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT ARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 */
// generated by gen_elemwise_multi_type_kern_impls.py
#define KERN_IMPL_MODE(cb) MEGDNN_ELEMWISE_MODE_ENABLE(RELU, cb)
#define KERN_IMPL_ARITY 1
#define KERN_IMPL_STYPE dt_qint32
#define KERN_IMPL_DTYPE dt_qint8
#include "../kern_impl.inl"
